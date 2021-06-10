import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData iconData;
  final String hintText;
  final TextEditingController controller;
  final String helpMessage;
  final bool isPassword;

  const InputField({
    @required this.hintText,
    @required this.iconData,
    this.controller,
    this.isPassword = false,
    this.helpMessage,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0,
              blurRadius: 5,
            )
          ]),
      padding: EdgeInsets.only(
        left: 1,
        top: 1,
        bottom: 1,
      ),
      child: TextField(
        controller: controller,
        cursorColor: Theme.of(context).hoverColor,
        cursorRadius: Radius.circular(5),
        cursorWidth: 1.5,
        obscureText: this.isPassword,
        decoration: InputDecoration(
            helperText: this.helpMessage,
            hintText: this.hintText,
            prefixIcon: Icon(
              this.iconData,
              color: Theme.of(context).accentColor,
            )),
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
      ),
    );
  }
}
