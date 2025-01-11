import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifier/registration_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/validator.dart';
import 'package:notes_app/pages/reset_password.dart';
import 'package:notes_app/widgets/button/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';
import 'package:notes_app/widgets/button/note_icon_button_outlined.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late final RegistrationController registrationController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    registrationController = context.read<RegistrationController>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Selector<RegistrationController, bool>(
              selector: (_, controller) => controller.isRegisterMode,
              builder: (_, isRegisterMode, __) => Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      isRegisterMode ? 'Register' : 'Sign in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primary,
                        fontSize: 48,
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      isRegisterMode
                          ? 'In order to sync your notes to the cloud, you have to register to the app.'
                          : 'In order to sync your notes to the cloud, you have to sign in to the app.' ,
                    ),
                    SizedBox(height: 48),
                    if(isRegisterMode) ...[
                      NoteFormField(
                        controller: nameController,
                        labelText: 'Full name',
                        fillColor: Colors.white,
                        filled: true,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        validator: Validator.nameValidator,
                        onChanged: (newValue) {
                          registrationController.fullName = newValue;
                        },
                      ),
                    ],
                    SizedBox(height: 12),
                    NoteFormField(
                      controller: emailController,
                      labelText: 'Email address',
                      fillColor: Colors.white,
                      filled: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validator.emailValidator,
                      onChanged: (newValue) {
                        registrationController.email = newValue;
                      },
                    ),
                    SizedBox(height: 12),
                    Selector<RegistrationController, bool>(
                      selector: (_, controller) => controller.isPasswordHidden,
                      builder: (_, isPasswordHidden, __) => NoteFormField(
                        controller: passwordController,
                        labelText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        obscureText: isPasswordHidden,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              registrationController.isPasswordHidden = !isPasswordHidden;
                            },
                            child: Icon(isPasswordHidden
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash
                            )
                        ),
                        validator: Validator.passwordValidator,
                        onChanged: (newValue) {
                          registrationController.password = newValue;
                        },
                      ),
                    ),
                    if(!isRegisterMode) ...[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 16,),
                    SizedBox(
                      height: 48,
                      child: Selector<RegistrationController, bool>(
                        selector: (_, controller) => controller.isLoading,
                        builder: (_, isLoading, __) => NoteButton(
                            onPressed: isLoading ? null : () {
                              if (formKey.currentState?.validate() ?? false) {
                                registrationController.authenticateWithEmailAndPassword(context: context);
                              }
                            },
                            child: isLoading
                                ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(color: Colors.white,))
                                : Text(isRegisterMode
                                    ? 'Create my account'
                                    : 'Log In',
                                    style: TextStyle(fontSize: 18),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32,),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or log in with',
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 32,),
                    Row(
                      children: [
                        Expanded(
                          child: NoteIconButtonOutlined(
                            icon: FontAwesomeIcons.google,
                            onPressed: () {
                              registrationController.authenticateWithGoogle(context: context);
                            },
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: NoteIconButtonOutlined(
                            icon: FontAwesomeIcons.facebook,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 32,),
                    Text.rich(
                        TextSpan(
                          text: isRegisterMode ? 'Already have an account?' : 'Don\'t have account?',
                          children: [
                            TextSpan(
                                text: isRegisterMode ? 'Sign in' : 'Register',
                                style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  context.read<RegistrationController>().isRegisterMode = !isRegisterMode;
                                }
                            ),
                          ],
                        ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
