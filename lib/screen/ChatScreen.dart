import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shivalik_institute/model/CommonResponseModel.dart';
import 'package:shivalik_institute/model/MessageSchema.dart';
import 'package:shivalik_institute/utils/xls_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../constant/firebase_constant.dart';
import '../model/GroupResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/full_screen_image.dart';
import '../utils/pdf_viewer.dart';
import 'GroupProfileScreen.dart';
import 'WebViewContainer.dart';

class ChatScreen extends StatefulWidget {
  final bool isFormConvList;
  const ChatScreen(this.isFormConvList, {super.key});

  @override
  BaseState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  
  late Stream<QuerySnapshot> messagesStream;
  TextEditingController replyController = TextEditingController();

  List<MessageSchema> listMessages = [];
  bool isSendButtonVisible = false;
  String selectedMedia = '';
  String documentID = '';
  bool _isLoading = false;
  List<UserList> listUser = [];


  bool isFormConvList = false;

  ScrollController chatScrollController = ScrollController();


  @override
  void initState(){
    _getPeoplesList();
    isFormConvList = (widget as ChatScreen).isFormConvList;
    messagesStream = firestoreInstance
        .collection(batch)
        .doc(sessionManager.getBatchId() ?? '')
        .collection(messages)
        .orderBy('timestamp', descending: false)
        .snapshots();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayButton,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: appBg,
        leading: InkWell(
          borderRadius: BorderRadius.circular(52),
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupProfileScreen(listUser)));
          },
            child: getTitle('SIRE Connect')
        ),
      ),
      body: Column(
        children: [
          const Gap(12),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }

                if (!snapshot.hasData)
                  {
                    return const SizedBox();
                  }
                else
                  {
                    moveToBottom();
                    listMessages = [];
                    var messages = snapshot.data!.docs;

                    for (var message in messages)
                    {
                      var getSet = MessageSchema(
                        senderId: message['sender_id'],
                        sender: message['sender'],
                        content: message['content'],
                        type: message['type'],
                        fileName: message['file_name'] ?? '',
                        documentId: message['document_id'] != null ? message['document_id'] ?? '' : '',
                        isEdited: message['is_edited'],
                        isDelete: message['is_delete'],
                        timestamp: Timestamp.now()
                      );
                      listMessages.add(getSet);
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                        controller: chatScrollController,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: listMessages.length,
                        itemBuilder: (context, index) {
                          //final isDifferentDate = previousMessage == null || getDayFromTimestamp(currentMessage.timestamp) != getDayFromTimestamp(previousMessage?.timestamp);

                          final lastIndex = index < listMessages.length - 1 ? index + 1 : index;

                          final isDifferentDateNew = getDayFromTimestamp(listMessages[index].timestamp) != getDayFromTimestamp(listMessages[lastIndex].timestamp);

                          print("isDifferentDateNew === ${isDifferentDateNew}");

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onLongPress: () {
                              if (sessionManager.getUserId() == listMessages[index].senderId)
                                {
                                  messageActionDialog(listMessages[index]);
                                }
                            },
                            child: Column(
                              mainAxisAlignment: sessionManager.getUserId() == listMessages[index].senderId  ? MainAxisAlignment.end : MainAxisAlignment.start,
                              crossAxisAlignment: sessionManager.getUserId() == listMessages[index].senderId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: isDifferentDateNew,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 5),
                                    decoration: BoxDecoration(color: white, border: Border.all(color: white), borderRadius: BorderRadius.circular(8)),
                                    child: Text(getDayFromTimestamp(listMessages[index].timestamp),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: gray, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),

                                if (listMessages[index].isDelete ??false)
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: listMessages[index].senderId != sessionManager.getUserId() ? 20 : 80,
                                        right: listMessages[index].senderId != sessionManager.getUserId() ? 80 : 20,
                                        bottom: 6
                                    ),
                                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          sessionManager.getUserId() == listMessages[index].senderId ? "You deleted this message." : "This message was deleted.",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const Gap(6),
                                        Text(
                                          timeStampToDateTimeForMsg(listMessages[index].timestamp),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(fontSize: 12, color: graySemiDark, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  listMessages[index].type == "media"
                                      ? Container(
                                        margin: EdgeInsets.only(top: 4, bottom: 4, left: sessionManager.getUserId() == listMessages[index].senderId  ? 50 : 12 , right: sessionManager.getUserId() == listMessages[index].senderId ? 12 : 50),
                                        decoration: BoxDecoration(color: white, border: Border.all(color: white), borderRadius: BorderRadius.circular(8)),
                                        child: GestureDetector(
                                          onTap: () {
                                            List<String> listImage = [];
                                            listImage.add(listMessages[index].content.toString());

                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return FullScreenImage("", listImage, index);
                                            }));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(color: white, border: Border.all(color: white), borderRadius: BorderRadius.circular(8)),
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.zero,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                  visible: listMessages[index].senderId != sessionManager.getUserId(),
                                                  child: Text(
                                                    listMessages[index].sender ?? '',
                                                    style: const TextStyle(
                                                        color: graySemiDark,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                                const Gap(6),
                                                listMessages[index].content?.isNotEmpty ?? false
                                                    ? listMessages[index].content?.startsWith("https") ?? false
                                                    ? FadeInImage.assetNetwork(
                                                      image: listMessages[index].content.toString().trim(),
                                                      fit: BoxFit.cover,
                                                      placeholder: 'assets/images/cover_thumb.jpg',
                                                      height: 140,
                                                      width: MediaQuery.of(context).size.width,
                                                    )
                                                    : Image.file(File(listMessages[index].content ?? ''), fit: BoxFit.cover,height: 140,width: MediaQuery.of(context).size.width,)
                                                    : Image.asset('assets/images/cover_thumb.jpg', fit: BoxFit.fill,height: 140,width: MediaQuery.of(context).size.width,),
                                                const Gap(6),
                                                Text(
                                                  timeStampToDateTimeForMsg(listMessages[index].timestamp),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(fontSize: 12, color: graySemiDark, fontWeight: FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      : listMessages[index].type == "document"
                                      ? GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () async {
                                          if (getFileExtension(listMessages[index].fileName ?? '') == ".pdf")
                                          {
                                            startActivity(context, PdfViewer(listMessages[index].content ?? '', '0'));
                                          }
                                          else if (getFileExtension(listMessages[index].fileName ?? '') == ".xlsx")
                                          {
                                            if (await canLaunchUrl(Uri.parse(listMessages[index].content ?? '')))
                                              {
                                                launchUrl(Uri.parse(listMessages[index].content ?? ''),mode: LaunchMode.externalApplication);
                                              }
                                          }
                                          else
                                          {
                                            if (await canLaunchUrl(Uri.parse(listMessages[index].content ?? '')))
                                            {
                                              launchUrl(Uri.parse(listMessages[index].content ?? ''),mode: LaunchMode.externalApplication);
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: listMessages[index].senderId != sessionManager.getUserId() ? 20 : 80,
                                              right: listMessages[index].senderId != sessionManager.getUserId() ? 80 : 20,
                                              bottom: 6
                                          ),
                                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Visibility(
                                                visible: listMessages[index].senderId != sessionManager.getUserId(),
                                                child: Text(
                                                  listMessages[index].sender ?? '',
                                                  style: const TextStyle(
                                                      color: graySemiDark,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              const Gap(6),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: grayGradient,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(getFileIcon(getFileExtension(listMessages[index].fileName ?? '')),width: 36,height: 36,),
                                                    const Gap(8),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(listMessages[index].fileName ?? '',style: const TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 12),),
                                                        Text(getFileExtension(listMessages[index].fileName ?? ''),style: const TextStyle(color: graySemiDark,fontWeight: FontWeight.w500,fontSize: 10),),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(6),
                                              Text(
                                                timeStampToDateTimeForMsg(listMessages[index].timestamp),
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(fontSize: 12, color: graySemiDark, fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                      : Container(
                                        margin: EdgeInsets.only(
                                            left: listMessages[index].senderId != sessionManager.getUserId() ? 20 : 80,
                                            right: listMessages[index].senderId != sessionManager.getUserId() ? 80 : 20,
                                            bottom: 6
                                        ),
                                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: listMessages[index].senderId != sessionManager.getUserId(),
                                              child: Text(
                                                listMessages[index].sender ?? '',
                                                style: const TextStyle(
                                                    color: graySemiDark,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                            Gap(listMessages[index].senderId != sessionManager.getUserId() ? 6 : 0),
                                            Text(
                                              listMessages[index].content ?? '',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Visibility(
                                                  visible: listMessages[index].isEdited ?? false,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Edited",
                                                        textAlign: TextAlign.end,
                                                        style: TextStyle(fontSize: 12, color: graySemiDark, fontWeight: FontWeight.w500),
                                                      ),
                                                      const Gap(4),
                                                      Container(
                                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: graySemiDark),
                                                        width: 4,
                                                        height: 4,
                                                      ),
                                                      const Gap(4),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  timeStampToDateTimeForMsg(listMessages[index].timestamp),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(fontSize: 12, color: graySemiDark, fontWeight: FontWeight.w500),
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          );
                        },
                    );
                  }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Platform.isIOS ? 22 : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: isSendButtonVisible ? 3 : 2,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
                      child: TextField(
                        cursorColor: black,
                        controller: replyController,
                        keyboardType: TextInputType.text,
                        style: getTextFiledStyle(),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty)
                              {
                                isSendButtonVisible = true;
                              }
                            else
                              {
                                isSendButtonVisible = false;
                              }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Type your message here....',
                          counterText: "",
                          contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                              borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                              borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: gray)),
                        ),
                      ),
                    )
                ),
                Visibility(
                  visible: isFormConvList,
                  child: GestureDetector(
                    onTap: () async {
                      _showActionDialog();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: brandColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: isSendButtonVisible ? 5 : 15),
                      child: Image.asset('assets/images/ic_attachment.png',
                        width: 22,
                        height: 22,
                        color: white,
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: isSendButtonVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Visibility(
                    visible: isSendButtonVisible,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (replyController.text.toString().trim().isNotEmpty)
                          {
                            _sendDataToFireStore(replyController.value.text.trim(),"text","");
                          }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(color: brandColor, border: Border.all(color: brandColor,width: 0.8), borderRadius: BorderRadius.circular(32.0)),
                        margin: const EdgeInsets.only(right: 5),
                        child: const Center(child: Icon(Icons.send, color: Colors.white,size: 18,)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void moveToBottom(){
    Timer(const Duration(milliseconds: 500),
            () => chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent));
  }

  messageActionDialog(MessageSchema getSet){
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              alignment: Alignment.centerRight,
              insetPadding: const EdgeInsets.only(left: 75,right: 75),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              backgroundColor: grayLight,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Wrap(
                    children: <Widget>[
                      Column(
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                Navigator.pop(context);
                                updateTxtBottomSheet(getSet);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Edit", style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w400),),
                                    Image.asset('assets/images/ic_edit_pencil.png',width: 18,height: 18,)
                                  ],
                                ),
                              )
                          ),
                          const Divider(color: graySemiDark,height: 0.7,thickness: 0.7,indent: 12,endIndent: 12,),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.pop(context);
                                deleteMessage(getSet.documentId ?? '');
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Delete", style: TextStyle(fontSize: 14,color: Colors.red,fontWeight: FontWeight.w400),),
                                    Image.asset('assets/images/ic_delete.png',width: 18,height: 18,color: Colors.red,)
                                  ],
                                ),
                              )
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
    );
  }

  updateTxtBottomSheet(MessageSchema getSet){
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = getSet.content ?? '';


    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      // barrierColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              controller: textEditingController,
                              cursorColor: black,
                              keyboardType: TextInputType.text,
                              style: getTextFiledStyle(),
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                              ),
                              onSubmitted: (value) async {
                                if (value.isNotEmpty) {
                                  await updateMessage(getSet.documentId ?? '', value);
                                }
                              },
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              var value = textEditingController.value.text;
                              updateMessage(getSet.documentId ?? '', value);
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(color: brandColor, border: Border.all(color: brandColor,width: 0.8), borderRadius: BorderRadius.circular(32.0)),
                              margin: const EdgeInsets.only(bottom: 5,right: 5),
                              child: const Center(child: Icon(Icons.send, color: Colors.white,)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> updateMessage(String messageId, String newText) async {
    try {
      await FirebaseFirestore.instance
          .collection(batch)
          .doc(sessionManager.getBatchId())
          .collection(messages)
          .doc(messageId)
          .update(
          {
            'content': newText,
            'is_edited' : true
          }
      );
      print('Message updated successfully');
    } catch (e) {
      print('Error updating message: $e');
    }
  }

  deleteMessage(String messageId,) async {
    try {
      await FirebaseFirestore.instance
          .collection(batch)
          .doc(sessionManager.getBatchId())
          .collection(messages)
          .doc(messageId)
          .update({'is_delete': true});
      print('Message deleted successfully');
    } catch (e) {
      print('Error deleted message: $e');
    }
  }

  void _showActionDialog() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: chatBoxBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  color: chatBoxBg),
              padding: const EdgeInsets.only(top: 22, left: 40, right: 40, bottom: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 58,
                          width: 58,
                          decoration: BoxDecoration(color: brandColor, border: Border.all(color: brandColor,width: 0.8), borderRadius: BorderRadius.circular(32.0)),
                          margin: const EdgeInsets.only(bottom: 5,right: 5),
                          child: const Center(child: Icon(Icons.photo_size_select_actual, color:white)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            child: const Text('Photos',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: black))
                        ),

                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImageFromCamera();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 58,
                          width: 58,
                          decoration: BoxDecoration(color:brandColor , border: Border.all(color: brandColor,width: 0.8), borderRadius: BorderRadius.circular(32.0)),
                          margin: const EdgeInsets.only(bottom: 5,right: 5),
                          child: const Center(child: Icon(Icons.camera_alt, color: white,)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            child: const Text('Camera',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: black))
                        ),

                      ],
                    ),
                  ),
                  Visibility(
                    // visible: !isFileUploading,
                    child: GestureDetector(
                      onTap: () {
                        // _sendDataToFireStore(selectedMedia);
                        // selectAndUploadImage(context, conversationData.conversationId);

                        _pickFile();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(color: brandColor, border: Border.all(color: brandColor,width: 0.8), borderRadius: BorderRadius.circular(32.0)),
                            margin: const EdgeInsets.only(bottom: 5,right: 5),
                            child: const Center(child: Icon(Icons.file_copy, color: white,)),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 10),
                              child: const Text('Document',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: black))
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickFile() async {
    try {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'docx','doc', 'ppt', 'pptx', 'xls', 'xlsx']);
      if (result != null) {
        var filepath = result.files.single.path!;
        var tempFile = File(filepath);
        _uploadDoc(tempFile, result.files.single.name, result.files.single.extension.toString(),'document');
      } else {
        // User canceled the picker
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      var pickedFiles = await ImagePicker().pickImage(source: ImageSource.camera);
      if(pickedFiles != null) {
        final filePath = pickedFiles.path;

        print("object----------");
        print(filePath);
        print(pickedFiles);
        _cropImage(filePath);

      }else{
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      var pickedFiles = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFiles != null) {
        final filePath = pickedFiles.path;
        _cropImage(filePath);

      } else {
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath
    );

    if (croppedFile != null) {
      setState(() {
        selectedMedia = croppedFile.path;
        print("_pickImage picImgPath crop ====>$selectedMedia");
        Navigator.pop(context);
        _uploadDoc(File(croppedFile.path), getFileNameWithExtension(croppedFile.path), getFileExtension(croppedFile.path),'media');
        // sendMediaRequest(context, conversationData.conversationId.toString(), selectedMedia);
        // Navigator.pop(context);
      });
    }
  }

  void _uploadDoc(File file, String fileName, String extension,String type) async {
    try {
      Navigator.pop(context);
      setState(() {
        //isFileUploading = true;
      });
      Reference reference = FirebaseStorage.instance.ref().child('SIRE/$fileName');
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      var imageUrl = await snapshot.ref.getDownloadURL();
      print("<><> : UPLOAD FILE :: $imageUrl");
      setState(() {
        //isFileUploading = false;
      });
      await _sendDataToFireStore(imageUrl, type,fileName);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _sendDataToFireStore(String content,String type, String fileName) async {
    replyController.text = "";

    var messageData = MessageSchema(
      type: type,
      content: content,
      sender: "${sessionManager.getName()} ${sessionManager.getLastName()}",
      senderId: sessionManager.getUserId() ?? '',
      timestamp: Timestamp.now(),
      fileName: fileName,
      passedDateFormate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      documentId: '',
      isDelete: false,
      isEdited: false
    );

    sendNotificationToUser(content,type);

    var messageSendQuery = await firestoreInstance.collection(batch).doc(sessionManager.getBatchId()).collection(messages).add(messageData.toJson());
    print('<><><><><><><>');
    print(messageSendQuery);

    DocumentSnapshot docSnap = await messageSendQuery.get();
    documentID = docSnap.reference.id;

    await FirebaseFirestore.instance
        .collection(batch)
        .doc(sessionManager.getBatchId())
        .collection(messages)
        .doc(documentID)
        .update({
      'document_id': documentID,
    });

    print('<><><><><><><>');
    print(documentID);

    await updateMemberDataOnFireBase(content,type);

   /* if(listDeviceTokens.isNotEmpty)
    {
      if (mentionedUsers.isNotEmpty)
      {

        for (ContactData user in conversationsController.groupParticipantGetSet.value)
        {
          if (mentionedUsers.containsValue(user.id))
          {
            await sendNotificationToMentionedUser(taskComment,user.name,user.id.toString());
          }
          else
          {
            await sendNotificationToUser(taskComment);
          }
        }
      }
      else
      {
        await sendNotificationToUser(taskComment);
      }
    }*/

  }

  updateMemberDataOnFireBase(String taskComment,String type) async {
    var updateData = {
      'last_message': {
        'content': taskComment,
        'senderId': sessionManager.getUserId() ?? '',
        'sender_name': "${sessionManager.getName()} ${sessionManager.getLastName()}",
        'timestamp': FieldValue.serverTimestamp(),
        'type': type
      },
      'message_count': FieldValue.increment(1),
    };


    // Update Conversation Document Data to group collection
    final groupDocRef = firestoreInstance
        .collection(batch)
        .doc(sessionManager.getBatchId());

    await groupDocRef.update(updateData);
  }

  @override
  void castStatefulWidget() {
    widget is ChatScreen;
  }

  String getFileIcon(String fileExtension) {
    String iconPath = '';

    if (fileExtension == ".pdf")
      {
        iconPath = "assets/images/ic_pdf.png";
      }
    else if (fileExtension == ".xls" || fileExtension == ".xlsx")
      {
        iconPath = "assets/images/ic_xls.png";
      }
    else if (fileExtension == ".doc" || fileExtension == ".docx")
      {
        iconPath = "assets/images/ic_doc.png";
      }
    else if (fileExtension == ".ppt")
      {
        iconPath = "assets/images/ic_ppt.png";
      }
    else if (fileExtension == ".pptx")
      {
        iconPath = "assets/images/ic_pptx.png";
      }

    return iconPath;
  }

  sendNotificationToUser(String content, String type) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(messageNotification);

    String message = '';

    if (type == "text")
      {
        message = "${sessionManager.getName()} ${sessionManager.getLastName()} has send new message ${content}";
      }
    else if (type == "media")
      {
        message = "${sessionManager.getName()} ${sessionManager.getLastName()} has uploaded media file";
      }
    else if (type == "document")
      {
        message = "${sessionManager.getName()} ${sessionManager.getLastName()} has uploaded document file";
      }

    Map<String, String> jsonBody = {};

    jsonBody = {
      'batch_IDs': sessionManager.getBatchId() ?? '',
      'message': message,
      'notification_type_id': '9',
      'send_to': 'Batch Student',
      'sending_status' : 'Send Now',
      'title' : 'New Message on SIRE Connect',
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == '1') {

    } else {

    }
  }


  _getPeoplesList() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(userListUrl);

    Map<String, String> jsonBody = {
      'batch_id': "4",
      'course_id': "",
      'faculty_id': "",
      'filter': "student",
      'filter_by': "",
      'from_app':"true",
      'is_alumini':"",
      'limit':"25",
      'module_id':"",
      'movedStudent':"0",
      "moved_by":"",
      'page':"1",
      "search":"",
      "total":"0",
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    print(response);
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = GroupResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == "1")
    {
      setState(() {
        listUser = dataResponse.list ?? [];
      });
    }
    else {

    }
  }

}