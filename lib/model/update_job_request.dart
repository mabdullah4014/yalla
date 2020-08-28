//{
//"order_id":1,
//"status":200,
//"service_provider_id":11
//
//}
class UpdateJobRequest {
  int order_id;
  int status;
  int service_provider_id;

  UpdateJobRequest(this.order_id, this.status, this.service_provider_id);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["order_id"] = this.order_id;
    map["status"] = this.status;
    map["service_provider_id"] = this.service_provider_id;
    return map;
  }
}
