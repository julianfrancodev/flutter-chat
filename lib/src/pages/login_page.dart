import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/src/helpers/show_altert.dart';
import 'package:realtime_chat/src/services/auth_service.dart';
import 'package:realtime_chat/src/widgets/button_widget.dart';
import 'package:realtime_chat/src/widgets/input_widget.dart';
import 'package:realtime_chat/src/widgets/labels_widget.dart';
import 'package:realtime_chat/src/widgets/logo_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(),
                _Form(),
                LabelsWidget(
                  question: 'No tienes una cuenta?',
                  redirection: 'Crea una aqui!',
                  path: '/register',
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        children: [
          InputWidget(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            textInputType: TextInputType.emailAddress,
            obscuredText: false,
            textEditingController: emailController,
          ),
          InputWidget(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textInputType: TextInputType.visiblePassword,
            obscuredText: true,
            textEditingController: passwordController,
          ),
          ButtonWidget(
            buttonName: "Sing In",
            onPress: authService.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final signinOk = await authService.signin(
                        this.emailController.text.trim(),
                        this.passwordController.text.trim());

                    if (signinOk) {
                      // TODO connect with the socket server
                      Navigator.pushReplacementNamed(context, '/users');
                      
                    } else {
                      // show alert

                      showAlert(context, 'Login Incorrecto',
                          'Password or email incorrect');
                    }
                  },
          )
        ],
      ),
    );
  }
}
