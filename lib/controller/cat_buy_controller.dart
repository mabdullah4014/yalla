import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/check_service_request.dart';
import 'package:arbi/model/check_service_response.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CheckServiceController extends ControllerMVC {
  void checkPrice(CheckServiceRequest checkServiceRequest,
      {Function(double) onPriceCheck}) async {
    await getServicePrice(checkServiceRequest).then((checkResponse) {
      if (checkResponse != null && checkResponse.status == 200) {
        onPriceCheck(checkResponse.price);
      } else {
        onPriceCheck(0);
      }
    });
  }
}
