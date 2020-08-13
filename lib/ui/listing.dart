import 'package:arbi/controller/listing_controller.dart';
import 'package:arbi/elements/listing/ServiceCarouselWidget.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1,
                          height: 150.0,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: AppUtils.getRandomColor()),
                                child: Text(
                                  'text $i',
                                  style: TextStyle(fontSize: 16.0),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1, 2, 3, 4, 5].map((url) {
                        int index = [1, 2, 3, 4, 5].indexOf(url);
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
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: _con.categories.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                      dense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      title: Text(
                                        _con.categories.elementAt(index).name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppUtils.getColorFromHash(
                                                '#A4A4A4')),
                                      )),
                                  ServicesCarouselWidget(
                                      servicesList: _con.categories
                                          .elementAt(index)
                                          .services),
                                ],
                              );
                            }))
                  ],
                ),
              ))),
    );
  }
}
