import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/provider_categories_response.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ListingController extends ControllerMVC {
  List<ServiceValue> services = [];
  List<Banner> banners = [];
  Future<int> serviceListLoading = Future.value(0);
  Future<int> bannerListLoading = Future.value(0);

  ListingController() {
    listenForCategories();
  }

  ListingController.loadProvider();

  void listenForCategories() async {
    await getCategories().then((catResponse) {
      if (catResponse != null &&
          catResponse.status == 200 &&
          catResponse.data != null) {
        if (catResponse.data.values != null &&
            catResponse.data.values.isNotEmpty) {
          setState(() {
            services.addAll(catResponse.data.values);
            serviceListLoading = Future.value(1);
          });
        } else {
          setState(() => serviceListLoading = Future.value(2));
        }

        if (catResponse.data.banners != null &&
            catResponse.data.banners.isNotEmpty) {
          setState(() {
            banners.addAll(catResponse.data.banners);
            bannerListLoading = Future.value(1);
          });
        } else {
          setState(() => bannerListLoading = Future.value(2));
        }
      } else {
        setState(() {
          serviceListLoading = Future.value(2);
          bannerListLoading = Future.value(2);
        });
      }
    });
  }

  Future<void> getProviderCategories({Function(List<dynamic>) catList}) async {
    await getProviderCat().then((providerCatResponse) {
      if (providerCatResponse != null &&
          providerCatResponse.status == 200 &&
          providerCatResponse.data != null &&
          providerCatResponse.data.isNotEmpty) {
        print('Got categories');
        catList(providerCatResponse.getDataMap());
      }
    });
  }

  Future<void> refreshHome() async {
    services = <ServiceValue>[];
    setState(() {
      serviceListLoading = Future.value(0);
      bannerListLoading = Future.value(0);
    });
    listenForCategories();
  }
}
