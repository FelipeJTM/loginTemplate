import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_template/data/models/password_model.dart';
import '../bloc/register/register_bloc.dart';
import '../cosntanst/layout_constants.dart';
import '../widgets/general.dart';
import '../widgets/snack_bar.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: const RegisterView(
        title: "REGISTRO",
        message: "prosessing data",
      ),
    );
  }
}

class RegisterView extends StatefulWidget {
  final String title;
  final String message;

  const RegisterView({super.key, required this.title, required this.message});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verifyPasswordController = TextEditingController();
  bool _hidePassword = true;
  bool _isLoading = false;

  String get title => super.widget.title;

  String get message => super.widget.message;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          setState(() => _isLoading = true);
        }
        if (state is RegisterCompletedState) {
          setState(() => _isLoading = false);
          showSnackBar(context, "operacion realizada con exito", Colors.green);
          nextScreenReplace(context, const Login());
        }
        if (state is RegisterFailedState) {
          setState(() => _isLoading = false);
          showSnackBar(context, state.error, Colors.red);
          cleanFields();
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
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
                          basicTextField(
                              _emailController, "Correo electronico",true),
                          basicTextField(
                              _usernameController, "Nombre de usuario"),
                          passwordTextField(PasswordModel(
                              labelText: "Contraseña",
                              passwordController: _passwordController,
                              repeatPasswordController:
                                  _verifyPasswordController,
                              willEnableSuffix: true)),
                          passwordTextField(PasswordModel(
                              labelText: "Repetir Contraseña",
                              passwordController: _verifyPasswordController,
                              repeatPasswordController: _passwordController)),
                          const SizedBox(
                            height: 20,
                          ),
                          (_isLoading)
                              ? const CircularProgressIndicator()
                              : const SizedBox.shrink(),
                          registerButton(),
                          const SizedBox(
                            height: 20,
                          ),
                          goToRegister()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget basicTextField(TextEditingController controller, String labelText, [bool isEmailField = false]) {
    return Padding(
      padding: const EdgeInsets.all(LayoutConstants.paddingM),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: labelText,
        ),
        validator: (value) {
          var problemWithMailField = verificationForEmail(value!);
          if(isEmailField && problemWithMailField != null)return problemWithMailField;
          var problemWithLength = verifyLengthInWord(4, value);
          if (problemWithLength != null) return problemWithLength;
          return null;
        },
      ),
    );
  }

  Widget passwordTextField(PasswordModel passwordSetting) {
    return Padding(
      padding: const EdgeInsets.all(LayoutConstants.paddingM),
      child: TextFormField(
        obscureText: passwordSetting.willEnableSuffix ? _hidePassword : true,
        keyboardType: TextInputType.visiblePassword,
        controller: passwordSetting.passwordController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: passwordSetting.labelText,
          suffixIcon: passwordSetting.willEnableSuffix
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: (_hidePassword)
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.remove_red_eye_outlined),
                )
              : null,
        ),
        validator: (value) {
          var problemWithLength = verifyLengthInWord(3, value!);
          if(problemWithLength != null) return problemWithLength;
          var problemWithPasswords = checkPasswords(passwordSetting.passwordController.text,passwordSetting.repeatPasswordController.text );
          if (problemWithPasswords != null) return problemWithPasswords;
          return null;
        },
      ),
    );
  }

  Widget registerButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LayoutConstants.paddingM),
      child: ElevatedButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              context.read<RegisterBloc>().add(AttemptToRegisterUserEvent(
                    email: _emailController.text,
                    userName: _usernameController.text,
                    password: _passwordController.text,
                  ));
            }
          },
          child: const Text("Registrarse")),
    );
  }

  Widget goToRegister() {
    return Text.rich(TextSpan(
        text: "ya estas registrado? ",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
              text: "Inicia ahora!",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //Todo: Replace with the event handler from auth. x2
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                }),
        ]));
  }

  void cleanFields() {
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _verifyPasswordController.clear();
  }

  dynamic verifyLengthInWord(int length, String value) {
    if(value.length < length) return "minimo $length caracteres";;
    return null;
  }

  dynamic checkPasswords(String password, String repeatPassword) {
   if(password != repeatPassword) return "Las contraseñas no son iguales";
   return null;
  }

  dynamic checkIfNull(String value) {
    if (value == null || value.isEmpty) return "Campo obligatorio";
    return null;
  }

  dynamic verificationForEmail(String value) {
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
      return "ingresa un email valido";
    }
    return null;
  }
}
