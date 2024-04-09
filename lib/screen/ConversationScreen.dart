import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:shivalik_institute/constant/firebase_constant.dart';
import 'package:shivalik_institute/model/BatchResponseModel.dart';
import 'package:shivalik_institute/model/ConversationSchema.dart';
import 'package:shivalik_institute/screen/ChatScreen.dart';
import 'package:shivalik_institute/utils/app_utils.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../constant/colors.dart';
import '../utils/base_class.dart';

class ConversationScreen extends StatefulWidget {
  final List<BatchList> listBatches;
  const ConversationScreen(this.listBatches, {super.key});

  @override
  BaseState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends BaseState<ConversationScreen> {

  late Stream<QuerySnapshot> messagesStream;

  List<ConversationSchema> listData = [];
  List<BatchList> listBatches = [];

  @override
  void initState(){
    super.initState();

    listBatches = (widget as ConversationScreen).listBatches;
    List<String> listBatchIds = [];
    for (var i=0; i < listBatches.length; i++)
      {
        if (listBatches[i].batchStatus == 'ongoing')
          {
            listBatchIds.add(listBatches[i].id ?? '');
          }


        if (listBatches[i].name == 'JRE10')
        {
          listBatchIds.add(listBatches[i].id ?? '');
        }

      }

    //listBatchIds = sessionManager.getMainBatchId()?.split(",") ?? [];

    print("<><><><>");
    print(listBatchIds.toString());

    messagesStream = firestoreInstance.collection(batch).where('id',whereIn: listBatchIds).snapshots();
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
        title: getTitle('SIRE Connect'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 12),
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

                var conversations = snapshot.data?.docs ?? [];
                listData = [];
                for (var conversation in conversations) {

                  var isMessageCount = conversations.contains('message_count');

                  print("isMessageCount == $isMessageCount");

                  LastMessage lastMessageObject = LastMessage();

                  lastMessageObject = LastMessage(
                      content: conversation.get('last_message.content'),
                      timestamp: conversation.get('last_message.timestamp'),
                      type: conversation.get('last_message.type'),
                      senderId: conversation.get('last_message.senderId'),
                      senderName: conversation.get('last_message.sender_name')
                  );


                  var commentsData = ConversationSchema(
                    name: conversation['name'],
                    id: conversation['id'],
                    batchMonthYear: conversation['batch_month_year'] ?? '',
                    batchPriority: 0,
                    batchSize: conversation['batch_size'],
                    batchStatus: conversation['batch_status'],
                    createdAt: conversation['created_at'],
                    endDate: conversation['end_date'],
                    endTime: conversation['end_time'],
                    formatedDateTime: conversation['formated_date_time'],
                    isActive: conversation['is_active'],
                    lastMessage: lastMessageObject,
                    messageCount: isMessageCount ? conversation['message_count'] : 0,
                    registrationCloseDate: conversation['registration_close_date'],
                    startDate: conversation['start_date'],
                    startTime: conversation['start_time'],
                    studentEnrolled: conversation['student_enrolled'],
                    timezone: conversation['timezone'],
                    updatedAt: conversation['updated_at'],
                  );

                  listData.add(commentsData);

                }

                print("listData === ${listData.length}");

                return ListView.builder(
                  itemCount: listData.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          print("ID ==== ${listData[index].id ?? ''}");

                          sessionManager.setBatchId(listData[index].id ?? '');
                          sessionManager.setBatchName(listData[index].name ?? '');
                          startActivity(context, const ChatScreen(true));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(25)),
                                          color: grayLight
                                      ),
                                      child: const Icon(
                                        Icons.groups, size: 30.0, color: brandColor,)
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(listData[index].name ?? '', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: black),),
                                            Visibility(
                                                visible: listData[index].lastMessage?.content?.isNotEmpty ?? false,
                                                child: Text(timeStampToDateTimeForMsg(listData[index].lastMessage?.timestamp), style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: black),)),
                                          ],
                                        ),
                                        const Gap(6),
                                        Visibility(
                                          visible: listData[index].lastMessage?.content?.isNotEmpty ?? false,
                                          child: sessionManager.getUserId() == listData[index].lastMessage?.senderId
                                              ? Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text("You: ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: graySemiDark),),
                                                  getMessageContent(listData[index].lastMessage ?? LastMessage()),
                                                ],
                                              )
                                              : Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("${listData[index].lastMessage?.senderName ?? ''}: ", style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: graySemiDark),),
                                                  getMessageContent(listData[index].lastMessage ?? LastMessage()),
                                                ],
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              const Divider(
                                color: grayLight,
                                height: 0.7,
                                thickness: 0.7,
                                indent: 12,
                                endIndent: 12,
                              ),
                              const Gap(8)
                            ],
                          ),
                        ),

                      );

                    },
                );
              }
          },
        ),
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is ConversationScreen;
  }

  Widget getMessageContent(LastMessage lastMessage) {
    Widget dataWidget = Container();
    if (lastMessage.type == "text")
      {
        dataWidget = Expanded(child: Text(lastMessage.content ?? '', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: black, overflow: TextOverflow.ellipsis), overflow: TextOverflow.ellipsis,maxLines: 1,));
      }
    else if (lastMessage.type == "document")
      {
        dataWidget =  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_file.png',width: 22,height: 22,color: grayLight,),
            const Gap(6),
            const Text('Document', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: black),)
          ],
        );
      }
    else if (lastMessage.type == "media")
      {
        dataWidget =  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_camera_chat.png',width: 22,height: 22,color: grayLight,),
            const Gap(6),
            const Text('Media', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: black),)
          ],
        );
      }

    return dataWidget;
  }

}