import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/GroupResponseModel.dart';
import '../utils/base_class.dart';
import 'MediaScreen.dart';

class GroupProfileScreen extends StatefulWidget {
  final List<UserList> listUser;
  const GroupProfileScreen(this.listUser, {super.key});

  @override
  BaseState<GroupProfileScreen> createState() => _GroupProfileScreenState();
}

class _GroupProfileScreenState extends BaseState<GroupProfileScreen> {
  final ScrollController scrollViewController = ScrollController();
  List<UserList> listUser = [];
  String batchName = "";
  int totalMediaCount = 0;

  @override
  void initState(){
    listUser = (widget as GroupProfileScreen).listUser;

    listUser.sort((a, b) => b.isBatchAdmin.toString().compareTo(a.isBatchAdmin.toString()));


    if(listUser.isNotEmpty)
      {
        batchName = listUser[0].batch?.name ?? "";
      }
    print("list user ====${listUser.length}");

    getFirebaseImageFolder();
    super.initState();
  }

  void getFirebaseImageFolder() {
    final Reference storageRef = FirebaseStorage.instance.ref().child('SIRE').child(sessionManager.getBatchId() ?? '').child('Media');
    storageRef.listAll().then((result) {

      setState(() {
        final List<Reference> allFiles = result.items;
        totalMediaCount += allFiles.length;
        print("result is ${allFiles.length}");
      });
    });


    final Reference storageRefDoc = FirebaseStorage.instance.ref().child('SIRE').child(sessionManager.getBatchId() ?? '').child('Document');

    storageRefDoc.listAll().then((result) {
      setState(() {
        final List<Reference> allFiles = result.items;
        totalMediaCount += allFiles.length;
        print("result is ${allFiles.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: grayButton,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: grayButton,
            leading: InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            titleSpacing: 0,
            centerTitle: true,
            title: getTitle('Group Info'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(20),
                 Container(
                   width: 120,
                   height: 120,
                   decoration: BoxDecoration(
                     color: grayLight,
                     borderRadius: BorderRadius.circular(12)
                   ),
                   alignment: Alignment.center,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text(sessionManager.getBatchName() ?? '',
                         textAlign: TextAlign.start,
                         style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 26),
                       ),
                       const Gap(8),
                       Text(
                         "${listUser.length} Members",
                         textAlign: TextAlign.start,
                         style: const TextStyle(fontWeight: FontWeight.w400, color: grayDarkNew, fontSize: 14),
                       ),
                     ],
                   ),
                 ),

                  const Gap(22),
                  const Gap(14),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: white,
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MediaScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: blue,
                                  ),
                                  child: Image.asset('assets/images/ic_gallery.png', width: 20, height: 20, color: white,)
                              ),
                              const Gap(10),
                              const Text("Media and Docs",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                              ),
                            ],
                          ),
                          const Gap(10),
                           Row(
                            children: [
                              Text(
                                totalMediaCount.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontWeight: FontWeight.w400, color: graySemiDark, fontSize: 18),
                              ),
                              const Gap(8),
                              Image.asset('assets/images/ic_arrow_right.png', width: 20, height: 20, color: graySemiDark,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${listUser.length} Member",
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 18),
                      ),
                    ],
                  ),
                  const Gap(18),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: white,
                    ),
                    child: ListView.builder(
                      controller: scrollViewController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listUser.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            //startActivity(context, ModuleDetailsScreen(getSet));
                          },
                          child:  Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                    child:listUser[index].profilePic.toString().isEmpty
                                        ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,width: 45, height: 45,)
                                        : Image.network(listUser[index].profilePic ?? "", fit: BoxFit.cover, width: 45, height: 45,)
                                ),
                                const Gap(18),
                                 Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${listUser[index].firstName ?? ""} ${listUser[index].lastName ?? "" }",
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                                                ),
                                                Text(listUser[index].designation ?? "",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.w400, color: grayDarkNew, fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Text("Admin",
                                          //   // textAlign: TextAlign.right,
                                          //   style: TextStyle(fontWeight: FontWeight.w400, color: grayDarkNew, fontSize: 14),
                                          // ),
                                        ],
                                      ),
                                      const Gap(12),
                                      const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: grayLight,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(18),
                ],
              ),
            ),
          ),
        ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  @override
  void castStatefulWidget() {
   widget is GroupProfileScreen;
  }

}