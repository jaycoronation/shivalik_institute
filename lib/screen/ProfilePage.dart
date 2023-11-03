/*
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:reecosys_app/screen/DashBoardScreen.dart';
import 'package:reecosys_app/screen/tabs/HomePage.dart';
import 'package:reecosys_app/screen/tabs/bottom_navigation_bar_screen.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommanResponse.dart';
import '../model/CommonResponseModel.dart';
import '../model/CompanyListResponseModel.dart';
import '../model/CountryListResponse.dart';
import '../model/ProfileDetailsResponse.dart';
import '../model/ProfileDetailsResponseModelForCP.dart';
import '../model/ProfileOtherDetailsResponse.dart';
import '../model/RegisterCpResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_methods.dart';
import '../widget/common_widget.dart';
import '../widget/shimmer_profile.dart';
import 'LoginWithOtpScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends BaseState<ProfilePage> {

  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _countryContactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reraNoController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _companyNameSalesController = TextEditingController();
  var selectGender = "";

  List<CountryData> countryList = List<CountryData>.empty(growable: true);
  List<CompanyList> companyDataList = [];
  String countryContactCode = "91";
  var pickImgSelectedPath = "";
  var profileImageName = "";
  var profileImageGet = "";
  var assignProject = "";
  var companyName = "";
  var companyId = "";
  var profileDataOther = DataOther();

  @override
  void initState() {
    super.initState();

    if (isOnline)
    {
      if (getIsCp())
      {
        var profileData = userDataFromJson(sessionManager.getCpUserData() ?? "");
        var memberDataCP = memberDataFromJson(sessionManager.getCpMemberData() ?? "");

        _countryContactController.text = "+91 India";
        _nameController.text = checkValidString(profileData.firstName.toString() + " " + profileData.lastName.toString());
        _addressController.text = checkValidString(profileData.address);
        _reraNoController.text = checkValidString(profileData.reraNo);
        _emailController.text = checkValidString(profileData.emailAddress);
        _genderController.text = checkValidString(profileData.emailAddress);

        if (profileData.companyName !=null)
        {
          _companyController.text = checkValidString(profileData.companyName);
        }


        if (checkValidString(profileData.contactNo).toString().isNotEmpty)
        {
          var dataContact = profileData.contactNo.toString().split(" ");
          print("CONTACT NO ==== ${profileData.contactNo}");
          if(dataContact.isNotEmpty && dataContact.length == 2)
          {
            _contactController.text = dataContact[1];
          }
          else
          {
            _contactController.text = checkValidString(profileData.contactNo);
          }
        }

        sessionManager.setProfilePic(checkValidString(profileData.profileImage));
        profileImageName = checkValidString(profileData.profileImage);
        profileImageGet = checkValidString(profileData.profileImage);

        print("Profile Pic === ${sessionManager.getProfilePic()}");

        _birthdateController.text =profileData.birthdateTime.toString().isNotEmpty ?  getDateFromTimeStamp(int.parse(profileData.birthdateTime.toString() ?? "")) : "";

        _getProfileDataForCP(true);
        _getCompanyList();
      }
      else
      {
        setState(() {
          var profileData = dataProfileFromJson(sessionManager.getSalesProfileData() ?? "");
          profileDataOther = dataOtherFromJson(sessionManager.getSalesAllData() ?? "");

          _nameController.text = checkValidString(profileData.name);
          _userNameController.text = checkValidString(profileData.userName);
          _emailController.text = checkValidString(profileData.email);
          sessionManager.setGroupId(profileData.groupId.toString() ?? "");
          _countryContactController.text = "+91 India";

          sessionManager.setProfilePic(checkValidString(profileData.profileImageGet));
          profileImageName = checkValidString(profileData.profileImage);
          profileImageGet = checkValidString(profileData.profileImageGet);
          _birthdateController.text = profileData.birthdate.toString().isNotEmpty ? getDateFromTimeStamp(int.parse(profileData.birthdate.toString() ?? "")) : "";
          _companyNameSalesController.text = checkValidString(profileData.companyName);
          _genderController.text = checkValidString(profileData.gender);

          if(checkValidString(profileData.contactNo).toString().isNotEmpty)
          {
            var dataContact = profileData.contactNo.toString().split(" ");
            print("CONTACT NO NEW ==== ${dataContact.length}");
            if(dataContact!.isNotEmpty && dataContact.length == 2)
            {
              _contactController.text = dataContact[1];
            }
            else
            {
              _contactController.text = checkValidString(profileData.contactNo);
            }
          }

          if (profileDataOther.adminGroupData != null) {
            if (profileDataOther.adminGroupData!.projectAssignArray != null) {
              assignProject = "";
              if (profileDataOther.adminGroupData!.projectAssignArray!.isNotEmpty) {
                for (int i = 0; i < profileDataOther.adminGroupData!.projectAssignArray!.length; i++) {
                  if (assignProject.isEmpty)
                  {
                    assignProject = toDisplayCase(profileDataOther.adminGroupData!.projectAssignArray![i].type.toString().trim());
                  }
                  else
                  {
                    assignProject = assignProject + "," + toDisplayCase(profileDataOther.adminGroupData!.projectAssignArray![i].type.toString().trim());
                  }
                }
                _designationController.text = assignProject;
              }
            }

          }
        });

        print("1 DATA DEPARTMENET ==== ${toDisplayCase(profileDataOther.department.toString() ?? '')}");
        print("2 DATA DEPARTMENET ==== ${toDisplayCase(assignProject)}");

          _getProfileData(true);
      }
    }
    else
    {
      noInterNet(context);
    }

    if (sessionManager.getIsCPNew() ?? false)
      {
        _contactController.text = sessionManager.getContactNo().replaceAll("91 ", "");
      }

    _designationController.text = sessionManager.getProjectAssign().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: appBg,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        leading:  InkWell(
          borderRadius: BorderRadius.circular(52),
          onTap: () {
            if (sessionManager.getIsCPNew() ?? false)
              {
                SystemNavigator.pop();
              }
            else
              {
                Navigator.pop(context);
              }
          },
          child: getBackArrow(),
        ),
        title: Text("Profile",
          textAlign: TextAlign.start,
          style: getTitleTextStyle(),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              logoutFromApp();
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        children: [
                          Visibility(
                              visible: (sessionManager.getUserType() != "N" || sessionManager.getIsCPNew() == false),
                              child: Column(
                            children: [
                              cardProfileImage(),
                              const Gap(20),
                            ],
                          )
                          ),
                          TextField(
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Name*',
                            ),
                          ),
                          const Gap(20),
                          TextField(
                            cursorColor: black,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            readOnly: sessionManager.getEmail().isNotEmpty ? true : false,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Email*',
                            ),
                          ),
                          const Gap(20),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    TextField(
                                      cursorColor: black,
                                      textCapitalization: TextCapitalization.words,
                                      controller: _countryContactController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: () {
                                        _showSelectionDialog(1);
                                      },
                                      style: getTextFiledStyle(),
                                      decoration: const InputDecoration(
                                        labelText: 'Country*',
                                        counterText: "",
                                      ),
                                    ),
                                    const Positioned(
                                        top: 15,
                                        right: 10,
                                        child: Icon(Icons.keyboard_arrow_down_outlined, size: 18)),
                                  ],
                                )
                              ),
                              const Gap(10),
                              Expanded(
                                  flex: 3,
                                  child: TextField(
                                    textCapitalization: TextCapitalization.words,
                                  cursorColor: black,
                                  controller: _contactController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  readOnly: sessionManager.getContactNo().isNotEmpty ? true : false,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  style: getTextFiledStyle(),
                                  decoration: const InputDecoration(
                                    labelText: 'Contact No*',
                                    counterText: "",
                                  ),
                                )
                              )
                            ],
                          ),
                          const Gap(20),
                          TextField(
                            cursorColor: black,
                            textCapitalization: TextCapitalization.words,
                            controller: _birthdateController,
                            keyboardType: TextInputType.number,
                            style: getTextFiledStyle(),
                            decoration: const InputDecoration(
                              labelText: 'Birthdate',
                              hintText: 'DD/MM/YYYY',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                              LengthLimitingTextInputFormatter(10),
                              _DateFormatter(),
                            ],
                          ),
                          Visibility(
                            visible: sessionManager.getUserType() != "N",
                            child: Column(
                              children: [
                                const Gap(20),
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
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !getIsCp(),
                              child: const Gap(20)),
                          Visibility(
                            visible: false,
                            child: TextField(
                              cursorColor: black,
                              textCapitalization: TextCapitalization.words,
                              controller: _companyNameSalesController,
                              keyboardType: TextInputType.text,
                              style: getTextFiledStyle(),
                              readOnly: false,
                              decoration: const InputDecoration(
                                labelText: 'Company Name',
                              ),

                            ),
                          ),
                          const Gap(20),
                          Visibility(
                            visible: !getIsCp(),
                            child: Column(
                              children: [
                                TextField(
                                  cursorColor: black,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _designationController,
                                  keyboardType: TextInputType.text,
                                  readOnly: true,
                                  style: getTextFiledStyle(),
                                  decoration: const InputDecoration(
                                    labelText: 'Department',
                                  ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: (getIsCp() && sessionManager.getUserType() == "B"),
                            child: Column(
                              children: [
                                TextField(
                                  cursorColor: black,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _addressController,
                                  keyboardType: TextInputType.text,
                                  readOnly: false,
                                  maxLines: 3,
                                  style: getTextFiledStyle(),
                                  decoration: const InputDecoration(
                                    labelText: 'Address',
                                  ),
                                ),
                                const Gap(20),
                                TextField(
                                  cursorColor: black,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _reraNoController,
                                  keyboardType: TextInputType.text,
                                  readOnly: false,
                                  style: getTextFiledStyle(),
                                  decoration: const InputDecoration(
                                    labelText: 'Rera No.',
                                  ),
                                ),
                                const Gap(20),
                                Visibility(
                                  visible: sessionManager.getIsCPNew() == false,
                                    child:
                                TextField(
                                  cursorColor: black,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _companyController,
                                  keyboardType: TextInputType.text,
                                  readOnly: true,
                                  style: getTextFiledStyle(),
                                  decoration: const InputDecoration(
                                    labelText: 'Company Name.',
                                  ),
                                )
                                ),
                                Visibility(
                                    visible: sessionManager.getIsCPNew() == false,
                                    child: Gap(20)),
                                Visibility(
                                  visible: sessionManager.getIsCPNew() ?? false,
                                  child: Autocomplete<CompanyList>(
                                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                      return TextField(
                                        cursorColor: black,
                                        focusNode: focusNode,
                                        controller: textEditingController,
                                        keyboardType: TextInputType.text,
                                        style: getTextFiledStyle(),
                                        onChanged: (value) => onFieldSubmitted,
                                        onSubmitted: (value) => onFieldSubmitted,
                                        decoration: const InputDecoration(
                                          labelText: 'Company*',
                                        ),
                                      );
                                    },
                                    displayStringForOption: (option) {
                                      return option.name.toString();
                                    },
                                    optionsMaxHeight: 400,
                                    optionsBuilder: (TextEditingValue textEditingValue) {
                                      print(textEditingValue.text);
                                      companyName = textEditingValue.text;
                                      if (textEditingValue.text == '') {
                                        return const Iterable<CompanyList>.empty();
                                      }
                                      return companyDataList.where((CompanyList option) {
                                        return option.name.toString().toLowerCase().contains(textEditingValue.text.toLowerCase());
                                      });
                                    },
                                    onSelected: (CompanyList selection) {
                                      companyName = selection.name.toString();
                                      companyId = selection.id.toString();
                                      debugPrint('You just selected $companyName');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          Container(
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: black,
                                  backgroundColor: black,
                                  elevation: 0.0,
                                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                  side: const BorderSide(color: black, width: 1.0, style: BorderStyle.solid),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kEditTextCornerRadius)),
                                  tapTargetSize: MaterialTapTargetSize.padded,
                                  animationDuration: const Duration(milliseconds: 100),
                                  enableFeedback: true,
                                  alignment: Alignment.center, //set the button's child Alignment
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if (getIsCp())
                                    {
                                      if (_nameController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter a name", context);
                                      }
                                      else if (_emailController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter a email", context);
                                      }
                                      else if (!isValidEmail(_emailController.text.toString().trim()))
                                      {
                                        showSnackBar("Please enter valid email", context);
                                      }
                                      else if (_contactController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter contact no.", context);
                                      }
                                      else if (_birthdateController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter birth date.", context);
                                      }
                                      else if (_birthdateController.text.toString().length != 10)
                                      {
                                        showSnackBar("Please enter valid birth date.", context);
                                      }
                                      else
                                      {
                                        if (isOnline)
                                        {
                                          if (sessionManager.getIsCPNew() ?? false)
                                          {
                                            _registerCP();
                                          }
                                          else
                                          {
                                            _makeUpdateProfileRequest();
                                          }
                                        }
                                        else
                                        {
                                          noInterNet(context);
                                        }
                                      }
                                    }
                                  else
                                    {
                                      if (_nameController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter a name", context);
                                      }
                                      else if (_emailController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter a email", context);
                                      }
                                      else if (!isValidEmail(_emailController.text.toString().trim()))
                                      {
                                        showSnackBar("Please enter valid email", context);
                                      }
                                      else if (_contactController.text.toString().trim().isEmpty)
                                      {
                                        showSnackBar("Please enter contact no.", context);
                                      }
                                      else
                                      {
                                        if (_birthdateController.text.toString().isNotEmpty)
                                        {
                                          if (_birthdateController.text.toString().length != 10)
                                            {
                                              showSnackBar("Please enter valid birth date", context);
                                            }
                                          else
                                            {
                                              if (isOnline) {
                                                _makeUpdateProfileRequest();
                                              } else {
                                                noInterNet(context);
                                              }
                                            }
                                        }
                                        else
                                        {
                                          if (isOnline) {
                                            _makeUpdateProfileRequest();
                                          } else {
                                            noInterNet(context);
                                          }
                                        }

                                      }
                                    }
                                }, //set both onPressed and onLongPressed to null to see the disabled properties
                                onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                                child: const Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w400),
                                )),
                          ),
                          const Gap(16),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
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

  _registerCP() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_SERVICES + registerCP);
    Map<String, String> jsonBody = {
      'contact_no': "91 ${_contactController.value.text.trim()}",
      'name': _nameController.value.text,
      'email_address': _emailController.value.text,
      'birthdate': _birthdateController.value.text.isNotEmpty
          ? getTimeStampDate(_birthdateController.value.text, "dd/MM/yyyy")
          : "",
      'address': _addressController.value.text,
      'rera_no': _reraNoController.value.text,
      'company_name' : companyName,
      'company_id' : companyId,
      'from_application' : IS_FROM_APP,
      'from_cp_application' : IS_FROM_CP_APP,
      "new_user_flow" : "1",
      'logged_in_master_user_id_cp' : isWhiteLabel ? developerMasterId : ""
    };

    final response = await http.post(url, body: jsonBody,headers: {'Authorization' : Access_Token_Static});
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = RegisterCpResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      sessionManager.setMasterUserId(dataResponse.userId.toString());
      sessionManager.setIsCPNew(false);

      sessionManager.setName(_nameController.value.text);
      sessionManager.setContactNo("91 ${_contactController.value.text.trim()}");
      sessionManager.setEmail(_emailController.value.text);

      closeAndStartActivity(context, DashBoardScreen(true));
      showSnackBar(dataResponse.message, context);
    }
    else
    {
      if (mounted)
      { }
      showSnackBar(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget cardProfileImage() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              showImageActionDialog();
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                color: Colors.white,
                width: 120,
                height: 120,
                child: pickImgSelectedPath.isNotEmpty
                    ? Image.file(File(pickImgSelectedPath), fit: BoxFit.cover)
                    : sessionManager.getProfilePic().toString().isNotEmpty
                    ? FadeInImage.assetNetwork(
                  image: sessionManager.getProfilePic().toString() + "&h=500&zc=2",
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/ic_user_placeholder.png',
                )
                    : Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            right: -8,
            bottom: -8,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 9, // blur radius
                    offset: const Offset(0, 2), // changes position of shadow
                  )
                ],
              ),

              height: 36.0,
              width: 36.0,
              child:Center(
                child: IconButton(
                  icon: Image.asset("assets/images/ic_edit_pencil_new.png", width: 36, height: 36, color: black),
                  onPressed: () {
                    showImageActionDialog();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getCompanyList() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + companyList);
    Map<String, String> jsonBody = {
      'from_application' : IS_FROM_APP,
      'from_cp_application' : IS_FROM_APP,
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": Access_Token_Static,
    });
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CompanyListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.data != null) {
          companyDataList = dataResponse.data ?? [];
          print("companyDataList ==== ${companyDataList.length}");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  //getProfileData
  _getProfileData(bool isCallCountry) async {
    setState(() {
      //_isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + getProfileDetailsForSales);
    Map<String, String> jsonBody = {
      'logged_in_master_user_id': sessionManager.getMasterUserId(),
      'master_user_id': sessionManager.getMasterUserId(),
      'from_application' : IS_FROM_APP
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": sessionManager.getAuthToken().toString().trim(),
    });
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ProfileDetailsResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.data != null) {
          setState(() {
            _nameController.text = checkValidString(dataResponse.data?.name);
            _userNameController.text = checkValidString(dataResponse.data?.userName);
            _emailController.text = checkValidString(dataResponse.data?.email);
            sessionManager.setGroupId(dataResponse.data?.groupId.toString() ?? "");


            sessionManager.setProfilePic(checkValidString(dataResponse.data?.profileImageGet));
            profileImageName = checkValidString(dataResponse.data?.profileImage);
            profileImageGet = checkValidString(dataResponse.data?.profileImageGet);
            _birthdateController.text = dataResponse.data!.birthdate.toString().isNotEmpty ? getDateFromTimeStamp(int.parse(dataResponse.data?.birthdate.toString() ?? "")) : "";
            _companyNameSalesController.text = checkValidString(dataResponse.data?.companyName);
            _genderController.text = checkValidString(dataResponse.data?.gender);

            if(checkValidString(dataResponse.data?.contactNo).toString().isNotEmpty)
            {
              var dataContact = dataResponse.data?.contactNo.toString().split(" ");
              print("CONTACT NO NEW ==== ${dataResponse.data?.contactNo}");
              if(dataContact!.isNotEmpty && dataContact.length == 2)
              {
                _contactController.text = dataContact[1];
              }
              else
              {
                _contactController.text = checkValidString(dataResponse.data?.contactNo);
              }
            }

          });
        }
      } catch (e) {
        print(e);
      }
    }

    _getProfileDataNew();


    if(isCallCountry)
      {
        _getCountryList();
      }
    else
      {
        setState(() {
          _isLoading = false;
        });
      }

  }

  _getProfileDataForCP(bool isCountryCall)  async {
    setState(() {
      //_isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_SERVICES + getProfileDetails);
    Map<String, String> jsonBody = {
      'user_id': sessionManager.getMasterUserId(),
      'from_application' : IS_FROM_APP,
      'from_cp_application' : IS_FROM_CP_APP
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": sessionManager.getAuthToken().toString().trim(),
    });
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ProfileDetailsResponseModelForCP.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.data != null) {
          setState(() {
            var profileData = dataResponse.data?.userData ?? UserData();
            _nameController.text = checkValidString(profileData.firstName.toString() + " " + profileData.lastName.toString());
            _addressController.text = checkValidString(profileData.address);
            _reraNoController.text = checkValidString(profileData.reraNo);
            _emailController.text = checkValidString(profileData.emailAddress);
            _genderController.text = checkValidString(profileData.emailAddress);

            if (profileData.companyName !=null)
              {
                _companyController.text = checkValidString(profileData.companyName);
              }


            if (checkValidString(profileData.contactNo).toString().isNotEmpty)
            {
              var dataContact = profileData.contactNo.toString().split(" ");
              print("CONTACT NO ==== ${profileData.contactNo}");
              if(dataContact.isNotEmpty && dataContact.length == 2)
              {
                _contactController.text = dataContact[1];
              }
              else
              {
                _contactController.text = checkValidString(profileData.contactNo);
              }
            }

            sessionManager.setProfilePic(checkValidString(profileData.profileImage));
            profileImageName = checkValidString(profileData.profileImage);
            profileImageGet = checkValidString(profileData.profileImage);

            print("Profile Pic === ${sessionManager.getProfilePic()}");

            _birthdateController.text =profileData.birthdateTime.toString().isNotEmpty ?  getDateFromTimeStamp(int.parse(profileData.birthdateTime.toString() ?? "")) : "";

          });
        }
      } catch (e) {
        print(e);
      }

      if (isCountryCall)
        {
          _getCountryList();
        }

    }

    setState(() {
      _isLoading = false;
    });

    if (isCountryCall)
      {
        _getCountryList();
      }

    //_getProfileDataNew();
  }

  _getProfileDataNew() async {
    setState(() {
      //_isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + getProfileDetailsNewForSales);
    Map<String, String> jsonBody = {
      'logged_in_master_user_id': sessionManager.getMasterUserId(),
      'master_user_id': sessionManager.getMasterUserId(),
      'from_application' : IS_FROM_APP
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": sessionManager.getAuthToken().toString().trim(),
    });
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ProfileOtherDetailsResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.data != null) {
          profileDataOther = dataResponse.data!;

          if (profileDataOther.adminGroupData != null) {

            if (profileDataOther.adminGroupData!.projectAssignArray != null)
            {

              assignProject = "";
              if(profileDataOther.adminGroupData!.projectAssignArray!.isNotEmpty)
              {
                for(int i =0 ; i<profileDataOther.adminGroupData!.projectAssignArray!.length; i++)
                {
                  if(assignProject.isEmpty)
                  {
                    assignProject = toDisplayCase(profileDataOther.adminGroupData!.projectAssignArray![i].type.toString().trim());
                  }
                  else
                  {
                    assignProject = assignProject + ","+ toDisplayCase(profileDataOther.adminGroupData!.projectAssignArray![i].type.toString().trim());
                  }
                }
                _designationController.text = assignProject;
              }
            }

            _designationController.text = toDisplayCase(dataResponse.data?.department.toString() ?? '');


          }
        }
      } catch (e) {
        print(e);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  _getCountryList() async {
    setState(() {
      //_isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + countryListApi);
    Map<String, String> jsonBody = {
      'logged_in_master_user_id': sessionManager.getMasterUserId(),
      'from_application' : IS_FROM_APP
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": sessionManager.getAuthToken().toString().trim(),
    });
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CountryListResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.data != null) {
          if (dataResponse.data!.isNotEmpty) {
            countryList = dataResponse.data!;

            if(countryContactCode.isNotEmpty)
            {
              for (int i = 0; i < countryList.length; i++)
              {
                if (countryContactCode == countryList[i].phonecode.toString())
                {
                  _countryContactController.text = "${"+" + checkValidString(countryList[i].phonecode)} " + checkValidString(countryList[i].name);
                  break;
                }
              }
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  //API call function...
  _makeUpdateProfileRequest() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri();

    if (getIsCp())
      {
        url = Uri.parse(API_URL_SERVICES + updateProfileForCP);
      }
    else
      {
        url = Uri.parse(API_URL + updateProfile);
      }

    var request = MultipartRequest("POST", url);
    Map<String, String> headers = {"Authorization": sessionManager.getAuthToken().toString().trim()};

    if (getIsCp())
      {
        request.headers.addAll(headers);
        request.fields['first_name'] = _nameController.value.text.trim();
        request.fields['last_name'] = "";
        request.fields['email_address'] = _emailController.value.text.trim();
        request.fields['contact_no'] = "$countryContactCode ${_contactController.value.text.trim()}";
        request.fields['phonecode'] = countryContactCode;
        request.fields['address'] = _addressController.value.text;
        request.fields['rera_no'] = _reraNoController.value.text;
        request.fields['user_type'] = "b";
        request.fields['birthdate'] = _birthdateController.value.text.isNotEmpty
            ? getTimeStampDate(_birthdateController.value.text, "dd/MM/yyyy")
            : "";
        request.fields['user_id'] = sessionManager.getMasterUserId();
        request.fields['from_application'] = IS_FROM_APP;
        request.fields['from_cp_application'] = IS_FROM_CP_APP;
        request.fields['gender'] = _genderController.value.text.trim();

      }
    else
      {
        request.headers.addAll(headers);
        request.fields['name'] = _nameController.value.text.trim();
        request.fields['user_name'] = _userNameController.value.text.isNotEmpty
            ? _userNameController.value.text.trim()
            : _nameController.value.text.trim().toString().toLowerCase().replaceAll(" ", "_");
        request.fields['email'] = _emailController.value.text.trim();
        request.fields['contact_no'] = "$countryContactCode ${_contactController.value.text.trim()}";
        request.fields['contact_no_display'] =  _contactController.value.text.trim();
        request.fields['phonecode'] = countryContactCode;
        request.fields['master_user_id'] = sessionManager.getMasterUserId();
        request.fields['group_id'] =  sessionManager.getGroupId();
        request.fields['birthdate'] = _birthdateController.value.text.isNotEmpty
            ? getTimeStampDate(_birthdateController.value.text, "dd/MM/yyyy")
            : "";
        request.fields['logged_in_master_user_id'] = sessionManager.getMasterUserId();
        request.fields['account_name'] = "0";
        request.fields['is_active'] = "1";
        request.fields['subscription_plan'] = "";
        request.fields['from_application'] = IS_FROM_APP;
        request.fields['gender'] = _genderController.value.text.trim();
        request.fields['company_name'] = _companyNameSalesController.value.text.trim();
      }

    print(request.fields);
    print(request.url);


    if(pickImgSelectedPath.isNotEmpty)
      {
        var multipartFile = await MultipartFile.fromPath("profile_image", pickImgSelectedPath);
        request.fields['upload_type'] = 'profile_image';
        request.files.add(multipartFile);
      }
    else
      {
        request.fields['profile_image'] = profileImageName;
      }

    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> user = jsonDecode(responseString);
    var commonResponse = CommonResponse.fromJson(user);
    print(commonResponse.toJson());
    if (commonResponse.success == 1) {
      showSnackBar(commonResponse.message, context);

      sessionManager.setName(_nameController.value.text);
      sessionManager.setContactNo("91 ${_contactController.value.text.trim()}");
      sessionManager.setEmail(_emailController.value.text);

      if (getIsCp())
        {
          if(pickImgSelectedPath.isNotEmpty)
          {
            _makeUpdateProfilePic();
          }
          else
          {
            Navigator.pop(context,"success");
          }
        }
      else
        {
          Navigator.pop(context,"success");
        }
    }
    else
    {
      showSnackBar(commonResponse.message, context);
    }
    setState(() {
      _isLoading = false;
    });

  }

  _makeUpdateProfilePic() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_SERVICES + uploadProfilePicForCP);
    var request = MultipartRequest("POST", url);
    Map<String, String> headers = {"Authorization": sessionManager.getAuthToken().toString().trim()};
    request.headers.addAll(headers);

    request.fields['user_id'] = sessionManager.getMasterUserId();
    request.fields['from_application'] = IS_FROM_APP;
    request.fields['from_cp_application'] = IS_FROM_CP_APP;


    if(pickImgSelectedPath.isNotEmpty)
    {
      var multipartFile = await MultipartFile.fromPath("image", pickImgSelectedPath);
      request.fields['upload_type'] = 'profile_image';
      request.files.add(multipartFile);
    }
    else
    {
      request.fields['profile_image'] = profileImageName;
    }

    print(request);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> user = jsonDecode(responseString);
    var commonResponse = CommonResponseModel.fromJson(user);
    print(commonResponse.toJson());
    if (commonResponse.success == 1) {
      showSnackBar(commonResponse.message, context);
      Navigator.pop(context,"success");
    }
    else
    {
      showSnackBar(commonResponse.message, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showSelectionDialog(int isFor) {
    String title = "";
    if (isFor == 1) {
      title = "Select Country";
    }

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStatenew) {
            return SizedBox(
              height: getItemCount(isFor) > 10 ? MediaQuery.of(context).size.height * 0.85 : MediaQuery.of(context).size.height * 0.60,
              child:  Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 2,
                      width: 28,
                      alignment: Alignment.center,
                      color: black,
                      margin: const EdgeInsets.only(top: 10, bottom: 12),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Text(title, style: const TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Expanded(child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: getItemCount(isFor),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isFor == 1) {
                                        if (countryList[index].phonecode != countryContactCode) {
                                          countryContactCode = checkValidString(countryList[index].phonecode);
                                          _countryContactController.text = "+" + checkValidString(countryList[index].phonecode) + " " + checkValidString(countryList[index].name);
                                        }
                                        Navigator.of(context).pop();
                                      }
                                    });

                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
                                        alignment: Alignment.centerLeft,
                                        child: setTextData(isFor, index),
                                      ),
                                      Container(height: 0.5, color: grayLight)
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          });
        });
  }

  getItemCount(int isFor) {
    if (isFor == 1) {
      return countryList.length;
    }
  }

  setTextData(int isFor, int index) {
    if (isFor == 1) {
      return Text(
        checkValidString("(+${countryList[index].phonecode})  ${countryList[index].name}"),
        style: TextStyle(
            fontSize: 18,
            fontWeight: countryList[index].phonecode == countryContactCode.toString() ? FontWeight.w400 : FontWeight.w400,
            color: countryList[index].phonecode == countryContactCode.toString() ? blue : black),
      );
    }
  }

  void showImageActionDialog() {
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
        return Wrap(
          children: [
            Padding(padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: 2,width : 40,color: black,margin: const EdgeInsets.only(bottom:12)),
                    const Text("Select Image From?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),),
                    Container(height: 12),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        pickImageFromCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_camera.png',
                                height: 26,
                                width: 26),
                            Container(width: 15),
                            const Text("Camera",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: grayLight,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        pickImageFromGallery();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_gallery.png', height: 26, width: 26),
                            Container(width: 15),
                            const Text("Gallery", textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 12)
                  ],
                )
            )
          ],
        );
      },
    );
  }

  Future<void> pickImageFromCamera() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.camera);
      if(pickedfiles != null){
        final filePath = pickedfiles.path;
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
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedfiles != null){
        final filePath = pickedfiles.path;
        _cropImage(filePath);
      }else{
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
        pickImgSelectedPath = croppedFile.path;
        print("_pickImage picImgPath crop ====>$pickImgSelectedPath");
      });
    }
  }

  void logoutFromApp() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 2,
                    width: 40,
                    alignment: Alignment.center,
                    color: black,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                  ),
Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('Logout from REECOSYS Sales', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: black))),

                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child:
                    const Text('Are you sure you want to logout?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: kButtonHeight,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(kBorderRadius),
                                          side: const BorderSide(width: 1,color: black)
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No",
                                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: black)),
                                ))),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            height: kButtonHeight,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(kBorderRadius),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(black)),
                              onPressed: () async {
                                Navigator.pop(context);
                                SessionManagerMethods.clear();
                                await FlutterAppBadger.removeBadge();
                                sessionManager.setIsHintVisible(true);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginWithOTPScreen()), (Route<dynamic> route) => false);
                              },
                              child: const Text("Yes",
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: white)),
                            ),
                          ),
                        ),
                      ],
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

  @override
  void castStatefulWidget() {
    widget is ProfilePage;
  }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
*/
