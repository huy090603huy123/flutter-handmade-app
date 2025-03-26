import 'package:handmade_app/utility/extensions.dart';

import '../../utility/app_color.dart';

import 'package:flutter/material.dart';

import 'package:flutter_login/flutter_login.dart';

import '../home_screen.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});


  @override

  Widget build(BuildContext context) {

    return Scaffold( // Add Scaffold as the top-level widget

      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage("assets/images/background.jpg"), // Your background image

            fit: BoxFit.cover, // Cover the entire screen

          ),

        ),

        child: Center( // Center the FlutterLogin widget

          child: FlutterLogin(

            loginAfterSignUp: false,

            logo: const AssetImage('assets/images/logo.png'),

            onLogin: (loginData) {

              context.userProvider.login(loginData);

            },

            onSignup: (SignupData data) {

              context.userProvider.register(data);

            },

            onSubmitAnimationCompleted: () {

              if (context.userProvider.getLoginUsr()?.sId != null) {

                Navigator.of(context).pushReplacement(MaterialPageRoute(

                  builder: (context) {

                    return const HomeScreen();

                  },

                ));

              } else {

                Navigator.of(context).pushReplacement(MaterialPageRoute(

                  builder: (context) {

                    return const LoginScreen();

                  },

                ));

              }

            },

            onRecoverPassword: (_) => null,

            hideForgotPasswordButton: true,

            theme: LoginTheme(

              primaryColor: AppColor.darkGrey,

              accentColor: AppColor.darkOrange,

              pageColorLight: Colors.white, // Màu nền sáng hơn

              pageColorDark: AppColor.darkGrey.withOpacity(0.8), // Màu nền tối hơn, có độ trong suốt

              logoWidth: 0.80, // Tăng kích thước logo

              titleStyle: const TextStyle(

                color: Colors.white,

                fontFamily: 'Quicksand', // Thay đổi font chữ

                letterSpacing: 4,

                fontSize: 24,

                fontWeight: FontWeight.bold,

              ),

              bodyStyle: const TextStyle(

                fontStyle: FontStyle.italic,

                color: Colors.white70, // Màu chữ nhạt hơn

                decoration: TextDecoration.underline,

              ),

              textFieldStyle: const TextStyle(

                color: Colors.black,

              ),

              buttonStyle: const TextStyle(

                fontWeight: FontWeight.w800,

                color: Colors.white,

              ),

              cardTheme: const CardTheme(

                color: Colors.white,

                elevation: 5, // Hiệu ứng nổi bật cho card

                margin: EdgeInsets.only(top: 15),

                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.all(Radius.circular(20.0)), // Bo tròn các góc của card

                ),

              ),

              inputTheme: InputDecorationTheme(

                filled: true,

                fillColor: Colors.grey.shade100, // Màu nền cho input field

                contentPadding: EdgeInsets.zero,

                errorStyle: const TextStyle(

                  backgroundColor: Colors.red, // Màu nền cho thông báo lỗi

                  color: Colors.white,

                ),

                labelStyle: const TextStyle(fontSize: 16, color: AppColor.darkGrey), // Thay đổi kiểu chữ

                enabledBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: AppColor.darkOrange.withOpacity(0.7), width: 2),

                  borderRadius: BorderRadius.circular(10),

                ),

                focusedBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: AppColor.darkOrange, width: 2),

                  borderRadius: BorderRadius.circular(10),

                ),

                errorBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.red.shade700, width: 2),

                  borderRadius: BorderRadius.circular(10),

                ),

                focusedErrorBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.red.shade400, width: 2),

                  borderRadius: BorderRadius.circular(10),

                ),

                disabledBorder: OutlineInputBorder(

                  borderSide: const BorderSide(color: Colors.grey, width: 2),

                  borderRadius: BorderRadius.circular(10),

                ),

              ),

              buttonTheme: const LoginButtonTheme(

                backgroundColor: AppColor.darkOrange,

                highlightColor: Colors.white,

                elevation: 6, // Hiệu ứng nổi bật cho button

                highlightElevation: 9,

                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.all(Radius.circular(10)), // Bo tròn các góc của button

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }

}