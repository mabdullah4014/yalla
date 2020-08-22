import 'package:arbi/model/cat_response.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class JobsListingController extends ControllerMVC {
  List<ServiceValue> categories = <ServiceValue>[];

  JobsListingController() {
    listenForCategories();
  }

  void listenForCategories() async {
    final Stream<ServiceValue> stream = await getCategoriesDump();
    stream.listen((ServiceValue _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshHome() async {
    categories = <ServiceValue>[];
    listenForCategories();
  }
}
