import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sippy_ca/utils/responsive.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Thanks for shopping",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 40,
            ),
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                width: Responsive.getSize(context).width,
                decoration: UtilityClass.buttonDecorationFill,
                child: ElevatedButton(
                    onPressed: () {
                      context.go("/home");
                    },
                    child: const Text("Go to homepage")))
          ],
        ),
      ),
    );
  }
}
