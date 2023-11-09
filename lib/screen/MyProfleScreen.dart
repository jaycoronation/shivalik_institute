import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../common_widget/loading_more.dart';
import '../constant/colors.dart';
import '../model/UserProfileResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/UserViewModel.dart';
import 'ProfileScreen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  BaseState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends BaseState<MyProfileScreen> {
bool _isLoadingMore = false;
  Details getSet = Details();

  @override
  void initState(){
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: appBg,
          leading:  InkWell(
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              Navigator.pop(context, true);
            },
            child: getBackArrow(),
          ),
          titleSpacing: 0,
          centerTitle: false,
          title: getTitle("My Profile",),
        ),
        body:  Consumer<UserViewModel>(
          builder: (context, value, child) {
            if ((value.isLoading) && (_isLoadingMore == false))
            {
              return const LoadingWidget();
            }
            else
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(height: 16,),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              // startActivity(context, ProfileScreen());
                            var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                            getUserData();
                            },
                            child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150)), color: grayLight),
                                      width: 100,
                                      height: 100,
                                      child:  ClipOval(
                                          child:getSet.profilePic.toString().isEmpty
                                              ? Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover,)
                                              : Image.network(getSet.profilePic.toString(), fit: BoxFit.cover)
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 12,
                                      child: Container(
                                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                            color: grayLight,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Image.asset('assets/images/ic_edit.png', height: 18, width: 18,),
                                          )
                                      )
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(height: 32,),
                          Visibility(
                            visible: getSet.firstName?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("${getSet.firstName} ${getSet.lastName}" ,
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: getSet.email?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(getSet.email.toString(),
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: getSet.contactNo?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(getSet.contactNo.toString(),
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: getSet.gender?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(toDisplayCase(getSet.gender.toString()),
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: getSet.dateOfBirth?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(universalDateConverter("yyyy-MM-dd", "dd MMM, yyyy", getSet.dateOfBirth ?? ""),
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: getSet.courseName?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(getSet.courseName.toString(),
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: getSet.batchName?.isNotEmpty ?? false,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/ic_grey_placeholder.png', width: 26,height: 26,),
                                    Container(width: 12,),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(getSet.batchName.toString(),
                                          style: const TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _isLoadingMore,
                      child: const LoadingMoreWidget()
                  )
                ],
              );
            }
          },
        ),
      ),
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
    );
  }

  @override
  void castStatefulWidget() {
    widget is MyProfileScreen;
  }

  Future<void> getUserData() async {
    Map<String, String> jsonBody = {
      'user_id':sessionManager.getUserId() ?? '',
      "user_type":'3'
    };

    UserViewModel userViewModel = Provider.of<UserViewModel>(context,listen: false);
    await userViewModel.getUserDetails(jsonBody);

    if (userViewModel.response.success == '1')
    {
      getSet = userViewModel.response.details ?? Details();
    }
    else
    {

    }

  }

}