import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mvc_app/features/login/controller/LoginController.dart';
import '../../../core/utils/configs/styles/colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../controller/DistrictController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginController.stateApi();
  }

  final LoginController _loginController = Get.put(LoginController());
  final DistrictController _districtController = Get.put(DistrictController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: Container(
          color: AppColor.appMainColor,
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.25,
                  width: width,
                  child: Stack(
                    children: [
                      _backgroundImage(width: width, height: height),
                      _backgroundOverlay(),
                      Center(child: _appLogo()),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login or register to book \nyour appointments",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColor.txtColorMain,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppinsSemiBold",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.txtColorMain,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppinsRegular",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      _customTextField(
                        labelTxt: "Enter email",
                        hintTxt: "Enter email",
                        controller: _loginController.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.txtColorMain,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppinsRegular",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Obx(
                        () => _customTextField(
                          labelTxt: "Enter Password",
                          hintTxt: "Enter password",
                          controller: _loginController.password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _loginController.passwordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _loginController.passwordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _loginController.updateVisibility,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "State",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.txtColorMain,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppinsRegular",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (_loginController.sateList.value.isEmpty) {
                              _loginController
                                  .showToastMsg("No state available");
                            }
                          },
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              menuMaxHeight: 500,
                              dropdownColor: Colors.white,
                              value:
                                  _loginController.selectedStateId.value.isEmpty
                                      ? null
                                      : _loginController.selectedStateId.value,
                              hint: Text(
                                'Select a state',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "poppinsRegular",
                                  color: Colors.black,
                                ),
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "poppinsRegular",
                                  color: Colors.black,
                                ),
                                fillColor: const Color(0xfff5f5f5),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.5, horizontal: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xffd9d9d9)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xffd9d9d9)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              items:
                                  _loginController.sateList.value.map((state) {
                                return DropdownMenuItem<String>(
                                  value: state.stateId.toString(),
                                  child: SizedBox(
                                    width: Get.width *
                                        0.8, // This controls the width of each item
                                    child: Text(state.stateName.toString()),
                                  ),
                                );
                              }).toList(),
                              onChanged: _loginController.sateList.value.isEmpty
                                  ? null
                                  : (String? newValue) {
                                      _loginController.selectedStateId.value =
                                          newValue ?? '';
                                      if (_loginController
                                          .selectedStateId.value.isNotEmpty) {
                                        _districtController.districtApi(
                                            stateId: _loginController
                                                .selectedStateId.value);
                                      }
                                    },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "District",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.txtColorMain,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppinsRegular",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (_districtController
                                .districtList.value.isEmpty) {
                              _districtController
                                  .showToastMsg("Select state first");
                            }
                          },
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              menuMaxHeight: 500,
                              dropdownColor: Colors.white,
                              value: _districtController
                                      .selectedDistrictId.value.isEmpty
                                  ? null
                                  : _districtController.selectedDistrictId.value,
                              hint: Text(
                                'Select a district',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "poppinsRegular",
                                  color: Colors.black,
                                ),
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "poppinsRegular",
                                  color: Colors.black,
                                ),
                                fillColor: const Color(0xfff5f5f5),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.5, horizontal: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xffd9d9d9)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xffd9d9d9)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              items: _districtController.districtList.value
                                  .map((district) {
                                return DropdownMenuItem<String>(
                                  value: district.districtId.toString(),
                                  child: SizedBox(
                                    width: Get.width *
                                        0.8, // This controls the width of each item
                                    child:
                                        Text(district.districtName.toString()),
                                  ),
                                );
                              }).toList(),
                              onChanged:
                                  _districtController.districtList.value.isEmpty
                                      ? null
                                      : (String? newValue) {
                                          _districtController.selectedDistrictId
                                              .value = newValue ?? '';
                                        },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 5.0,
                        child: InkWell(
                          onTap: () {
                            if (_loginController.email.text.isEmpty) {
                              _loginController.showToastMsg("Enter email");
                            } else if (_loginController.password.text.isEmpty) {
                              _loginController.showToastMsg("Enter password");
                            } else {
                              _loginController.userLoginApi();
                            }
                          },
                          child: Container(
                            height: 45,
                            width: width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.btnColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: "poppinsSemiBold",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text:
                                "By creating or logging into an account you are agreeing with our ",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.txtColorMain,
                              fontFamily: "poppinsRegular",
                            ),
                            children: [
                              TextSpan(
                                text: "Terms and Conditions",
                                style: TextStyle(color: Color(0xff0028fc)),
                              ),
                              TextSpan(
                                text: " and ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.txtColorMain,
                                  fontFamily: "poppinsRegular",
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(color: Color(0xff0028fc)),
                              ),
                              TextSpan(
                                text: ".",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.txtColorMain,
                                  fontFamily: "poppinsRegular",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _backgroundImage({required double width, required double height}) {
    return Image.asset(
      height: height * 0.25,
      width: width,
      AssetsPathes.loginFrame,
      fit: BoxFit.fill,
    );
  }

  Widget _appLogo() {
    return Image.asset(
      height: 84,
      width: 80,
      AssetsPathes.appLogo,
      fit: BoxFit.cover,
    );
  }

  Widget _backgroundOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _customTextField({
    required String labelTxt,
    required String hintTxt,
    required TextEditingController? controller,
    required TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
    IconButton? suffixIcon,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: const Color(0xfff5f5f5),
        suffixIcon: suffixIcon,
        hintText: hintTxt,
        hintStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "poppinsRegular",
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.5, horizontal: 15),
        labelText: labelTxt,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontFamily: "poppinsRegular",
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffd9d9d9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffd9d9d9)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
