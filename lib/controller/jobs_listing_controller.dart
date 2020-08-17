import 'package:arbi/model/category_response.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class JobsListingController extends ControllerMVC {
  List<Category> categories = <Category>[];

  JobsListingController() {
    listenForCategories();
  }

  void listenForCategories() async {
    final Stream<Category> stream = await getCategoriesDump();
    stream.listen((Category _category) {
//      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshHome() async {
    categories = <Category>[];
    listenForCategories();
  }
}
