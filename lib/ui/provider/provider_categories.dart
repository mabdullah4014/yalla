import 'package:arbi/controller/listing_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/provider_categories_response.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProviderCategoryPage extends StatefulWidget {
  ProviderCategoryPage({this.selectedItems, this.onCategoriesSelected});

  final List<ProviderCategory> selectedItems;
  final Function(List<ProviderCategory>) onCategoriesSelected;

  @override
  _ProviderCategoryPageState createState() =>
      _ProviderCategoryPageState(selectedItems);
}

class _ProviderCategoryPageState extends StateMVC<ProviderCategoryPage> {
  ListingController listingController;
  List<ProviderCategory> selectedItems;
  List<ProviderCategory> _initialCategories;

  _ProviderCategoryPageState(List<ProviderCategory> selectedItems) {
    this.selectedItems = selectedItems;
    _initialCategories = [];
    listingController = ListingController.loadProvider();
    listingController.getProviderCategories(
        catList: (List<ProviderCategory> list) {
      setState(() {
        _initialCategories.addAll(list);
        for (ProviderCategory category in selectedItems) {
          for (ProviderCategory item in _initialCategories) {
            if (category.id == item.id) {
              item.isSelected = true;
              break;
            }
          }
        }
      });
    });
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
            actions: [
              IconButton(
                icon: Icon(Icons.save, color: Colors.white),
                tooltip: S.of(context).submit,
                onPressed: () {
                  if (isValid()) {
                    List<ProviderCategory> selectedItems = [];
                    for (ProviderCategory category in _initialCategories) {
                      if (category.isSelected) {
                        selectedItems.add(category);
                      }
                    }
                    widget.onCategoriesSelected(selectedItems);
                    Navigator.of(context).pop();
                  } else {
                    AppUtils.showMessage(context, S.of(context).error,
                        S.of(context).select_category_to_proceed);
                  }
                },
              )
            ],
            title: Text(
              S.of(context).categories,
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
                child: Stack(children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _initialCategories.length,
                      itemBuilder: (context, index) {
                        return _listItem(index);
                      })
                ]))));
  }

  Widget _listItem(int index) {
    ProviderCategory providerCategory = _initialCategories[index];
    return Card(
      child: Column(children: <Widget>[
        ListTile(
            title: Text(providerCategory.name),
            leading: Checkbox(
              value: _initialCategories[index].isSelected,
              onChanged: (input) {
                setState(() {
                  _initialCategories[index].isSelected = input;
                });
              },
            ))
      ]),
    );
  }

  bool isValid() {
    bool valid = false;
    for (ProviderCategory category in _initialCategories) {
      if (category.isSelected) {
        return true;
      }
    }
    return valid;
  }
}
