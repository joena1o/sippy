import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';
import 'package:sippy_ca/features/widgets/loader.dart';
import 'package:sippy_ca/utils/font_class.dart';
import 'package:sippy_ca/utils/responsive.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController referralCode = TextEditingController();

  String? emailText;

  bool showPassword = false;
  //bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: SizedBox(
              width: Responsive.getSize(context).width,
              height: Responsive.getSize(context).height,
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.getSize(context).height * .1,
                  ),
                  SvgPicture.asset(
                    "assets/sippy_logo.svg",
                    semanticsLabel: 'Sippy Life',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      padding: UtilityClass.horizontalPadding,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          ("Sign Up"),
                          style: FontClass.headerStyleBlackNormal,
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        const SizedBox(height: 20),
                        //Form Section
                        TextFormField(
                          controller: firstName,
                          validator: UtilityClass.firstNameValidator,
                          decoration:
                              const InputDecoration(hintText: "First name"),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: lastName,
                          validator: UtilityClass.firstNameValidator,
                          decoration:
                              const InputDecoration(hintText: "Last name"),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final RegExp regex =
                                RegExp(UtilityClass.emailPattern);
                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: password,
                          validator: UtilityClass.passwordValidator,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                              hintText: "Password (8 or more characters)",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() => showPassword = !showPassword);
                                },
                                child: !showPassword
                                    ? const Icon(Icons.remove_red_eye)
                                    : const FittedBox(
                                        fit: BoxFit.none,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/png/invisible.png'),
                                            width: 20,
                                            height: 20),
                                      ),
                              )),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: confirmPassword,
                          validator: (String? e) {
                            if (e!.isEmpty) {
                              return "Please confirm your password";
                            } else if (e != password.text) {
                              return "Password do not match";
                            }
                            return null;
                          },
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            hintText: "Confirm password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => showPassword = !showPassword);
                              },
                              child: !showPassword
                                  ? const Icon(Icons.remove_red_eye)
                                  : const FittedBox(
                                      fit: BoxFit.none,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/png/invisible.png'),
                                          width: 22,
                                          height: 22),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: referralCode,
                          decoration: const InputDecoration(
                              hintText: "Referral code (Optional)"),
                        ),

                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 30, bottom: 20),
                          width: Responsive.getSize(context).width,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Text(
                                "By Continuing, you are agreeing to our ",
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Terms & Conditions ",
                                ),
                              ),
                              const Text(
                                "including our ",
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Privacy Policy.",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Consumer<AuthProvider>(
                            builder: (context, provider, child) {
                          return !provider.isLoading
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: Responsive.getSize(context).width,
                                  decoration: UtilityClass.buttonDecorationFill,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        provider.signUpUser(
                                            email: email.text,
                                            firstName: firstName.text,
                                            lastName: lastName.text,
                                            password: password.text,
                                            callback: () =>
                                                context.go('/home'));
                                      }
                                    },
                                    child: const Text("Create account"),
                                  ),
                                )
                              : const Loader();
                        }),

                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 40, top: 30),
                          width: Responsive.getSize(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?  ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: const Text(
                                  "Log in",
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  void signUpGoogle(GoogleSignInAccount value) {}
}
