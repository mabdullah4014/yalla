import 'package:arbi/model/customer_order_response.dart';
import 'package:arbi/model/update_job_request.dart';
import 'package:arbi/repo/category_repository.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProviderJobController extends ControllerMVC {
  List<Order> orders = [];
  bool getPending;

  ProviderJobController(bool getPending) {
    this.getPending = getPending;
    if (getPending)
      getPendingJobs();
    else
      getJobs();
  }

  void getJobs() async {
    getProviderJobs().then((value) {
      setState(() {
        if (value.status == 200) orders.addAll(value.orders);
      });
    });
  }

  void getPendingJobs() async {
    getProviderPendingJobs().then((value) {
      setState(() {
        if (value.status == 200) orders.addAll(value.orders);
      });
    });
  }

  void updateJob(UpdateJobRequest request,
      {Function(bool) orderUpdated}) async {
    updateProviderJob(request).then((value) {
      setState(() {
        orderUpdated(value);
      });
    });
  }

  Future<void> refreshHome() async {
    orders = [];
    if (getPending)
      getPendingJobs();
    else
      getJobs();
  }
}
