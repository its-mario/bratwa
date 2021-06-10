import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInButton extends StatelessWidget {
  final Function press;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final Size padding;
  final double fontSize;

  const LogInButton({
    Key key,
    this.press,
    this.backgroundColor,
    this.text,
    this.textColor = Colors.black,
    this.padding,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: this.padding.width,
          vertical: this.padding.height,
        ),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 2,
              blurRadius: 7,
            )
          ],
        ),
        child: Text(
          this.text,
          style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              fontSize: this.fontSize,
              color: this.textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
