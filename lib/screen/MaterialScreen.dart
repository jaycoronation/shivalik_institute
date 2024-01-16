import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shivalik_institute/model/ModuleResponseModel.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/LecturesResponseModel.dart';
import '../utils/base_class.dart';
import '../viewmodels/LectureViewModel.dart';
import 'MaterialDetailScreen.dart';
import 'ResourceCenterClassScreen.dart';
import 'ResourceMaterialScreen.dart';

class MaterialScreen extends StatefulWidget {
  final ModuleList getSet;
  final LectureList classGetSet;
  const MaterialScreen(this.getSet, this.classGetSet, {super.key});

  @override
  BaseState<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends BaseState<MaterialScreen> {
  int _pageIndex = 1;
  bool _isSearchHideShow = false;
  final int _pageResult = 10;


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
              centerTitle: false,
              title: getTitle("Resource Center",),

            ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            startActivity(context, MaterialDetailScreen((widget as MaterialScreen).getSet,(widget as MaterialScreen).classGetSet));
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.folder_copy_outlined,size: 28,),
                                Gap(12),
                                Text("Materials",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w400),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(width: 12,),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            startActivity(context, ResourceMaterialScreen((widget as MaterialScreen).getSet,(widget as MaterialScreen).classGetSet));
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(8),

                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.folder_copy_outlined,size: 28,),
                                Gap(12),
                                Text("Submissions",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w400),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
    widget is MaterialScreen;
  }


}