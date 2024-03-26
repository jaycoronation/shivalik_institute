import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shivalik_institute/model/MessageSchema.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../constant/firebase_constant.dart';
import '../model/DeviceTokenResponseModel.dart';
import '../model/GroupResponseModel.dart';
import '../model/ReactionModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/full_screen_image.dart';
import '../utils/pdf_viewer.dart';
import 'GroupProfileScreen.dart';

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
  List<ReactionModel> listReaction = [];
  List<DeviceTokens> listDeviceTokens = [];
  bool isSendButtonVisible = false;
  String selectedMedia = '';
  String documentID = '';
  bool _isLoading = false;
  bool isDarkTheme = false;
  String valueEmoji = '';

  List<UserList> listUser = [];

  bool isFormConvList = false;

  ScrollController chatScrollController = ScrollController();

  final List<Reaction<String>?> _reactions = [
    Reaction(
      value: '1',
      icon: Image.asset('assets/images/ic_thum.png', width: 20, height: 20,),
    ),
    Reaction(
      value: '2',
      icon: Image.asset('assets/images/ic_heart.png', width: 20, height: 20,),
    ),
    Reaction(
      value: '3',
      icon: Image.asset('assets/images/ic_smile.png', width: 20, height: 20,),
    ),
    Reaction(
      value: '4',
      icon: Image.asset('assets/images/ic_emotional.png', width: 20, height: 20,),
    ),
    Reaction(
      value: '5',
      icon: Image.asset('assets/images/ic_hund.png', width: 20, height: 20,),
    ),
  ];

  @override
  void initState(){
    _getPeoplesList();
    getDeviceTokens();
    isFormConvList = (widget as ChatScreen).isFormConvList;
    messagesStream = firestoreInstance
        .collection(batch)
        .doc(sessionManager.getBatchId() ?? '')
        .collection(messages)
        .orderBy('timestamp', descending: true)
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
            behavior: HitTestBehavior.opaque,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupProfileScreen(listUser)));
            },
            child: getTitle(sessionManager.getBatchName() ?? '')
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GroupProfileScreen(listUser)));
              },
              child: Image.asset('assets/images/ic_information.png',width: 22,height: 22,)
          ),
          const Gap(12),
        ],
      ),
      body: Column(
        children: [
          const Gap(12),
          Expanded (
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
                    listMessages = [];
                    var messages = snapshot.data?.docs ?? [];

                    for (var message in (snapshot.data?.docs ?? []))
                    {
                      var isReactionAvailable = false;
                      if (message.data().containsKey('reactions'))
                        {
                          isReactionAvailable = true;
                        }

                      checkReactions(snapshot);
                      var getSet = MessageSchema(
                        senderId: message['sender_id'],
                        sender: message['sender'],
                        content: message['content'],
                        type: message['type'],
                        fileName: message['file_name'] ?? '',
                        documentId: message['document_id'] != null ? message['document_id'] ?? '' : '',
                        isEdited: message['is_edited'],
                        isDelete: message['is_delete'],
                        timestamp: Timestamp.now(),
                        reactions: isReactionAvailable == true ? message['reactions'] : []
                      );
                      listMessages.add(getSet);
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      controller: chatScrollController,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: listMessages.length,
                      itemBuilder: (context, index) {
                        final lastIndex = index < listMessages.length - 1 ? index + 1 : index;

                        final isDifferentDateNew = getDayFromTimestamp(listMessages[index].timestamp) != getDayFromTimestamp(listMessages[lastIndex].timestamp);
                        listReaction = listMessages[index].reactions?.map((dynamic item) {
                          return ReactionModel(
                            userName: item["userName"],
                            profilePicUrl: item["profilePicUrl"],
                            reactionIcon: item["reactionIcon"],
                            userId: item["userId"],
                          );
                        }).toList() ?? [];

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onLongPress: () {
                            print("long presssss");
                            if (sessionManager.getUserId() == listMessages[index].senderId)
                            {
                              print("long presssss in");
                              // messageActionDialog(listMessages[index]);
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

                                sessionManager.getUserId() == listMessages[index].senderId
                                    ? PullDownButton(
                                      itemBuilder: (context) => [
                                        PullDownMenuActionsRow.small(
                                            items: [
                                              PullDownMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    valueEmoji = '👍';
                                                  });

                                                  var reaction = ReactionModel(
                                                    userId: sessionManager.getUserId().toString(),
                                                    profilePicUrl: sessionManager.getProfilePic().toString(),
                                                    reactionIcon: valueEmoji,
                                                    userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),
                                                  );

                                                  addReaction(listMessages[index].documentId.toString(),reaction);
                                                },
                                                title: '👍',
                                                iconWidget:  Text('👍',),
                                              ),
                                              PullDownMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    valueEmoji = '❤️';
                                                  });
                                                  var reaction = ReactionModel(
                                                    userId: sessionManager.getUserId().toString(),
                                                    profilePicUrl: sessionManager.getProfilePic().toString(),
                                                    reactionIcon: valueEmoji,
                                                    userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),

                                                  );

                                                  addReaction(listMessages[index].documentId.toString(),reaction);
                                                },
                                                title: '❤️',
                                                iconWidget: Text('❤️',),
                                              ),
                                              PullDownMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    valueEmoji =  '😂';
                                                  });
                                                  var reaction = ReactionModel(
                                                    userId: sessionManager.getUserId().toString(),
                                                    profilePicUrl: sessionManager.getProfilePic().toString(),
                                                    reactionIcon: valueEmoji,
                                                    userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),

                                                  );

                                                  addReaction(listMessages[index].documentId.toString(),reaction);
                                                },
                                                title: '😂',
                                                iconWidget: Text('😂',),
                                              ),
                                              PullDownMenuItem(
                                                onTap: () {
                                                  // setState(() {
                                                  //   valueEmoji = '4';
                                                  // });
                                                  // var reaction = ReactionModel(
                                                  //   userId: sessionManager.getUserId().toString(),
                                                  //   profilePicUrl: sessionManager.getProfilePic().toString(),
                                                  //   reactionIcon: valueEmoji,
                                                  //   userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),
                                                  //
                                                  // );

                                                  // addReaction(listMessages[index].documentId.toString(),reaction);

                                                  openEmojiBottomSheet(listMessages[index]);

                                                },
                                                title: 'Edit',
                                                iconWidget: Image.asset('assets/images/ic_add.png', width: 20, height: 20, color: grayDarkNew,),
                                              ),

                                            ]
                                        ),
                                        PullDownMenuItem(
                                          title: 'Edit',
                                          icon: Icons.edit,
                                          onTap: () async {
                                            updateTxtBottomSheet(listMessages[index]);
                                          },

                                        ),
                                        PullDownMenuItem(
                                          title: 'Delete',
                                          itemTheme: PullDownMenuItemTheme(textStyle: TextStyle(color: Colors.red)),
                                          iconColor: Colors.red,
                                          icon: Icons.delete_outline_rounded,
                                          onTap: () {
                                            deleteMessage(listMessages[index].documentId ?? '');
                                          },
                                        ),
                                      ],
                                      buttonBuilder: (context, showMenu) {
                                        return GestureDetector(
                                          onLongPress: showMenu,
                                          child: listMessages[index].type == "media"
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
                                                startActivity(context, PdfViewer(listMessages[index].content ?? '', '0',listMessages[index].fileName ?? ''));
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
                                          ),
                                        );
                                      },
                                    )
                                    : PullDownButton(
                                      itemBuilder: (context) => [
                                        PullDownMenuActionsRow.small(
                                            items: [
                                              PullDownMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    valueEmoji = '👍';
                                                  });
                                                  var reaction = ReactionModel(
                                                    userId: sessionManager.getUserId().toString(),
                                                    profilePicUrl: sessionManager.getProfilePic().toString(),
                                                    reactionIcon: valueEmoji,
                                                    userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),

                                                  );

                                                  addReaction(listMessages[index].documentId.toString(),reaction);
                                                },
                                                title: '👍',
                                                iconWidget: Text('👍',),
                                              ),
                                              PullDownMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    valueEmoji = '❤️';
                                                  });
                                                  var reaction = ReactionModel(
                                                    userId: sessionManager.getUserId().toString(),
                                                    profilePicUrl: sessionManager.getProfilePic().toString(),
                                                    reactionIcon: valueEmoji,
                                                    userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),
                                                  );

                                                  addReaction(listMessages[index].documentId.toString(),reaction);
                                                },
                                                title: '❤️',
                                                iconWidget: Text('❤️',),
                                              ),
                                              PullDownMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    valueEmoji = '😂';
                                                  });
                                                  var reaction = ReactionModel(
                                                    userId: sessionManager.getUserId().toString(),
                                                    profilePicUrl: sessionManager.getProfilePic().toString(),
                                                    reactionIcon: valueEmoji,
                                                    userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),
                                                  );

                                                  addReaction(listMessages[index].documentId.toString(),reaction);
                                                },
                                                title: '😂',
                                                iconWidget: Text('😂'),
                                              ),
                                              PullDownMenuItem(
                                                onTap: () {
                                                  // setState(() {
                                                  //   valueEmoji = '4';
                                                  // });
                                                  // var reaction = ReactionModel(
                                                  //   userId: sessionManager.getUserId().toString(),
                                                  //   profilePicUrl: sessionManager.getProfilePic().toString(),
                                                  //   reactionIcon: valueEmoji,
                                                  //   userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),
                                                  // );
                                                  //
                                                  // addReaction(listMessages[index].documentId.toString(),reaction);
                                                  openEmojiBottomSheet(listMessages[index]);
                                                },
                                                title: 'Edit',
                                                iconWidget: Image.asset('assets/images/ic_add.png', width: 20, height: 20,color: grayDarkNew,),
                                              ),
                                            ]
                                        ),
                                      ],
                                      buttonBuilder: (context, showMenu) {
                                        return GestureDetector(
                                          onLongPress: showMenu,
                                          child: listMessages[index].type == "media"
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
                                                  startActivity(context, PdfViewer(listMessages[index].content ?? '', '0',listMessages[index].fileName ?? ''));
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
                                        );
                                      },
                                    ),
                              listMessages[index].reactions?.isNotEmpty ?? false
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: (){
                                        print("message lstttt${listMessages[index].reactions}");

                                        listReaction = listMessages[index].reactions?.map((dynamic item) {
                                          return ReactionModel(
                                            userName: item["userName"],
                                            profilePicUrl: item["profilePicUrl"],
                                            reactionIcon: item["reactionIcon"],
                                            userId: item["userId"],
                                          );
                                        }).toList() ?? [];

                                        openReactionBottomSheet(listMessages[index].documentId ?? "");
                                      },
                                    child: Container(
                                        padding: const EdgeInsets.all(6),
                                        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                        decoration: BoxDecoration(
                                            color: grayLight,
                                            shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: calculateTopReactions(listMessages[index].reactions ?? []),
                                    ),
                                  )
                                  : Container(
                                    color: Colors.transparent,
                              ),
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
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        minLines: 1,
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

  void checkReactions(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    // Assuming you're fetching documents and iterating over them
    for (var document in (snapshot.data?.docs ?? [])) {
      if (document.data().containsKey('reactions'))
      {
        // Access the value of the new field if it exists
        var fieldValue = document.data()['reactions'];


        print('IS CONTENT FILED ==== ${fieldValue}');

        // Your logic here using the fieldValue
      }
      else
      {
        print('IS CONTENT IS NOT AVAILABLE');
      }
    }
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

  deleteReaction(String messageId, String userId, String reaction) async {
    try {
      await FirebaseFirestore.instance
        .collection(batch)
        .doc(sessionManager.getBatchId())
        .collection(messages)
        .doc(reaction)
        .delete();
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
      Reference reference = FirebaseStorage.instance.ref();

      if (type == "media")
        {
          reference = FirebaseStorage.instance.ref().child('SIRE/${sessionManager.getBatchId() ?? ''}/Media/$fileName');
        }
      else if (type == "document")
        {
          reference = FirebaseStorage.instance.ref().child('SIRE/${sessionManager.getBatchId() ?? ''}/Document/$fileName');
        }

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

    if(listDeviceTokens.isNotEmpty)
    {
      if (type == "text")
        {
          await sendNotificationToUser(content);
        }
      else
        {
          await sendNotificationToUser("${sessionManager.getName()} ${sessionManager.getLastName()} has uploaded a document");
        }

    }

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

  Future<void> addReaction(String messageId, ReactionModel updatedReaction) async {

    // Reference to the message document
    DocumentReference messageRef = firestoreInstance.collection(batch).doc(sessionManager.getBatchId()).collection(messages).doc(messageId);

    // Retrieve the current reactions from Firestore

    DocumentSnapshot messageSnapshot = await messageRef.get();
    Map<String, dynamic>? data = messageSnapshot.data() as Map<String, dynamic>?;

    // Check if the document contains the "reactions" field
    List<dynamic> reactions = data?['reactions'] ?? [];

    // Check if the user has already reacted
    bool userAlreadyReacted = reactions.any((reaction) => reaction['userId'] == updatedReaction.userId);

    if (userAlreadyReacted) {
      // If the user has already reacted, update the reaction
      reactions = reactions.map((reaction) {
        if (reaction['userId'] == updatedReaction.userId) {
          return updatedReaction.toMap();
        }
        return reaction;
      }).toList();
    } else {
      // If the user has not reacted yet, add a new reaction to the reactions array
      reactions.add(updatedReaction.toMap());
    }

    // Update the reactions array in the message document
    await messageRef.set({'reactions': reactions}, SetOptions(merge: true));
  }

  Future<void> removeReaction(String messageId, String userId) async {
    // Reference to the message document
    DocumentReference messageRef
         = firestoreInstance.collection(batch).doc(sessionManager.getBatchId()).collection(messages).doc(messageId);

    // Retrieve the current reactions from Firestore
    DocumentSnapshot messageSnapshot = await messageRef.get();
    Map<String, dynamic>? data = messageSnapshot.data() as Map<String, dynamic>?;

    // Check if the document contains the "reactions" field
    List<dynamic> reactions = data?['reactions'] ?? [];

    if (reactions != null) {
      // Find the index of the reaction corresponding to the user ID
      int index = reactions.indexWhere(
              (reaction) => reaction['userId'] == userId);

      if (index != -1) {
        // Remove the reaction at the specified index
        reactions.removeAt(index);

        // Update the reactions array in the message document
        await messageRef.update({'reactions': reactions});
      }
    }
  }

  sendNotificationToUser(String msg) async {
    var token = List<String>.empty(growable: true);
    for(int i=0; i < listDeviceTokens.length; i++)
    {
      if (listDeviceTokens[i].userId != sessionManager.getUserId().toString())
        {
          token.add(checkValidString(listDeviceTokens[i].deviceToken));
        }
    }

    String constructFCMPayload(List<String> token) {
      return jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': msg,
            'title': "New message from ${checkValidString(sessionManager.getName())} ${checkValidString(sessionManager.getLastName())} on SIRE Connect",
          },
          'data': <String, dynamic>{'content_id': sessionManager.getBatchId() ?? '', 'message': msg, 'operation': "user_chat",},
          'content_available' : true,
          'registration_ids': token
        },

      );
    }

    if (token.isEmpty) {
      showSnackBar('Unable to send FCM message, no token exists.', context);
      return;
    }

    try {
      //Send  Message
      http.Response response = await http.post(Uri.parse(fcmSendURL),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': fcmServerKey,
          },
          body: constructFCMPayload(token));
      log("status: ${response.statusCode} | Message Sent Successfully!");
    } catch (e) {
      log("error push notification $e");
    }
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

  getDeviceTokens() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(batchWiseDeviceToken);

    Map<String, String> jsonBody = {};

    jsonBody = {
      'batch_id': sessionManager.getBatchId() ?? '',
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = DeviceTokenResponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == 1) {

      for (var i=0; i < (dataResponse.deviceTokens?.length ?? 0); i++)
        {
          if (sessionManager.getUserId() == dataResponse.deviceTokens?[i].userId)
            {
              listDeviceTokens.add(dataResponse.deviceTokens?[i] ?? DeviceTokens());
            }
        }
    }
    else
    {
    }
  }

  _getPeoplesList() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(userListUrl);

    Map<String, String> jsonBody = {
      'batch_id': sessionManager.getBatchId() ?? '',
      'course_id': "",
      'faculty_id': "",
      'filter': "student",
      'filter_by': "",
      'from_app':"true",
      'limit': '',
      'is_alumini':"",
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

  Widget getIconImage(List<dynamic> listReactions){
    Widget emoji = Container();
    String valueEmoji = '';
    List<ReactionModel> listReactionsTemp = [];

    for (var i=0; i < listReactions.length; i++)
      {
        if (i == 0)
          {
            valueEmoji = listReactions[i]['reactionIcon'];
          }
      }

    if (valueEmoji == '1')
    {
      emoji = Text('👍',);
    }
    else if (valueEmoji == '2')
    {
      emoji = Text('❤️',);
    }
    else if (valueEmoji == '3')
    {
      emoji = Text('😂');
    }
    else if (valueEmoji == '4')
    {
      emoji = Text('');
    }
    else if (valueEmoji == '5')
    {
      emoji = Image.asset('assets/images/ic_hund.png',width: 16, height: 16,);
    }
    else
    {
      emoji = Text(valueEmoji);
    }

    return emoji;
  }

  Widget getIconImageSheet(String valueEmoji){
    Widget emoji =  Container();

    if (valueEmoji == '1')
    {
      emoji = Text('👍',);
    }
    else if (valueEmoji == '2')
    {
      emoji = Text('❤️',);
    }
    else if (valueEmoji == '3')
    {
      emoji = Text('😂');
    }
    else if (valueEmoji == '4')
    {
      emoji = Image.asset('assets/images/ic_emotional.png',width: 16, height: 16,);
    }
    else if (valueEmoji == '5')
    {
      emoji = Image.asset('assets/images/ic_hund.png',width: 16, height: 16,);
    }
    else
    {
      emoji = Text(valueEmoji);
    }
    return emoji;
  }

  messageView(index){
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
          startActivity(context, PdfViewer(listMessages[index].content ?? '', '0',listMessages[index].fileName ?? ''));
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
    );
  }

  void openReactionBottomSheet(String documentId) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      backgroundColor: white,
      // barrierColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 12,left: 12,right: 12,bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(height: 8,),
                          Center(
                            child: Container(
                              height: 2,
                              width: 40,
                              color: black,
                              margin: const EdgeInsets.only(bottom: 12)
                            ),
                          ),
                          ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listReaction.length,
                            itemBuilder: (context, index) {
                               return GestureDetector(
                                 behavior: HitTestBehavior.opaque,
                                 onTap: (){
                                   if(sessionManager.getUserId() == listReaction[index].userId)
                                   print("message delete");
                                     {
                                       removeReaction(documentId,listReaction[index].userId,);
                                       Navigator.pop(context);
                                       print("message deleteeee");
                                     }
                                 },
                                 child: Column(
                                   children: [
                                     Row(
                                       children: [
                                         listReaction[index].profilePicUrl.isEmpty ?? true
                                             ? ClipOval(
                                               child: Image.asset(
                                                 'assets/images/ic_user_placeholder.png',
                                                 height: 36,
                                                 width: 36,
                                                 fit: BoxFit.cover,
                                               ),
                                             )
                                             : ClipOval(
                                               child: Image.network(
                                                 listReaction[index].profilePicUrl,
                                                 height: 36,
                                                 width: 36,
                                                 fit: BoxFit.cover,
                                               ),
                                             ),
                                         const Gap(12),
                                         Expanded(
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(listReaction[index].userName,style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w400),),
                                             Gap(2),
                                             Visibility(
                                               visible: sessionManager.getUserId() == listReaction[index].userId,
                                                 child: Text("Tap to remove",style: TextStyle(color: grayDarkNew,fontSize: 12,fontWeight: FontWeight.w400),)
                                             ),
                                           ],
                                         )),
                                         getIconImageSheet(listReaction[index].reactionIcon ?? ""),
                                         // Image.asset(getIconImageSheet(listReaction[index].reactionIcon ?? ""), width: 20, height: 20,),
                                       ],
                                     ),
                                     const Gap(8),
                                     const Divider(
                                       height: 0.5,
                                       thickness: 0.5,
                                       color: grayLight,
                                     ),
                                     const Gap(8),
                                   ],
                                 ),
                               );
                              },
                          ),
                          const Gap(12),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openEmojiBottomSheet(MessageSchema listMessag) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7, // Adjust height as needed
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(height: 8,),
                  Center(
                    child: Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)
                    ),
                  ),
                  Container(height: 12,),
                  Expanded(
                    child: EmojiPicker(
                      onEmojiSelected: (emoji, category) {
                        valueEmoji = category.emoji;
                        // Handle the selected emoji
                        print('Selected emoji: $emoji');
                        print('Selected emojiii: ${category.emoji}');

                          var reaction = ReactionModel(
                            userId: sessionManager.getUserId().toString(),
                            profilePicUrl: sessionManager.getProfilePic().toString(),
                            reactionIcon: valueEmoji,
                            userName: sessionManager.getName().toString() + " " + sessionManager.getLastName().toString(),
                          );

                        addReaction(listMessag.documentId.toString(),reaction);
                        Navigator.pop(context);
                        // You can pass the selected emoji back to the parent widget or perform any other action here
                      },
                      // rows: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget calculateTopReactions(List<dynamic> listReactions) {

   var reactions = listReactions?.map((dynamic item) {
      return ReactionModel(
        userName: item["userName"],
        profilePicUrl: item["profilePicUrl"],
        reactionIcon: item["reactionIcon"],
        userId: item["userId"],
      );
    }).toList() ?? [];

    // Count occurrences of each reaction
    Map<String, int> reactionCounts = {};
    reactions.forEach((reaction) {
      reactionCounts[reaction.reactionIcon] = (reactionCounts[reaction.reactionIcon] ?? 0) + 1;
    });

    // Select top three distinct reactions
    List<String> topThreeReactions = reactionCounts.keys.toList();
    topThreeReactions.sort((a, b) => reactionCounts[b]!.compareTo(reactionCounts[a]!));
    topThreeReactions = topThreeReactions.take(3).toList();

    // Calculate total count of reactions
    int totalCount = reactionCounts.values.fold(0, (sum, count) => sum + count);

    // Display the results
    print('Top three reactions: $topThreeReactions');
    print('Total count of reactions: $totalCount');

    return Text(totalCount > 3 ? topThreeReactions.join(" ") +" " + "+${totalCount - 3}" : topThreeReactions.join(" "));
  }
}