// core/functions/handlingdatacontroller.dart

import 'package:skolar/core/class/statusrequest.dart';

StatusRequest handlingData(dynamic response) {

  if (response is StatusRequest) {
    return response; 
  } else {
    if (response['status'] == "success") {
      return StatusRequest.success;
    } else {
      return StatusRequest.failure;
    }
  }
}
