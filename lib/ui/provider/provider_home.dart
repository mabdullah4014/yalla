import 'package:arbi/controller/provider_job_controller.dart';
import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/customer_order_response.dart';
import 'package:arbi/model/update_job_request.dart';
import 'package:arbi/repo/settings_repository.dart' as settingsRepo;
import 'package:arbi/ui/provider/provider_drawer.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class ProviderHomePageScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ProviderHomePageScreen({Key key});

  @override
  _ProviderHomePageScreenState createState() {
    return _ProviderHomePageScreenState();
  }
}

class _ProviderHomePageScreenState extends StateMVC<ProviderHomePageScreen> {
  ProviderJobController _con;

  _ProviderHomePageScreenState() : super(ProviderJobController(true)) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
            key: widget.scaffoldKey,
            drawer: ProviderDrawerWidget(),
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.sort, color: Colors.white),
                onPressed: () => widget.scaffoldKey.currentState.openDrawer(),
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
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
              _profileBanner(),
//                _infoLayout(),
              _pendingJobs()
            ])))));
  }

  Widget _profileBanner() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Container(
              child: Image.asset('assets/images/logo_circle.png',
                  fit: BoxFit.contain, width: 100, height: 70)),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentUser.value.business_name,
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  Text(currentUser.value.name,
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                ]),
          )
        ],
      ),
    );
  }

  /*Widget _infoLayout() {
    return Row(children: <Widget>[
      Flexible(
          fit: FlexFit.tight,
          child: IconButton(
              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.yellow),
              onPressed: () {}),
          flex: 1),
      Flexible(
          fit: FlexFit.tight,
          child: IconButton(
              icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.yellow),
              onPressed: () {}),
          flex: 1),
      Flexible(
          fit: FlexFit.tight,
          child: IconButton(
              icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.yellow),
              onPressed: () {}),
          flex: 1)
    ]);
  }*/

  Widget _pendingJobs() {
    return Visibility(
        visible: _con.orders != null && _con.orders.length > 0,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(S.of(context).available_jobs,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
              ListView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _con.orders.length,
                  itemBuilder: (context, index) {
                    return _listItem(index);
                  })
            ],
          ),
        ));
  }

  Widget _listItem(int index) {
    Order order = _con.orders[index];
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(order.category_name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Visibility(
                        visible: (order.service_provider_name != null &&
                            order.service_provider_name.isNotEmpty),
                        child: Text(
                            '${S.of(context).provider_name} : ${order.service_provider_name}')),
                    Text('${S.of(context).price} : ${order.amount}')
                  ]),
              trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      order.status_name,
                      style: TextStyle(fontSize: 10),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 30,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(S.of(context).accept,
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            changeOrderStatus(order);
                          },
                        ))
                  ]))
        ],
      ),
    );
  }

  void changeOrderStatus(Order order) {
    int changeStatus;
    if (order.status == '100')
      changeStatus = 200;
    else if (order.status == '200')
      changeStatus = 300;
    else if (order.status == '300') changeStatus = 400;
    AppUtils.onLoading(context, message: S.of(context).updating);
    _con.updateJob(
        UpdateJobRequest(
            order.id, changeStatus, int.parse(currentUser.value.id)),
        orderUpdated: (bool status) {
      Navigator.of(context).pop();
      if (status) {
        AppUtils.showMessage(
            context, S.of(context).app_name, S.of(context).order_update,
            callback: () {
          Navigator.of(context).pop();
          _con.refreshHome();
        });
      } else {
        AppUtils.showMessage(
            context, S.of(context).error, S.of(context).order_update_error);
      }
    });
  }
}