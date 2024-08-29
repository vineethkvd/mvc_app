import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/configs/styles/colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import 'package:mvc_app/features/login/controller/PLoginController.dart';

class PLoginPage extends StatefulWidget {
  const PLoginPage({super.key});

  @override
  State<PLoginPage> createState() => _PLoginPageState();
}

class _PLoginPageState extends State<PLoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // Accessing the LoginProvider instance
    final loginProvider = Provider.of<LoginProvider>(context);

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
                      controller: loginProvider.email,
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
                    _customTextField(
                      labelTxt: "Enter Password",
                      hintTxt: "Enter password",
                      controller: loginProvider.password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: loginProvider.passwordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginProvider.passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: loginProvider.updateVisibility,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15.0),
                      elevation: 5.0,
                      child: InkWell(
                        onTap: () {
                          if (loginProvider.email.text.isEmpty) {
                            loginProvider.showToastMsg("Enter email");
                          } else if (loginProvider.password.text.isEmpty) {
                            loginProvider.showToastMsg("Enter password");
                          } else {
                            loginProvider.userLoginApi();
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
                          child: loginProvider.loading
                              ? CircularProgressIndicator()
                              : Text(
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
              ),
            ],
          ),
        ),
      ),
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
