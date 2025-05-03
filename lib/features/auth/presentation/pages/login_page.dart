import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/auth/data/services/auth_service.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';
import 'package:sippy_ca/features/widgets/loader.dart';
import 'package:sippy_ca/utils/responsive.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    //signOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SizedBox(
          width: Responsive.getSize(context).width,
          height: Responsive.getSize(context).height,
          child: ListView(
            padding: UtilityClass.horizontalPadding,
            children: [
              SizedBox(
                height: Responsive.getSize(context).height * .14,
              ),
              SvgPicture.asset(
                "assets/sippy_logo.svg",
                semanticsLabel: 'Sippy Life',
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                width: 200,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final RegExp regex = RegExp(UtilityClass.emailPattern);
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(hintText: "Username or Email"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: password,
                obscureText: !showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => showPassword = !showPassword);
                      },
                      child: !showPassword
                          ? const Icon(Icons.remove_red_eye)
                          : const FittedBox(
                              fit: BoxFit.none,
                              child: Image(
                                  image: AssetImage('assets/png/invisible.png'),
                                  width: 22,
                                  height: 22),
                            ),
                    ),
                    hintText: "Password"),
              ),
              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return !provider.isLoadingAuth
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          width: Responsive.getSize(context).width,
                          decoration: UtilityClass.buttonDecorationFill,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                provider.signInUser(email.text, password.text,
                                    () => context.go('/home'), false);
                              }
                            },
                            child: const Text("Login"),
                          ),
                        )
                      : const Loader();
                },
              ),
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Line thickness
                      endIndent: 10, // Space between line and 'or'
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 16), // Text style
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Line thickness
                      indent: 10, // Space between 'or' and line
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: Responsive.getSize(context).width,
                  decoration: UtilityClass.setButtonOutlineDecoration(
                      AppColors.primaryColor),
                  child: ElevatedButton(
                    onPressed: () {
                      context.push("/sign-up");
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 16)),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: Responsive.getSize(context).width,
                child: TextButton(
                  onPressed: () {
                    context.push("/forgot-password");
                  },
                  child: Text(
                    "Forgotten Password?",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<GoogleSignInAccount?> googleAuth() async {
    final GoogleSignInAccount? result = await AuthService.signInWithGoogle();
    return result;
  }
}
