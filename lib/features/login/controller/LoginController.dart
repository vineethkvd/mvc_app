import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../model/LoginModel.dart';
import '../repository/LoginRepository.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var loading = false.obs;
  var passwordVisible = true.obs;
  var loginModel = LoginModel().obs;

  final _api = LoginRepository();

  void updateVisibility() {
    passwordVisible.toggle();
  }

  Future<bool?> showToastMsg(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #000000, #434343)",
      webPosition: "bottom",
    );
  }

  // Login API
  Future<void> userLoginApi() async {
    try {
      loading.value = true;
      var data = {
        "username": email.text.trim(),
        "password": password.text.trim()
      };
      final response = await _api.loginApi(data);

      if (response != null && response['status'] == 200) {
        loginModel.value = LoginModel.fromJson(response['data']);
        showToastMsg("Login successful");
      } else if (response != null && response['status'] == 400) {
        loginModel.value = LoginModel.fromJson(response['data']);
        showToastMsg("Login failed: ${loginModel.value.message ?? ''}");
      } else {
        showToastMsg("Unexpected error occurred");
      }
    } catch (e) {
      showToastMsg("Error: $e");
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {
      loading.value = false;
    }
  }
}
