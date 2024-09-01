import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mvc_app/core/helpers/network/helpers/api_endpoints.dart';

import '../model/DistrictModel.dart';
import '../repository/DistrictRepository.dart';

class DistrictController extends GetxController {
  final _districtApi = DistrictRepository();
  var districtModel = DistrictModel().obs;
  var loading = false.obs;
  var districtList = <Data>[].obs;
  var selectedDistrict = ''.obs;
  var selectedDistrictId = ''.obs;

  Future<void> districtApi({required String stateId}) async {
    try {
      loading.value = true;
      var data =  {
        "api_key": ApiEndPoints.apiToken,
        "state_id": stateId
      };
      final response = await _districtApi.districtApi(data);
      print("Api res : $response");

      if (response != null && response['status'] == 200) {
        districtModel.value = DistrictModel.fromJson(response['data']);
        districtList.assignAll(districtModel.value.data ?? []);
        showToastMsg("Success to fetch district");
      } else if (response != null && response['status'] == 400) {
        districtModel.value = DistrictModel.fromJson(response['data']);
        showToastMsg("Failed to fetch district?? ''}");
      } else {
        showToastMsg("Unexpected error occurred");
      }
    } catch (e) {
      showToastMsg("Error: $e");
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      loading.value = false;
    }
  }

  Future<bool?> showToastMsg(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #000000, #434343)",
      webPosition: "center",
    );
  }
}
