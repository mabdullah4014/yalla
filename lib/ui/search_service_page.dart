import 'package:arbi/controller/listing_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/provider_categories_response.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchServicePage extends StatefulWidget {
  SearchServicePage({this.services, this.onCategoriesSelected});

  final List<ServiceValue> services;
  final Function(ServiceValue) onCategoriesSelected;

  @override
  _SearchServicePageState createState() => _SearchServicePageState();
}

class _SearchServicePageState extends StateMVC<SearchServicePage> {
  ListingController listingController;
  List<ServiceValue> services;
  TextEditingController editingController = TextEditingController();
  var items = List<ServiceValue>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services = [];
    for (ServiceValue serviceValue in widget.services) {
      if (serviceValue.values != null && serviceValue.values.isNotEmpty) {
        services.addAll(serviceValue.values);
        items.addAll(serviceValue.values);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context)),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: Text(
              S.of(context).search_categories,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .merge(TextStyle(color: Colors.white)),
            )),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: SingleChildScrollView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              labelText: S.of(context).search,
                              prefixIcon: Icon(Icons.search),
                              hintText: S.of(context).search))),
                  SizedBox(height: 10),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _listItem(index);
                      })
                ]))));
  }

  Widget _listItem(int index) {
    ServiceValue serviceValue = items[index];
    return InkWell(
        onTap: () {
          widget.onCategoriesSelected(serviceValue);
        },
        child: Card(
            child: ListTile(
                title: Text(serviceValue.name),
                leading: Container(
                    width: 50,
                    height: 50,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(), color: Colors.grey.shade200),
                    child: DecoratedBox(
                        decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    serviceValue.image_path))))))));
  }

  void filterSearchResults(String query) {
    List<ServiceValue> dummySearchList = List<ServiceValue>();
    dummySearchList.addAll(services);
    if (query.isNotEmpty) {
      List<ServiceValue> dummyListData = List<ServiceValue>();
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(services);
      });
    }
  }
}
