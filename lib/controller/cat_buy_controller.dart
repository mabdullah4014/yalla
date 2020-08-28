import 'package:arbi/model/check_service_request.dart';
import 'package:arbi/model/place_order_request.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CheckServiceController extends ControllerMVC {
  void checkPrice(CheckServiceRequest checkServiceRequest,
      {Function(double, CheckServiceRequest) onPriceCheck}) async {
    await getServicePrice(checkServiceRequest).then((checkResponse) {
      if (checkResponse != null && checkResponse.status == 200) {
        checkServiceRequest.target = checkResponse.target;
        onPriceCheck(checkResponse.price, checkServiceRequest);
      } else {
        onPriceCheck(0, null);
      }
    });
  }

  void placeOrder(PlaceOrderRequest placeOrderRequest,
      {Function(bool) onOrderPlaced}) async {
    await servicePlaceOrder(placeOrderRequest).then((orderResponse) {
      if (orderResponse != null && orderResponse.status == 200) {
        onOrderPlaced(true);
      } else {
        onOrderPlaced(false);
      }
    });
  }
}
