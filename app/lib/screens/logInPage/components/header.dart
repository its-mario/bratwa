import 'package:flutter/material.dart';
import 'package:md_messenger/constants.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size unit = getSize(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: unit.height * 10),
      child: Text(
        "BRATWAVA",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
