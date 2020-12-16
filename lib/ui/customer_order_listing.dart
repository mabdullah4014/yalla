import 'package:arbi/controller/customer_order_listing_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/customer_order_response.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CustomerOrderListingPage extends StatefulWidget {
  CustomerOrderListingPage({Key key}) : super(key: key);

  @override
  _CustomerOrderListingPageState createState() =>
      _CustomerOrderListingPageState();
}

class _CustomerOrderListingPageState
    extends StateMVC<CustomerOrderListingPage> {
  CustomerOrderListingController _con;

  _CustomerOrderListingPageState() : super(CustomerOrderListingController()) {
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
            S.of(context).my_order,
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
              trailing: Text(order.status_name))
        ],
      ),
    );
  }
}
