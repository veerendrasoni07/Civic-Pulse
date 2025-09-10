import 'package:civic_pulse_frontend/controllers/auth_controller.dart';
import 'package:civic_pulse_frontend/views/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

  bool isPasswordVisible = false;
  String? role;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9F45F8),
              Color(0xFF71D5FF)
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Welcome Back",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login to continue your AI-powered learning",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    wordSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 30),

                // Email TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: emailController ,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",

                      hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: isPasswordVisible ? false : true,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),
                      suffixIcon: InkWell(
                        onTap:(){
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        } ,
                        child: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined,color: Colors.black,),
                      ),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: role,
                  hint: const Text("Select Role"),
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)
                    )
                  ),
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(value: "citizen", child: Text("Citizen")),
                    DropdownMenuItem(value: "worker", child: Text("Worker")),
                    DropdownMenuItem(value: "department head", child: Text("Department Head")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      role = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(role == 'citizen'){
                        authController.login(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                          ref: ref,
                        );
                      }
                      else if(role=='worker'){
                        authController.loginWorker(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                          ref: ref,
                        );
                      }
                      else if(role=='department head'){
                        authController.loginDeptHead(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                          ref: ref,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFFB266FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Divider
                Row(
                  children: const [

                    Expanded(child: Divider(color: Colors.white70)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white70)),
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    label: Text(
                      "Login via Google",
                      style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async{
                      await AuthController().googleLogin(context: context);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                // Google Login
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    label: Text(
                      "Login via OTP",
                      style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: ()async{
                      //Navigator.push(context, MaterialPageRoute(builder: (_)=>OtpScreen()));
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 200,)
              ],
            ),
          ),
        ),
      ),
    );



  }
}
