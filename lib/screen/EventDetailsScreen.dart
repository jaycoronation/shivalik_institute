import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shivalik_institute/model/EventResponseModel.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';

class EventsDetailsScreen extends StatefulWidget {
  final EventList getSet;
  const EventsDetailsScreen(this.getSet, {Key? key}) : super (key: key);

  @override
  BaseState<EventsDetailsScreen> createState() => _EventsDetailsScreen();
}

class _EventsDetailsScreen extends BaseState<EventsDetailsScreen> {

  EventList getSet = EventList();

  @override
  void initState(){
    super.initState();

    getSet = (widget as EventsDetailsScreen).getSet;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: appBg,
          appBar: AppBar(
            toolbarHeight: kToolbarHeight,
            automaticallyImplyLeading: false,
            backgroundColor: appBg,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: false,
            leading: InkWell(
              borderRadius: BorderRadius.circular(52),
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12,right: 12,left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(checkValidString(getSet.title).toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: black),),
                      const Gap(12),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                universalDateConverter("yyyy-MM-dd","yyyy-MM-dd", getSet.date.toString()),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${getSet.bannerImage}&h=500&zc=2",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      errorWidget: (context, url, error) => Container(
                        color: grayNew,
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                      ),
                      placeholder: (context, url) => Container(
                        color: grayNew,
                        width: MediaQuery.of(context).size.width,
                        height: 280 ,
                      )
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(22, 32, 22, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkValidString(getSet.description).replaceAll("<p>&nbsp;</p>", "").toString().replaceAll("<br />", ""),
                          style: const TextStyle(color: black,fontWeight: FontWeight.w400,fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );
  }


  @override
  void castStatefulWidget() {
    widget is EventsDetailsScreen;
  }
}