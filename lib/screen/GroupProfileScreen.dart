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


  @override
  void initState(){
    listUser = (widget as GroupProfileScreen).listUser;
    if(listUser.isNotEmpty)
      {
        batchName = listUser[0].batch?.name ?? "";
      }
    print("list user ====${listUser.length}");
    super.initState();
  }

  void getFirebaseImageFolder() {
    final Reference storageRef = FirebaseStorage.instance.ref().child('SIRE').child('Media');
    storageRef.listAll().then((result) {
      print("result is $result");
    });


    final Reference storageRefDoc = FirebaseStorage.instance.ref().child('SIRE').child('Document');

    storageRefDoc.listAll().then((result) {
      print("result is $result");
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
            title: GestureDetector(
                onTap: (){

                },
                child: getTitle('Group Info')
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(top: 16,bottom: 16, right: 16),
                child: Text("Edit",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(20),
                  Center(
                      child: Image.asset('assets/images/ic_user_placeholder.png', width: 120, height: 120,)
                  ),
                  const Gap(18),
                   Text(batchName,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 24),
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Group",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w400, color: grayDarkNew, fontSize: 16),
                      ),
                      const Gap(8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: grayDarkNew,
                        ),
                      ),
                      const Gap(8),
                      Text(
                      "${listUser.length} Member",
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontWeight: FontWeight.w400, color: grayDarkNew, fontSize: 16),
                      ),
                    ],
                  ),
                  const Gap(22),
                 /* Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/ic_Phone.png', width: 20, height: 20, color: blue,),
                              const Gap(10),
                              const Text("Audio",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/ic_video.png', width: 20, height: 20, color: blue,),
                              const Gap(10),
                              const Text("Video",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/ic_search.png', width: 20, height: 20, color: blue,),
                              const Gap(10),
                              const Text("Search",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),*/
                  // const Gap(18),
                  const Gap(14),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MediaScreen()));
                          },
                          child: Row(
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
                              const Text("Media, Link, and Docs",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                         Row(
                          children: [
                            Text("1,002",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.w400, color: graySemiDark, fontSize: 18),
                            ),
                            Gap(8),
                            Image.asset('assets/images/ic_arrow_right.png', width: 20, height: 20, color: graySemiDark,)
                          ],
                        ),
                      ],
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
                      Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: grayLight,
                          ),
                          child: Image.asset('assets/images/ic_search.png', width: 16, height: 16, color: grayDarkNew,)
                      )
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