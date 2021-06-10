import 'package:flutter/material.dart';
import 'package:md_messenger/screens/logInPage/components/logInButtons.dart';
import 'package:md_messenger/services/provider.dart';

import 'package:provider/provider.dart';

import 'logIninput.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  bool isSingUp = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isSingUp ? 550 : 450,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, 2),
                spreadRadius: 1,
                blurRadius: 7,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: isSingUp
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedPadding(
                      duration: Duration(milliseconds: 150),
                      padding: EdgeInsets.only(bottom: isSingUp ? 20 : 30),
                      child: Text(
                        isSingUp ? "Sing Up" : "Log In",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    InputField(
                      hintText: 'id',
                      iconData: Icons.perm_identity,
                      controller: idController,
                    ),
                    this.isSingUp
                        ? InputField(
                            hintText: 'name',
                            iconData: Icons.person,
                            isPassword: false,
                            controller: nameController,
                          )
                        : Container(),
                    this.isSingUp
                        ? InputField(
                            hintText: 'username',
                            iconData: Icons.account_circle,
                            isPassword: false,
                            controller: usernameController,
                          )
                        : Container(),
                    InputField(
                      hintText: 'password',
                      iconData: Icons.lock,
                      isPassword: true,
                      controller: passwordController,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ---------------
                    // Google SignIn
                    // Need to be deprecated
                    // TO DO:  caroci stergeo nahui
                    // ---------------
                    // LogInButton(
                    //   press: () async {
                    //     context.read<AuthModel>().signInWithGoogle();
                    //   },
                    //   backgroundColor: Theme.of(context).backgroundColor,
                    //   text: "SingIn with Google",
                    //   padding: Size(18, 12),
                    // ),
                    // ---------------
                    SizedBox(
                      height: 15,
                    ),
                    LogInButton(
                      press: () async {
                        //TO DO: eu nustiu cei cu parasha asta de firebase da ea returneaze erroare!
                        // String result;
                        print("<LogInScreen>: singIn button was pressed");
                        if (!isSingUp){
                          await context.read<AuthModel>().logIn(
                            id: idController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        } else {
                          await context.read<AuthModel>().singUp(
                            id: idController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                            email: idController.text.trim(),
                          );
                        }
                        
                        // try {
                        //   await context
                        //       .read<AuthModel>()
                        //       .connect(
                        //         id: emailController.text.trim(),
                        //         password: passwordController.text.trim(),
                        //       )
                        //       .catchError((e) {
                        //     print(e.message);
                        //   });
                        //   // } catch (e) {
                        //   //   result = e.toString();
                        //   //   _showMyDialog(result);
                        //   // }
                        // } else {
                        //   await context
                        //       .read<AuthService>()
                        //       .singUp(
                        //         email: emailController.text.trim(),
                        //         password: passwordController.text.trim(),
                        //         name: nameController.text.trim(),
                        //         username: nameController.text.trim(),
                        //       )
                        //       .catchError((e) {
                        //     print(e);
                        //   });
                        // }
                      },
                      backgroundColor: Theme.of(context).accentColor,
                      text: "sing in",
                      fontSize: 24,
                      textColor: Theme.of(context).backgroundColor,
                      padding: Size(65, 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            !isSingUp
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isSingUp = !isSingUp;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Tap to create an account.",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.black.withOpacity(0.65)),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        isSingUp = !isSingUp;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Sing In",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.black.withOpacity(0.65)),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
