import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/src/helpers/show_altert.dart';
import 'package:realtime_chat/src/services/auth_service.dart';
import 'package:realtime_chat/src/services/socket_service.dart';
import 'package:realtime_chat/src/widgets/button_widget.dart';
import 'package:realtime_chat/src/widgets/input_widget.dart';
import 'package:realtime_chat/src/widgets/labels_widget.dart';
import 'package:realtime_chat/src/widgets/logo_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(),
                _Form(),
                LabelsWidget(
                  question: 'Ya tienes una cuenta?',
                  redirection: 'Inicia sesion aqui!',
                  path: '/',
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
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        children: [
          InputWidget(
            icon: Icons.alternate_email,
            placeholder: 'Name',
            textInputType: TextInputType.text,
            obscuredText: false,
            textEditingController: this.nameController,
          ),
          InputWidget(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            textInputType: TextInputType.emailAddress,
            obscuredText: false,
            textEditingController: this.emailController,
          ),
          InputWidget(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textInputType: TextInputType.visiblePassword,
            obscuredText: true,
            textEditingController: this.passwordController,
          ),
          ButtonWidget(
            buttonName: "Sing Up",
            onPress:  authService.authenticating
                ? null
                : () async {
              FocusScope.of(context).unfocus();
              final signinOk = await authService.register(
                  this.nameController.text.trim(),
                  this.emailController.text.trim(),
                  this.passwordController.text.trim());

              if (signinOk) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, '/users');

              } else {
                // show alert

                showAlert(context, 'Register failed',
                    'Password or email incorrect');
              }
            },
          )
        ],
      ),
    );
  }

}
