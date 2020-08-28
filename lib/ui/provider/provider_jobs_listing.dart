import 'package:arbi/controller/customer_order_listing_controller.dart';
import 'package:arbi/controller/provider_job_controller.dart';
import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/customer_order_response.dart';
import 'package:arbi/model/update_job_request.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProviderJobsListingPage extends StatefulWidget {
  ProviderJobsListingPage({Key key}) : super(key: key);

  @override
  _ProviderJobsListingPageState createState() =>
      _ProviderJobsListingPageState();
}

class _ProviderJobsListingPageState extends StateMVC<ProviderJobsListingPage> {
  ProviderJobController _con;

  _ProviderJobsListingPageState() : super(ProviderJobController(false)) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).jobs,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(color: Colors.white)),
          )),
      body: SafeArea(
          child: (_con.orders != null && _con.orders.length > 0)
              ? RefreshIndicator(
                  onRefresh: _con.refreshHome,
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _con.orders.length,
                      itemBuilder: (context, index) {
                        return _listItem(index);
                      }))
              : Center(child: Text(S.of(context).no_jobs))),
    );
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
                          child: Text(S.of(context).change_status,
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
