import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_template/pages/register.dart';

import '../bloc/auth/auth_bloc.dart';
import '../cosntanst/layout_constants.dart';
import '../services/secure_storage_service.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginView(
      title: "LOGIN TEMPLATE",
      message: "prosessing data",
    );
  }
}

class LoginView extends StatefulWidget {
  final String title;
  final String message;

  const LoginView({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  //String _hintText = "";

  String get title => super.widget.title;

  String get message => super.widget.message;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future init() async {
    final name = await SecureStorageService.getUserName() ?? "";
    setState(() {
      _usernameController.text = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(title),
            ),
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(
                      horizontal: LayoutConstants.paddingXL),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Inicia sesión",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w300),
                        ),
                        userNameTextField(),
                        passwordTextField(),
                        const SizedBox(
                          height: 20,
                        ),
                        loginButton(),
                        const SizedBox(height: 20),
                        goToRegister(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget userNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(LayoutConstants.paddingM),
      child: TextFormField(
        key: const Key('inputUserName'),
        controller: _usernameController,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Ingresa tu nombre de usuario',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Campo obligatorio";
          }
          return null;
        },
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.all(LayoutConstants.paddingM),
      child: TextFormField(
        key: const Key('inputPassword'),
        obscureText: _hidePassword,
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Ingresa tu contraseña',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
            icon: (_hidePassword)
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Campo obligatorio";
          }
          return null;
        },
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LayoutConstants.paddingM),
      child: ElevatedButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              context.read<AuthBloc>().add(GoToHomeEvent());
            }
          },
          child: const Text("Inicia sesión")),
    );
  }

  Widget goToRegister() {
    return Text.rich(TextSpan(
        text: "Aun no estas registrado? ",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
              text: "Registrate ahora!",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                //Todo: Replace with the event handler from auth.
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
                }),
        ]));
  }
}
