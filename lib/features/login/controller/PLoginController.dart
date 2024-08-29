import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/LoginModel.dart';
import '../model/StateModel.dart';
import '../repository/LoginRepository.dart';
import '../repository/StateRepository.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _loading = false;
  bool _passwordVisible = true;
  LoginModel _loginModel = LoginModel();
  StateModel _stateModel = StateModel();
  List<Data> _stateList = [];
  String _selectedState = '';
  String _selectedStateId = '';

  final _api = LoginRepository();
  final _stateApi = StateRepository();

  // Getters
  bool get loading => _loading;
  bool get passwordVisible => _passwordVisible;
  LoginModel get loginModel => _loginModel;
  List<Data> get stateList => _stateList;
  String get selectedState => _selectedState;
  String get selectedStateId => _selectedStateId;

  // Toggle password visibility
  void updateVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  // Show toast message
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

  // Login API
  Future<void> userLoginApi() async {
    try {
      _loading = true;
      notifyListeners();

      var data = {
        "username": email.text.trim(),
        "password": password.text.trim()
      };

      final response = await _api.loginApi(data);

      if (response != null && response['status'] == 200) {
        _loginModel = LoginModel.fromJson(response['data']);
        showToastMsg("Login successful");
      } else if (response != null && response['status'] == 400) {
        _loginModel = LoginModel.fromJson(response['data']);
        showToastMsg("Login failed: ${_loginModel.message ?? ''}");
      } else {
        showToastMsg("Unexpected error occurred");
      }
    } catch (e) {
      showToastMsg("Error: $e");
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Fetch states API
  Future<void> fetchStates() async {
    try {
      _loading = true;
      notifyListeners();

      final response = await _stateApi.stateApi();

      if (response != null && response['status'] == 200) {
        _stateModel = StateModel.fromJson(response['data']);
        _stateList = _stateModel.data ?? [];
        showToastMsg("Fetch state successful");
      } else if (response != null && response['status'] == 400) {
        _stateModel = StateModel.fromJson(response['data']);
        showToastMsg("Failed to fetch state");
      } else {
        showToastMsg("Unexpected error occurred");
      }
    } catch (e) {
      showToastMsg("Error: $e");
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Set selected state
  void setSelectedState(String stateName, String stateId) {
    _selectedState = stateName;
    _selectedStateId = stateId;
    notifyListeners();
  }
}
