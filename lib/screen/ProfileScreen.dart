import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/model/BatchResponseModel.dart';
import 'package:shivalik_institute/model/CityResponseModel.dart';
import 'package:shivalik_institute/model/CountryResponseModel.dart';
import 'package:shivalik_institute/model/CourseResponseModel.dart';
import 'package:shivalik_institute/screen/LoginWithOtpScreen.dart';

import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/StateViewResponseModel.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../viewmodels/BatchViewModel.dart';
import '../viewmodels/CityViewModel.dart';
import '../viewmodels/CountryViewModel.dart';
import '../viewmodels/CourseViewModel.dart';
import '../viewmodels/StateViewModel.dart';
import 'no_data_new.dart';

class ProfileScreen extends StatefulWidget {

  @override
  BaseState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {

  bool isLoading = false;
  bool isSelected = false;
  bool isChequeSelected = false;
  bool isenrollCourseSelected = false;
  bool isnetSelected = false;
  bool isholdSeatSelected = false;
  var selectGender = "";
  String _countryId = "";
  String _stateId = "";
  String _cityId = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _pendingFeesController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _holdSeatController = TextEditingController();
  final TextEditingController _netController = TextEditingController();
  final TextEditingController _chequeController = TextEditingController();
  final TextEditingController _enrollController = TextEditingController();


  @override
  void initState() {
    getContryData();
    getstateData();
    getcityData();
    getbatchData();
    getCourseData();

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
                  Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            titleSpacing: 0,
            title: Text("Profile",
              textAlign: TextAlign.start,
              style: getTitleTextStyle(),
            ),
            actions: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  _logOutDialog();
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: appBg, borderRadius: BorderRadius.circular(60)),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset('assets/images/ic_logout.png',
                        width: 18, height: 18),
                  ),
                ),
              ),
              const Gap(10)
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 22,),
                  Consumer<CourseViewModel>(
                    builder: (context, value, child) {
                      return  Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            onTap: (){
                              openCourseBottomsheet(value.response.courseList ?? []);
                            },
                            readOnly: true,
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Course*',
                            ),
                          ),
                          Visibility(
                            visible: value.isLoading,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(height: 18,),
                  TextField(
                    onTap: (){
                      openPrefixBottomsheet();
                    },
                    readOnly: true,
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _fnameController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Select Prefix*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    onTap: (){

                    },
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _lnameController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'First Name*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    onTap: (){

                    },
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _prefixController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Last Name*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    onTap: (){

                    },
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Email.*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    onTap: (){

                    },
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _contactController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Contact No.*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _genderController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                    onTap: () {
                      showGenderActionDialog();
                    },
                  ),
                  Container(height: 18,),
                  Consumer<CountryViewModel>(
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            onTap: (){
                              openCountryBottomsheet(value.response.countries ?? []);
                            },
                            readOnly: true,
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _countryController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Country*',
                            ),
                          ),
                          Visibility(
                            visible: value.isLoading,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(height: 18,),
                  Consumer<StateViewModel>(
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            onTap: (){
                              openStateBottomsheet(value.response.states ?? []);
                            },
                            readOnly: true,
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _stateController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'State*',
                            ),
                          ),
                          Visibility(
                            visible: value.isLoading,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(height: 18,),
                  Consumer<CityViewModel>(
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            onTap: (){
                              openCityBottomsheet(value.response.cities ?? []);
                            },
                            readOnly: true,
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _cityController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'City*',
                            ),
                          ),
                          Visibility(
                            visible: value.isLoading,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    maxLines: 3,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Address*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _educationController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Highest Education*',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _designationController,
                    keyboardType: TextInputType.text,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Current Designation & Organization',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _pendingFeesController,
                    keyboardType: TextInputType.number,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Pending Fees.',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _paidController,
                    keyboardType: TextInputType.number,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Paid Fees *',
                    ),
                  ),
                  Container(height: 18,),
                  TextField(
                    cursorColor: black,
                    textCapitalization: TextCapitalization.words,
                    controller: _experienceController,
                    keyboardType: TextInputType.number,
                    style: getTextFiledStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience (Real Estate). *',
                    ),
                  ),
                  Container(height: 18,),
                  Consumer<BatchViewModel>(
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            onTap: (){
                              openBatchBottomsheet(value.response.batchList ?? []);
                            },
                            readOnly: true,
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _batchController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Select Batch',
                            ),
                          ),
                          Visibility(
                            visible: value.isLoading,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(height: 22,),
                  Text("Mode Of Payment" ,
                      style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                  Container(height: 18,),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                    child: Row(
                      children: [
                        isSelected
                            ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                            : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                        Container(width: 12,),
                        Text("Cash" ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(height: 18,),
                  Visibility(
                    visible: isSelected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        cursorColor: black,
                        textCapitalization: TextCapitalization.words,
                        controller: _cashController,
                        keyboardType: TextInputType.number,
                        style: getTextFiledStyle(),
                        decoration: const InputDecoration(
                          labelText: 'Amount*',
                        ),
                      ),
                    ),
                  ),


                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        isChequeSelected = !isChequeSelected;
                      });
                    },
                    child: Row(
                      children: [
                        isChequeSelected
                            ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                            : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                        Container(width: 12,),
                        Text("Cheque" ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(height: 18,),
                  Visibility(
                    visible: isChequeSelected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        cursorColor: black,
                        textCapitalization: TextCapitalization.words,
                        controller: _chequeController,
                        keyboardType: TextInputType.number,
                        style: getTextFiledStyle(),
                        decoration: const InputDecoration(
                          labelText: 'Amount*',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        isnetSelected = !isnetSelected;
                      });
                    },
                    child: Row(
                      children: [
                        isnetSelected
                            ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                            : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                        Container(width: 12,),
                        Text("Net Banking" ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(height: 18,),
                  Visibility(
                    visible: isnetSelected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        cursorColor: black,
                        textCapitalization: TextCapitalization.words,
                        controller: _netController,
                        keyboardType: TextInputType.number,
                        style: getTextFiledStyle(),
                        decoration: const InputDecoration(
                          labelText: 'Amount*',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        isholdSeatSelected = !isholdSeatSelected;
                      });
                    },
                    child: Row(
                      children: [
                        isholdSeatSelected
                            ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                            : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                        Container(width: 12,),
                        Text("Holding Seat" ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(height: 18,),
                  Visibility(
                    visible: isholdSeatSelected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        cursorColor: black,
                        textCapitalization: TextCapitalization.words,
                        controller: _holdSeatController,
                        keyboardType: TextInputType.text,
                        style: getTextFiledStyle(),
                        decoration: const InputDecoration(
                          labelText: '',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        isenrollCourseSelected = !isenrollCourseSelected;
                      });
                    },
                    child: Row(
                      children: [
                        isenrollCourseSelected
                            ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                            : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                        Container(width: 12,),
                        Text("Enrolled Course" ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Container(height: 18,),
                  Visibility(
                    visible: isenrollCourseSelected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        cursorColor: black,
                        textCapitalization: TextCapitalization.words,
                        controller: _enrollController,
                        keyboardType: TextInputType.text,
                        style: getTextFiledStyle(),
                        decoration: const InputDecoration(
                          labelText: '',
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30,left: 8, right: 8),
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kBorderRadius),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(black)
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: isLoading
                            ? const Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: white,strokeWidth: 2)),
                        )
                            : const Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                          ),
                        )
                    ),
                  ),

                  Container(height: 18,),
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
    widget is ProfileScreen;
  }

  void openCourseBottomsheet(List<CourseList> courseList) {
    print(courseList.length);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
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
                  Container(height: 8,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text("Select Course" ,
                            style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                      ),
                      Container(height: 12,),
                      ListView.builder(
                        itemCount: courseList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ( context, index, ) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(courseList[index].name ?? "" ,
                                style: const TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 0,
                                  indent: 0,
                                  color: grayLight,
                                ),
                                const Gap(20)
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void openCountryBottomsheet(List<Countries> list) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 10,),
                    Center(
                      child: Container(
                          height: 2,
                          width: 40,
                          color: black,
                          margin: const EdgeInsets.only(bottom: 12)
                      ),
                    ),
                    Container(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select Country" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ( context, index, ) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                setState(() {
                                  _countryId = list[index].id.toString();
                                  _countryController.text = list[index].name.toString();
                                  Navigator.of(context).pop();
                                  getstateData();
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                                    child: Text(list[index].name ?? "" ,
                                        style: const TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    endIndent: 22,
                                    indent: 22,
                                    color: grayLight,
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openStateBottomsheet(List<States> list) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 10,),
                    Center(
                      child: Container(
                          height: 2,
                          width: 40,
                          color: black,
                          margin: const EdgeInsets.only(bottom: 12)
                      ),
                    ),
                    Container(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select State" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ( context, index, ) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                setState(() {
                                  _stateId = list[index].id.toString();
                                  _stateController.text = list[index].name.toString();
                                  Navigator.of(context).pop();
                                  getcityData();
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                                    child: Text(list[index].name ?? "" ,
                                        style: const TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    endIndent: 22,
                                    indent: 22,
                                    color: grayLight,
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openCityBottomsheet(List<Cities> list) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 10,),
                    Center(
                      child: Container(
                          height: 2,
                          width: 40,
                          color: black,
                          margin: const EdgeInsets.only(bottom: 12)
                      ),
                    ),
                    Container(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select City" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ( context, index, ) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                                  child: Text(list[index].name ?? "" ,
                                      style: const TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 22,
                                  indent: 22,
                                  color: grayLight,
                                ),

                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openBatchBottomsheet(List<BatchList> list) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 10,),
                    Center(
                      child: Container(
                          height: 2,
                          width: 40,
                          color: black,
                          margin: const EdgeInsets.only(bottom: 12)
                      ),
                    ),
                    Container(height: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select Batch" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ( context, index, ) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                                  child: Text(list[index].formatedDateTime ?? "" ,
                                      style: const TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  endIndent: 22,
                                  indent: 22,
                                  color: grayLight,
                                ),

                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openPrefixBottomsheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Select Prefix" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                        ),
                        Container(height: 12,),
                        const Text("Mr." ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                        Container(height: 12,),
                        const Text("Miss." ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                        Container(height: 12,),
                        const Text("Mrs." ,
                            style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showGenderActionDialog() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(height: 2,width : 40,color: black,margin: const EdgeInsets.only(bottom:12)),
                    const Text("Select Gender",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),),
                    Container(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            setState(() {
                              selectGender = "Male";
                              _genderController.text = selectGender;

                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                            child: const Text("Male",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const Divider(
                          color: grayLight,
                          height: 1,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            setState(() {
                              selectGender = "Female";
                              _genderController.text = selectGender;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                            child: const Text("Female", textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Container(height: 12),
                      ],
                    )
                  ],
                )
            )
          ],
        );
      },
    );
  }

  void getContryData() {
    Provider.of<CountryViewModel>(context,listen: false).countryData();
  }

  void getCourseData() {
    Map<String, String> jsonBody = {
      'page': "",
      'limit': "",
      'search' :"",
      'from_app' : FROM_APP
    };
    Provider.of<CourseViewModel>(context,listen: false).courseData(jsonBody);
  }

  void getstateData() {
    Map<String, String> jsonBody = {
      'country_id' : _countryId,
      'from_app' : FROM_APP
    };
    Provider.of<StateViewModel>(context,listen: false).stateData(jsonBody);
  }

  void getcityData() {
    Map<String, String> jsonBody = {
      'state_id' : _stateId,
      'from_app' : FROM_APP
    };
    Provider.of<CityViewModel>(context,listen: false).cityData(jsonBody);
  }

  void getbatchData() {

    Map<String, String> jsonBody = {
      'limit' : "",
      'page' : "",
      'search' : "",
      'status' : "1",
      'from_app' : FROM_APP
    };
    Provider.of<BatchViewModel>(context,listen: false).batchData(jsonBody);

  }

  _logOutDialog() async {
    bool isLoading = false;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState) {
            return Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 16,
                    ),
                    Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)
                    ),
                    const Text("Logout",
                      style: TextStyle(
                          fontSize: 18, color: black,fontWeight: FontWeight.w500),textAlign: TextAlign.left,
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text("Are you sure you want to logout from app?",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                        textAlign: TextAlign.center
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 30, top: 18),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: black,
                                        width: 1,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(black),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 30, top: 12),
                            child: TextButton(
                              onPressed: () async {
                                SessionManagerMethods.clear();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginWithOTPScreen()), (Route<dynamic> route) => false);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: black,
                                          width: 1,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(black)
                              ),
                              child: isLoading
                                  ? const Padding(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: black,strokeWidth: 2)),
                              )
                                  : const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

}