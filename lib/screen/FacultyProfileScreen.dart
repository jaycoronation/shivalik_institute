import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/api_end_point.dart';
import 'package:shivalik_institute/constant/colors.dart';
import 'package:shivalik_institute/model/UserProfileResponseModel.dart';

import '../common_widget/common_widget.dart';
import '../utils/base_class.dart';
import '../viewmodels/UserViewModel.dart';
import 'DashboardScreen.dart';

class FacultyProfileScreen extends StatefulWidget {
  final String facultyId;
  const FacultyProfileScreen(this.facultyId, {super.key});

  @override
  BaseState<FacultyProfileScreen> createState() => _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends BaseState<FacultyProfileScreen> {

  Details getSet = Details();
  String facultyId = '';
  bool isLoading = false;
  bool isNoDataFound = false;

  @override
  void initState(){
    super.initState();
    facultyId = (widget as FacultyProfileScreen).facultyId;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: appBg,
          leading:  InkWell(
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              if (Navigator.canPop(context))
              {
                Navigator.pop(context);
              }
              else
              {
                startActivityRemove(context, const DashboardScreen());
              }
            },
            child: getBackArrow(),
          ),
          titleSpacing: 0,
          centerTitle: false,
          title: getTitle("Faculty Profile",),
        ),
        body: isLoading
            ? const LoadingWidget()
            : isNoDataFound
            ? const MyNoDataNewWidget(msg: "Faculty Profile not found", img: '')
            : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Gap(22),
                    Text("${getSet.prefixName} ${getSet.firstName} ${getSet.lastName}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: brandColor),),
                    const Gap(6),
                    Text("${getSet.designation}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                    const Gap(6),
                    Text("${getSet.email}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                    const Gap(6),
                    Text("${getSet.contactNo}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                    const Gap(22),
                    Container(alignment: Alignment.centerLeft,child: const Text("Profile",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),)),
                    const Gap(12),
                    HtmlWidget(getSet.about ?? ''),
                  ],
                ),
              ),
            ),
      ),

    );
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> jsonBody = {
      'from_app': FROM_APP,
      "user_id": facultyId
    };

    UserViewModel userViewModel = Provider.of<UserViewModel>(context,listen: false);
    await userViewModel.getUserDetails(jsonBody);

    if (userViewModel.response.success == '1')
    {
      setState(() {
        getSet = userViewModel.response.details ?? Details();
        isLoading = false;
        isNoDataFound = false;
      });

    }
    else
    {
      setState(() {
        isLoading = false;
        isNoDataFound = true;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is FacultyProfileScreen;
  }
}