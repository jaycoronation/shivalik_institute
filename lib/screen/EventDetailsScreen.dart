
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

import 'package:shivalik_institute/common_widget/loading.dart';
import 'package:shivalik_institute/common_widget/no_data_new.dart';
import 'package:shivalik_institute/constant/global_context.dart';
import 'package:shivalik_institute/model/EventResponseModel.dart';
import 'package:shivalik_institute/utils/full_screen_image.dart';
import '../common_widget/common_widget.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../viewmodels/EventViewModel.dart';

class EventsDetailsScreen extends StatefulWidget {
  final EventList getSet;
  const EventsDetailsScreen(this.getSet, {Key? key}) : super (key: key);

  @override
  BaseState<EventsDetailsScreen> createState() => _EventsDetailsScreen();
}

class _EventsDetailsScreen extends BaseState<EventsDetailsScreen> {

  EventList getSet = EventList();
  bool isLoading = false;
  bool isNoDataFound = false;

  @override
  void initState(){
    super.initState();

    getSet = (widget as EventsDetailsScreen).getSet;

    if (NavigationService.notif_id.isNotEmpty)
      {
        getEventsList();
      }
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
          body: isLoading
              ? const LoadingWidget()
              : isNoDataFound
              ? const MyNoDataNewWidget(msg: "Event not found", img: '')
              : SingleChildScrollView(
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
                          Text(
                            universalDateConverter("yyyy-MM-dd","dd MMM, yyyy", getSet.date.toString()),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Visibility(
                            visible: getSet.eventType == "Master Class",
                            child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: brandColor
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                              child: Text(getSet.eventType ?? '',style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w500)),
                            ),
                          )
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
                    Visibility(
                      visible: getSet.eventGallery?.isNotEmpty ?? false,
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        height: 100,
                        child: ListView.builder(
                          itemCount: (getSet.eventGallery?.length ?? 0) > 7 ? 8 : getSet.eventGallery?.length ?? 0,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                            if (index == 7)
                              {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    List<String> tempImages = [];

                                    for (var i=0; i < (getSet.eventGallery?.length ?? 0); i++)
                                    {
                                      tempImages.add("${getSet.eventGallery?[i].image ?? ''}&h=900&zc=2");
                                    }

                                    startActivity(context, FullScreenImage("${getSet.eventGallery?[0].image ?? ''}&h=900&zc=2", tempImages, 0));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      height: 100,
                                      width: 100,
                                      color: grayNew,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/ic_viewall_images.png',width: 28,height: 28,),
                                          const Gap(8),
                                          const Text("View all",style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w500),)
                                        ],
                                      )
                                  ),
                                );
                              }
                            else
                              {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    List<String> tempImages = [];

                                    for (var i=0; i < (getSet.eventGallery?.length ?? 0); i++)
                                      {
                                        tempImages.add("${getSet.eventGallery?[i].image ?? ''}&h=900&zc=2");
                                      }

                                    startActivity(context, FullScreenImage("${getSet.eventGallery?[index].image ?? ''}&h=900&zc=2", tempImages, index));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        "${getSet.eventGallery?[index].image ?? ''}&h=500&zc=2",
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      )
                                  ),
                                );
                              }

                            },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(22, 32, 22, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HtmlWidget(
                            checkValidString(getSet.description),
                            textStyle: const TextStyle(fontSize: 16, color: grayDark, fontWeight: FontWeight.w400),
                          ),
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

  Future<void> getEventsList() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> jsonBody = {
      'filter': "",
      'filter_by': "",
      'limit': "999",
      'page': '1',
      'search': "",
      'status': "1",
      'from_app' : FROM_APP
    };
    var eventViewModel = Provider.of<EventViewModel>(context,listen: false);
    await eventViewModel.getEventsList(jsonBody);

    if (eventViewModel.response.success == "1")
    {
      List<EventList>? _tempList = [];
      _tempList = eventViewModel.response.eventList;

      print("NavigationService ==== ${NavigationService.notif_id}");

      if (_tempList?.isNotEmpty ?? false)
      {
        for (var i=0; i < (_tempList?.length ?? 0); i++)
        {
          if (_tempList?[i].id == NavigationService.notif_id)
            {
              isNoDataFound = false;
              getSet = _tempList?[i] ?? EventList();
              break;
            }
          else
            {
              isNoDataFound = true;
            }
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is EventsDetailsScreen;
  }
}