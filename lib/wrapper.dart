import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/data/local_storage.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key, this.code});
  final String? code;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    loadCredentials();
    Timer(const Duration(seconds: 2), () {
      if (email != null) {
        context.read<AuthProvider>().signInUser(email!, password!, () {
          if (widget.code != null) {
            FirebaseFirestore.instance
                .collection('collab-shopping')
                .doc(widget.code!)
                .update({
              'emails': FieldValue.arrayUnion([email])
            }).then((result) {
              goToHome();
            });
          } else {
            Timer(const Duration(seconds: 2), () {
              context.go("/home");
            });
          }
        }, true);
      } else {
        Timer(const Duration(seconds: 3), () {
          context.go("/login");
        });
      }
    });
    super.initState();
  }

  void goToHome() {
    context.go("/home", extra: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sippy Assessment",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  String? email;
  String? password;

  void loadCredentials() async {
    String? emailValue = await SharedPrefService.getItem("email");
    String? passwordValue = await SharedPrefService.getItem("password");

    setState(() {
      email = emailValue;
      password = passwordValue;
    });
    if (emailValue != null) print(emailValue + " " + passwordValue!);
  }
}
