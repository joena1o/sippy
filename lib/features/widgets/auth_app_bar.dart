import 'package:flutter/material.dart';
import 'package:sippy_ca/utils/font_class.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar(
      {super.key,
      required this.title,
      required this.callback,
      this.showBack = true,
      this.border = true});

  final String title;
  final bool border;
  final bool showBack;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: border == false
                ? null
                : Border(
                    bottom:
                        BorderSide(color: Theme.of(context).highlightColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: showBack,
                child: GestureDetector(
                  onTap: () {
                    callback();
                  },
                  child: const Icon(Icons.keyboard_arrow_left, size: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 45.0),
                child: Text(
                  title,
                  style: FontClass.headerStyleBlack,
                ),
              ),
              Container()
            ],
          ),
        ));
  }
}
