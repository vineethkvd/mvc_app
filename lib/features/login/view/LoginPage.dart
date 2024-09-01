import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_app/features/login/controller/LoginController.dart';
import '../../../core/helpers/routes/app_route_config.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
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
                        () => Container(
                          decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            value: _loginController
                                    .selectedStateId.value.isNotEmpty
                                ? _loginController.selectedStateId.value
                                : null,
                            menuMaxHeight: 200,
                            items: _loginController.sateList.map((element) {
                              return DropdownMenuItem<String>(
                                value: element.stateId.toString(),
                                child: Text(element.stateName ?? ''),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: const Color(0xfff5f5f5),
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                fontFamily: "poppinsRegular",
                                color: Colors.black,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.5, horizontal: 15),
                              labelText: "Select state",
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: "poppinsRegular",
                                color: Colors.black,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Color(0xffd9d9d9)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Color(0xffd9d9d9)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value) {
                              _loginController.selectedStateId.value =
                                  value.toString();
                              selectDistrict(stateId: _loginController.selectedStateId.value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
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
                        () => InkWell(
                          onTap: () {
                            if (_districtController.districtList.isEmpty) {
                              _districtController.showToastMsg("Select state first");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonFormField<String>(
                              value: _districtController
                                      .selectedDistrictId.value.isNotEmpty
                                  ? _districtController.selectedDistrictId.value
                                  : null,
                              menuMaxHeight: 200,
                              items:
                                  _districtController.districtList.map((element) {
                                return DropdownMenuItem<String>(
                                  value: element.stateId.toString(),
                                  child: Text(element.districtName ?? ''),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: const Color(0xfff5f5f5),
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "poppinsRegular",
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.5, horizontal: 15),
                                labelText: "Select district",
                                labelStyle: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "poppinsRegular",
                                  color: Colors.black,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Color(0xffd9d9d9)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Color(0xffd9d9d9)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (value) {
                                _districtController.selectedDistrictId.value =
                                    value.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
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
                                style: const TextStyle(color: Color(0xff0028fc)),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  context.goNamed(
                                    RoutesName.home,
                                    pathParameters: {
                                      'userName': "Vineeth Venu",
                                    },
                                  );

                                  // String userName = 'Vineeth Venu';
                                  // String encodedUserName = Uri.encodeComponent(userName);
                                  //
                                  // context.go('${RoutesPath.homePage}/$encodedUserName');

                                },
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

  void selectDistrict({required String stateId}) {
    _districtController.districtApi(stateId: stateId);
    _districtController.selectedDistrictId.value = '';
  }
}
