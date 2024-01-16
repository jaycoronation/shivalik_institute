import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/model/BatchResponseModel.dart';
import 'package:shivalik_institute/model/CityResponseModel.dart';
import 'package:shivalik_institute/model/CountryResponseModel.dart';
import 'package:shivalik_institute/model/CourseResponseModel.dart';
import 'package:shivalik_institute/screen/LoginWithOtpScreen.dart';
import 'package:shivalik_institute/utils/app_utils.dart';
import 'package:shivalik_institute/viewmodels/UserViewModel.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import '../common_widget/common_widget.dart';
import '../common_widget/loading.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/StateViewResponseModel.dart';
import '../model/UserProfileResponseModel.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../viewmodels/BatchViewModel.dart';
import '../viewmodels/CityViewModel.dart';
import '../viewmodels/CommonViewModel.dart';
import '../viewmodels/CountryViewModel.dart';
import '../viewmodels/CourseViewModel.dart';
import '../viewmodels/StateViewModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  BaseState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {

  bool isLoading = false;
  bool _isLoading = false;
  bool isCashSelected = false;
  bool isChequeSelected = false;
  bool isEnrollCourseSelected = false;
  bool isNetSelected = false;
  bool isHoldSeatSelected = false;
  var selectGender = "";
  String _countryId = "";
  String _stateId = "";
  String _cityId = "";
  String _batchId = "";
  String _courseId = "";
  Details userGetSet = Details();
  var pickImgPath = "";
  var file = File("");
  var passPickImgPath = "";
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
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

  List<BatchList> listBatches = [];
  List<CourseList> listCourse = [];

  void setData(Details getSet) {
    userGetSet = getSet;
    _prefixController.text = getSet.prefixName ?? "";
    _fNameController.text = getSet.firstName ?? "";
    _lNameController.text = getSet.lastName ?? "";
    _emailController.text = getSet.email ?? "";
    _contactController.text = getSet.contactNo ?? "";
    _genderController.text = toDisplayCase(getSet.gender ?? "");
    _ageController.text = getSet.age ?? '';
    _countryController.text = getSet.countryName ?? "";
    _stateController.text = getSet.stateName ?? "";
    _cityController.text = getSet.cityName ?? "";
    _addressController.text = getSet.address ?? "";
    _educationController.text = getSet.highestEducation ?? "";
    _designationController.text = getSet.designation ?? "";
    _pendingFeesController.text = getSet.pendingFees.toString() ?? "";
    _paidController.text = getSet.paidFees.toString() ?? "";
    _experienceController.text = getSet.yearsOfExperience.toString() ?? "";
    _cashController.text = getSet.paymentModeCashAmount.toString() ?? "";
    _holdSeatController.text = getSet.holdingSeatDesc.toString() ?? "";
    _netController.text = getSet.paymentModeNetbankingAmount.toString() ?? "";
    _chequeController.text = getSet.paymentModeChequeAmount.toString() ?? "";
    _enrollController.text = getSet.enrolledInCourseDesc.toString() ?? "";
    _courseNameController.text = getSet.courseName.toString() ?? "";

    isCashSelected = getSet.paymentModeCash == 1 ? true : false;
    isChequeSelected = getSet.paymentModeCheque == 1 ? true : false;
    isEnrollCourseSelected = getSet.enrolledInCourse == 1 ? true : false;
    isNetSelected = getSet.paymentModeNetbanking == 1 ? true : false;
    isHoldSeatSelected = getSet.holdingSeat == 1 ? true : false;

    _countryId = getSet.country ?? '';
    _stateId = getSet.state ?? '';
    _cityId = getSet.city ?? '';
    _batchId = getSet.batchId ?? '';

     _courseId = getSet.courseId ?? '';

     print("_courseId === ${_courseId}");

    for (var element in listBatches) {
      if (element.id == _batchId)
      {
        _batchController.text = "${element.name} - ${element.formatedDateTime}";
      }
    }

    for (var element in listCourse) {
      if (element.id == _courseId)
      {
        _courseNameController.text = element.name ?? '';
      }
    }

  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final commonViewModel = Provider.of<CommonViewModel>(context);

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
            title: getTitle("Profile"),
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
          body: Consumer<UserViewModel>(
            builder: (context, value, child) {
              if (value.isLoading)
                {
                  return const LoadingWidget();
                }
              else
                {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 22,),
                          GestureDetector(
                            onTap: () {
                              showFilePickerActionDialog();
                            },
                            child:  Center(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 120,
                                        child: CircleAvatar(
                                          maxRadius: 120,
                                          backgroundColor: grayLight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: ClipOval(
                                                child: file.path.isNotEmpty
                                                    ? Image.file(file,height: 150,width: 120, fit: BoxFit.cover,)
                                                    : userGetSet.profilePic.toString().isEmpty
                                                    ? Image.asset('assets/images/ic_user_placeholder.png',height: 120,width: 120,)
                                                    : Image.network(userGetSet.profilePic.toString(),height: 120,width: 120,fit: BoxFit.cover,)
                                            ),
                                          ),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(height: 26,),
                          Visibility(
                            visible: false,
                            child: Consumer<CourseViewModel>(
                              builder: (context, value, child) {
                                return  Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextField(
                                      onTap: (){
                                        openCourseBottomSheet(value.response.courseList ?? []);
                                      },
                                      readOnly: true,
                                      cursorColor: black,
                                      textCapitalization: TextCapitalization.words,
                                      controller: _courseNameController,
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
                                        margin: const EdgeInsets.only(right: 12),
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
                          ),
                          TextField(
                            onTap: (){
                              openPrefixBottomsheet();
                            },
                            readOnly: true,
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _prefixController,
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
                            controller: _fNameController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'First Name*',
                            ),
                          ),
                          Container(height: 18,),
                          TextField(
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _lNameController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Last Name*',
                            ),
                          ),
                          Container(height: 18,),
                          TextField(
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
                          TextField(
                            cursorColor: black,
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Age',
                            ),
                          ),
                          Container(height: 18,),
                          Consumer<CountryViewModel>(
                            builder: (context, value, child) {
                              return Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    onTap: (){
                                      openCountryBottomSheet(value.response.countries ?? []);
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
                                      margin: const EdgeInsets.only(right: 12),
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
                                      openStateBottomSheet(value.response.states ?? []);
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
                                      margin: const EdgeInsets.only(right: 12),
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
                                      openCityBottomSheet(value.response.cities ?? []);
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
                                      margin: const EdgeInsets.only(right: 12),
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
                          Visibility(
                            visible: false,
                            child: TextField(
                              readOnly: true,
                              cursorColor: black,
                              textCapitalization: TextCapitalization.words,
                              controller: _pendingFeesController,
                              keyboardType: TextInputType.number,
                              style: getTextFiledStyle(),
                              decoration: const InputDecoration(
                                labelText: 'Pending Fees.',
                              ),
                            ),
                          ), // Pending Fees
                          Visibility(
                            visible: false,
                            child: TextField(
                              readOnly: true,
                              cursorColor: black,
                              textCapitalization: TextCapitalization.words,
                              controller: _paidController,
                              keyboardType: TextInputType.number,
                              style: getTextFiledStyle(),
                              decoration: const InputDecoration(
                                labelText: 'Paid Fees *',
                              ),
                            ),
                          ),// Paid Fees
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
                          Visibility(
                            visible: false,
                            child: Consumer<BatchViewModel>(
                              builder: (context, value, child) {
                                return Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextField(
                                      onTap: (){
                                        // openBatchBottomSheet(value.response.batchList ?? []);
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
                                        margin: const EdgeInsets.only(right: 12),
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
                          ), // Batch Selection
                          Container(height: 22,),
                          /*const Text("Mode Of Payment" ,
                              style: TextStyle(fontSize: 16, color:black,fontWeight: FontWeight.w600),textAlign: TextAlign.center
                          ),
                          Container(height: 18,),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              print("is OUTSIDE ${isCashSelected}");
                                if (isCashSelected)
                                  {

                                    setState(() {
                                      isCashSelected = false;
                                    });
                                    print("is in if ${isCashSelected}");
                                  }
                                else
                                  {
                                    setState(() {
                                      isCashSelected = true;
                                    });
                                    print("is in else ${isCashSelected}");
                                  }
                              print("is OUTSIDE AFTER ${isCashSelected}");
                            },
                            child: Row(
                              children: [
                                isCashSelected
                                    ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                                    : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                                Container(width: 12,),
                                const Text("Cash" ,
                                    style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Container(height: 18,),
                          Visibility(
                            visible: isCashSelected,
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
                                isChequeSelected = isChequeSelected ? false : true;
                              });
                              print(isChequeSelected ? false : true);
                              print(isChequeSelected);
                            },
                            child: Row(
                              children: [
                                isChequeSelected
                                    ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                                    : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                                Container(width: 12,),
                                const Text("Cheque" ,
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
                                isNetSelected = !isNetSelected;
                              });
                            },
                            child: Row(
                              children: [
                                isNetSelected
                                    ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                                    : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                                Container(width: 12,),
                                const Text("Net Banking" ,
                                    style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Container(height: 18,),
                          Visibility(
                            visible: isNetSelected,
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
                                isHoldSeatSelected = !isHoldSeatSelected;
                              });
                            },
                            child: Row(
                              children: [
                                isHoldSeatSelected
                                    ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                                    : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                                Container(width: 12,),
                                const Text("Holding Seat" ,
                                    style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Container(height: 18,),
                          Visibility(
                            visible: isHoldSeatSelected,
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
                                isEnrollCourseSelected = !isEnrollCourseSelected;
                              });
                            },
                            child: Row(
                              children: [
                                isEnrollCourseSelected
                                    ? Image.asset('assets/images/ic_check.png', height: 20, width: 20,)
                                    : Image.asset('assets/images/ic_uncheckbox_blue.png',height: 20, width: 20,),
                                Container(width: 12,),
                                const Text("Enrolled Course" ,
                                    style: TextStyle(fontSize: 14, color:black,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Container(height: 18,),
                          Visibility(
                            visible: isEnrollCourseSelected,
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
                          ),*/ // Payment Mode
                          Container(
                            margin: const EdgeInsets.only(top: 18,left: 8, right: 8),
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

                                onPressed: () {
                                  saveData();
                                },
                                child: _isLoading
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
                  );
                }
            },
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

  void openCourseBottomSheet(List<CourseList> courseList) {
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
          builder: (context, updateState) {
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
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                _courseId = courseList[index].id ?? '';
                                _courseNameController.text = courseList[index].name ?? '';
                              });
                              
                              print("SELECTED COURSE === ${_courseId}");
                              
                              Navigator.pop(context);
                            },
                            child: Padding(
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

  void openCountryBottomSheet(List<Countries> list) {
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
          builder: (context, updateState) {
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
                                  getStateData();
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

  void openStateBottomSheet(List<States> list) {
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
          builder: (context, updateState) {
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
                                  getCityData();
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

  void openCityBottomSheet(List<Cities> list) {
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
          builder: (context, updateState) {
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
                            return GestureDetector(
                              onTap: () {
                                setState((){
                                  _cityId = list[index].id ?? '';
                                  _cityController.text = list[index].name ?? '';
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

  void openBatchBottomSheet(List<BatchList> list) {
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
          builder: (context, updateState) {
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
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ( context, index, ) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState((){
                                  _batchId = list[index].id ?? '';
                                  _batchController.text = "${list[index].name ?? "" } - ${list[index].formatedDateTime ?? "" }";
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
                                    child: Text("${list[index].name ?? "" } - ${list[index].formatedDateTime ?? "" }",
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
          builder: (context, updateState) {
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

  void getCountryData() {
    Provider.of<CountryViewModel>(context,listen: false).countryData();
  }

  Future<void> getCourseData() async {
    Map<String, String> jsonBody = {
      'page': "",
      'limit': "",
      'search' :"",
      'from_app' : FROM_APP
    };

    CourseViewModel courseViewModel = Provider.of<CourseViewModel>(context,listen: false);
    await courseViewModel.courseData(jsonBody);

    if (courseViewModel.response.success == '1')
      {
        CourseResponseModel getSet = courseViewModel.response;
        listCourse = getSet.courseList ?? [];

        for (var element in listCourse) {
          if (element.id == _courseId)
          {
            _courseNameController.text = element.name ?? '';
          }
        }
      }
  }

  void getStateData() {
    Map<String, String> jsonBody = {
      'country_id' : _countryId,
      'from_app' : FROM_APP
    };
    Provider.of<StateViewModel>(context,listen: false).stateData(jsonBody);
  }

  void getCityData() {
    Map<String, String> jsonBody = {
      'state_id' : _stateId,
      'from_app' : FROM_APP
    };
    Provider.of<CityViewModel>(context,listen: false).cityData(jsonBody);
  }

  Future<void> getBatchData() async {
    Map<String, String> jsonBody = {
      'limit' : "",
      'page' : "",
      'search' : "",
      'status' : "1",
      'from_app' : FROM_APP
    };
    BatchViewModel batchViewModel = Provider.of<BatchViewModel>(context,listen: false);
    await batchViewModel.batchData(jsonBody);

    if (batchViewModel.response.success == '1')
      {
        print("IS IN SIDE IF");
        print(batchViewModel.response.success);
        BatchResponseModel getSet = batchViewModel.response;
        listBatches = getSet.batchList ?? [];

        print(listBatches.length);
        print(_batchId);

        for (var element in listBatches) {
          if (element.id == _batchId)
          {
            _batchController.text = "${element.name} - ${element.formatedDateTime}";
          }
        }
      }

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
        setData(userViewModel.response.details ?? Details());
        getCountryData();
        getStateData();
        getCityData();
        getBatchData();
        getCourseData();
      }
    else
      {
        getCountryData();
        getStateData();
        getCityData();
        getBatchData();
        getCourseData();
      }

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

  void showFilePickerActionDialog() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text
        return Wrap(
          children: [
            Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 2,
                        width: 40,
                        color: black,
                        margin: const EdgeInsets.only(bottom: 12)),
                    const Text(
                      "Select Image From?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color:black,fontWeight: FontWeight.w600),
                    ),

                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        pickImageFromCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_camera.png',
                                height: 26, width: 26),
                            Container(width: 15),
                            const Text(
                              "Camera",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: black,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        pickImageFromGallery();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_gallery.png',
                                height: 26, width: 26),
                            Container(width: 15),
                            const Text(
                              "Gallery",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        );
      },
    );
  }

  File fileNew = File("");
  dynamic fileBytes;

  Future<void> _cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath
    );
    if (croppedFile != null) {
      setState(() {
        pickImgPath = croppedFile.path;
        file = File(pickImgPath);
        print("_pickImage picImgPath crop ====>$pickImgPath");
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      var pickedfiles =
      await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
      if (pickedfiles != null) {
        final filePath = pickedfiles.path;
        File tempFile = File(filePath);
        _cropImage(filePath);

        print("_pickImage picImgPath ====>$pickImgPath");
      } else {
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.gallery,  imageQuality: 50);
      if (pickedfiles != null) {
        final filePath = pickedfiles.path;
        File tempFile = File(filePath);
        print("tempFile === ${tempFile}");
        _cropImage(filePath);

      } else {
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  saveData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> jsonBody = {
      'user_type': "3",
      'batch_id': _batchId,
      'course_id': _courseId,
      'is_active': "1",
      'gender': _genderController.value.text,
      'prefix_name': _prefixController.value.text,
      'first_name': _fNameController.value.text,
      'last_name': _lNameController.value.text,
      'email': _emailController.value.text,
      'contact_no': _contactController.value.text,
      'date_of_birth': userGetSet.dateOfBirth ?? '',
      'highest_education': _educationController.value.text,
      'college_name': userGetSet.collegeName ?? '',
      'designation': _designationController.value.text,
      'paid_fees': _paidController.value.text,
      'pending_fees': _pendingFeesController.value.text,
      'years_of_experience': _experienceController.value.text,
      'id': sessionManager.getUserId() ?? '',
      'age': _ageController.value.text,
      'address': _addressController.value.text,
      'family_background': '',
      'city': _cityId,
      'country': _countryId,
      'state': _stateId,
      'document_submitted': jsonEncode(userGetSet.documentSubmitted),
      'payment_details': (userGetSet.paymentDetails ?? ""),
      'payment_mode': (userGetSet.paymentMode ?? ""),
      'payment_mode_cash': isCashSelected ? "1" : "0",
      'payment_mode_cheque': isChequeSelected ? "1" : "0",
      'payment_mode_netbanking': isNetSelected ? "1" : "0",
      'holding_seat': isHoldSeatSelected ? "1" : "0",
      'enrolled_in_course': isEnrollCourseSelected ? "1" : "0",
      'enrolled_in_course_desc': _enrollController.value.text,
      'holding_seat_desc': _holdSeatController.value.text,
      'payment_mode_netbanking_amount': _netController.value.text,
      'payment_mode_cheque_amount': _chequeController.value.text,
      'payment_mode_cash_amount': _cashController.value.text,
    };

    print(jsonBody);

    final url = Uri.parse(saveUserDataUrl);

    // Map<String, String> headers = {"Access-Token": sessionManager.getAccessToken().toString().trim()};

    http.MultipartRequest request = http.MultipartRequest('POST', url,);
    if (pickImgPath.isNotEmpty)
    {
      request.files.add(await http.MultipartFile.fromPath('profile_pic', pickImgPath));
    }
    //request.headers.("Access-Token": sessionManager.getAccessToken().toString().trim())
    request.fields.addAll(jsonBody);

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print("responseString == ${responseString}");
    final statusCode = response.statusCode;

    print(statusCode);

    Map<String, dynamic> user = jsonDecode(responseString);
    print(jsonEncode(user));
    var apiData = CommonResponseModel.fromJson(user);

    print(jsonEncode(apiData));

    if (statusCode == 200 && apiData.success == "1")
    {
      showToast(apiData.message, context);
      Navigator.pop(context, true);
      getUserData();
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(apiData.message, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

}