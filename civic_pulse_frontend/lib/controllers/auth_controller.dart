
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:civic_pulse_frontend/global_variable..dart';
import 'package:civic_pulse_frontend/models/user.dart';
import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/service/manage_http_request.dart';
import 'package:civic_pulse_frontend/views/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/main_screen.dart' show MainScreen;


class AuthController{
  Future<void> signup({
    required String fullname,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    try {
      User user = User(
          id: '',
          fullname: fullname,
          email: email,
        password: password,
        phone: phone,
        state: '',
        city: '',
        address: '',
        googleId: '',
        picture: '',
        authProvider: [],
        role: ''
      );
      http.Response response = await http.post(
          Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
          }
      );

      manageHttpRequest(response: response, context: context, onSuccess: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        showSnackBar(context, "SignUp Successfully", "Account is created now you can login with same credential!", ContentType.success);
      });
    }catch (e) {
      showSnackBar(context, "Failed To SignUp", e.toString(), ContentType.failure);
      print(e.toString());
    }

  }

  // login

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
    required WidgetRef ref
  })async{
    try{

      http.Response response = await http.post(
          Uri.parse('$uri/api/login'),
          body: jsonEncode({
            'email':email,
            'password':password,
          }),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
          }
      );

      manageHttpRequest(
          response: response,
          context: context,
          onSuccess: ()async{

            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

            String token = await jsonDecode(response.body)['token'];

            await sharedPreferences.setString('auth-token',token );

            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            ref.read(userProvider.notifier).setUser(userJson);

            await sharedPreferences.setString('user', userJson);



            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainScreen()), (route)=>false);
          }
      );
    }catch(e){
      showSnackBar(context, "Login Failed", e.toString(), ContentType.failure);
    }
  }


  // google login
  Future<void> googleLogin({required BuildContext context})async{
    try{
      final user = await GoogleSignIn.instance.authenticate();
      final auth = await user.authentication;
      final idToken = auth.idToken;
      print("Google ID Token: $idToken");
      print("User email: ${user.email}");
      print("User name: ${user.displayName}");
        }catch(e){
      print("Google Login Error: $e");
      showSnackBar(context, "Google Login Failed", e.toString(), ContentType.failure);
    }
  }


  Future<void> sendOtp({
    required String email,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/api/send-otp'),
        body: jsonEncode({'email': email}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // 🔍 Log raw response
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // ✅ Safely parse JSON (with fallback)
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final bool success = data['success'] ?? false;

        if (success) {
          // Call your reusable function
          manageHttpRequest(
            response: response,
            context: context,
            onSuccess: () async {
              showSnackBar(
                context,
                "OTP Sent",
                "OTP sent to your email successfully.",
                ContentType.help,
              );
            },
          );
        } else {
          // Failure even with 200 response
          throw Exception(data['msg'] ?? "Failed to send OTP");
        }
      } else {
        // For status codes like 400, 500
        throw Exception(data['msg'] ?? "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      // 🚨 Safely catch and show any error
      print("OTP Send Error: $e");
      showSnackBar(context, "OTP Error", e.toString(), ContentType.failure);
    }
  }


  // verify via otp
  Future<void> verifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
    required WidgetRef ref
  })async{
    try{

      http.Response response = await http.post(
          Uri.parse('$uri/api/verify-otp'),
          body: jsonEncode({
            'email':email,
            'otp':otp,
          }),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
          }
      );

      manageHttpRequest(
          response: response,
          context: context,
          onSuccess: ()async{

            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

            String token = await jsonDecode(response.body)['token'];

            await sharedPreferences.setString('auth-token',token );

            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            ref.read(userProvider.notifier).setUser(userJson);

            await sharedPreferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainScreen()), (route)=>false);
          }
      );
    }catch(e){
      showSnackBar(context, "Login Failed", e.toString(), ContentType.failure);
    }
  }
}