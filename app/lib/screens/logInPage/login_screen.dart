import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/header.dart';
import 'components/logInForm.dart';

// Future me for for this code.Right now I understand that this is a pice of
// shit I'm relly sorry but i don't want to rewrite it now. So maybe you in the
// future will do that.
//                                        P.S. at the momment i writed this
//                                        i undertand that this a wrong form to
//                                        wrote this but anyway fu@k yourslef.>.<

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                LogInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
