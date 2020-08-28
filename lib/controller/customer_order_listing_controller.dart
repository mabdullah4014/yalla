import 'package:arbi/model/customer_order_response.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CustomerOrderListingController extends ControllerMVC {
  List<Order> orders = [];

  CustomerOrderListingController() {
    getOrders();
  }

  void getOrders() async {
    getCustomerOrders().then((value) {
      setState(() {
        if (value.status == 200) orders.addAll(value.orders);
      });
    });
  }

  Future<void> refreshHome() async {
    orders = [];
    getOrders();
  }
}
