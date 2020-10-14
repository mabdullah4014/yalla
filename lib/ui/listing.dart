import 'package:arbi/controller/listing_controller.dart';
import 'package:arbi/elements/listing/ServiceCarouselWidget.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/provider_categories_response.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/search_service_page.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:arbi/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;

class ListingWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ListingWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ListingWidgetState createState() => _ListingWidgetState();
}

class _ListingWidgetState extends StateMVC<ListingWidget> {
  ListingController _con;

  _ListingWidgetState() : super(ListingController()) {
    _con = controller;
  }

  int _current = 0;

  final double carouselHeight = 220.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Colors.white),
            onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  showCupertinoModalBottomSheet(
                      barrierColor: Theme.of(context).primaryColor,
                      useRootNavigator: true,
                      context: context,
                      enableDrag: false,
                      builder: (context, scrollController) {
                        return SearchServicePage(
                            services: _con.services,
                            onCategoriesSelected: (ServiceValue serviceValue) {
                              setState(() {
                                Constants.onServiceItemClick(
                                    context, DetailPageData(), serviceValue);
                              });
                            });
                      });
                })
          ],
          title: ValueListenableBuilder(
            valueListenable: settingsRepo.setting,
            builder: (context, value, child) {
              return Text(
                value.appName ?? S.of(context).home,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .merge(TextStyle(color: Colors.white)),
              );
            },
          ),
        ),
        body: SafeArea(
            child: RefreshIndicator(
                onRefresh: _con.refreshHome,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[_carouselBanners(), _categoriesListing()],
                )))));
  }

  Widget _carouselBanners() {
    return FutureBuilder<int>(
        future: _con.bannerListLoading,
        builder: (ctx, snapshot) {
          if (snapshot.data == 0) {
            return Container(
                height: carouselHeight,
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.data == 2) {
            return Container(
                height: carouselHeight,
                child: Center(child: Text(S.of(context).no_banners)));
          } else {
            return Column(children: [
              CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(
                          seconds: settingsRepo.setting.value.sliderDuration),
                      viewportFraction: 1,
                      height: carouselHeight,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: _con.banners.map((banner) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                              onTap: () {
                                Constants.onServiceItemClick(
                                    context, DetailPageData(), banner.service);
                              },
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: banner.path,
                                  placeholder: (context, url) => Image.asset(
                                      'assets/images/loading.gif',
                                      fit: BoxFit.fitWidth),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error))));
                    });
                  }).toList()),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _con.banners.map((url) {
                    int index = _con.banners.indexOf(url);
                    return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ));
                  }).toList())
            ]);
          }
        });
  }

  Widget _categoriesListing() {
    return FutureBuilder<int>(
        future: _con.serviceListLoading,
        builder: (ctx, snapshot) {
          if (snapshot.data == 0) {
            return Container(
                height: 150, child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.data == 2) {
            return Container(
                height: 150,
                child: Center(child: Text(S.of(context).no_categories)));
          } else {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _con.services.length,
                    itemBuilder: (context, index) {
                      return Column(children: <Widget>[
                        ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            title: Text(
                              _con.services.elementAt(index).name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppUtils.getColorFromHash('#A4A4A4')),
                            )),
                        ServicesCarouselWidget(
                            servicesList:
                                _con.services.elementAt(index).values),
                      ]);
                    }));
          }
        });
  }
}
