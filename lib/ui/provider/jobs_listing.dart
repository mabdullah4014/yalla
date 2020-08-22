import 'package:arbi/controller/jobs_listing_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class JobsListingPage extends StatefulWidget {
  JobsListingPage({Key key}) : super(key: key);

  @override
  _JobsListingPageState createState() => _JobsListingPageState();
}

class _JobsListingPageState extends StateMVC<JobsListingPage> {
  JobsListingController _con;

  _JobsListingPageState() : super(JobsListingController()) {
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
          child: (_con.categories != null && _con.categories.length > 0)
              ? RefreshIndicator(
                  onRefresh: _con.refreshHome,
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _con.categories.length,
                      itemBuilder: (context, index) {
                        return _listItem(index);
                      }))
              : Center(child: Text(S.of(context).no_jobs))),
    );
  }

  Widget _listItem(int index) {
    ServiceValue category = _con.categories[index];
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(category.image_path),
            ),
            title: Text(category.name),
            subtitle: Text(category.description),
            trailing: Text("category"),
          )
        ],
      ),
    );
  }
}
