import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_template/bloc/login/login_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../cosntanst/layout_constants.dart';
import '../services/secure_storage_service.dart';
import '../widgets/snack_bar.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const LoginView(
        title: "LOGIN TEMPLATE",
        message: "prosessing data",
      ),
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
  bool _isPerformingLogin = false;

  String get title => super.widget.title;

  String get message => super.widget.message;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              toggleLoading(true);
            }
            if (state is LoginSuccessfulState) {
              toggleLoading(false);
              showSnackBar(context, "bienvenido de vuelta", Colors.green);
              if (_key.currentState!.validate()) {
                context.read<AuthBloc>().add(GoToHomeEvent());
              }
            }
            if (state is LoginBadCredentialsState) {
              toggleLoading(false);
              showSnackBar(context, "Usuario o contraseña incorrectos",
                  Colors.deepOrange);
            }
            if (state is LoginErrorState) {
              toggleLoading(false);
              showSnackBar(context, state.error, Colors.red);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, loginState) {
              return Scaffold(
                  appBar: AppBar(
                    title: Center(
                      child: Text(title),
                    ),
                  ),
                  body: loginBody());
            },
          ),
        );
      },
    );
  }

  void toggleLoading(bool newValue) {
    setState(() {
      _isPerformingLogin = newValue;
    });
  }

  Future getUserName() async {
    final name = await SecureStorageService.getUserName() ?? "";
    setState(() {
      _usernameController.text = name;
    });
  }

  Widget loginBody() {
    return Center(
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
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                  ),
                  userNameTextField(),
                  passwordTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  (_isPerformingLogin)
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                  loginButton(),
                  const SizedBox(height: 20),
                  goToRegister(),
                ],
              ),
            ),
          )
        ],
      ),
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
              context.read<LoginBloc>().add(LoginWithUserAndPassword(_usernameController.text, _passwordController.text));
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
                  context.read<AuthBloc>().add(GoToRegisterEvent());
                }),
        ]));
  }
}
