import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifier/registration_controller.dart';
import 'package:notes_app/core/validator.dart';
import 'package:notes_app/widgets/button/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';
import 'package:notes_app/widgets/button/note_icon_button_outlined.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController emailController;
  GlobalKey<FormFieldState> emailKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recover Password'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
              icon: FontAwesomeIcons.chevronLeft,
              onPressed: () {
                Navigator.maybePop(context);
              }
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Don\'t worry! Happens to the best for us!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24,),
              NoteFormField(
                key: emailKey,
                controller: emailController,
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                validator: Validator.emailValidator,
              ),
              SizedBox(height: 24,),
              SizedBox(
                height: 48,
                child: Selector<RegistrationController, bool>(
                  selector: (_, controller) => controller.isLoading,
                  builder: (_, isLoading, __) => NoteButton(
                    onPressed: isLoading ? null : () {
                      if(emailKey.currentState?.validate() ?? false){
                        context.read<RegistrationController>().resetPassword(
                          context: context,
                          email: emailController.text.trim()
                        );
                      }
                    },
                    child: isLoading
                        ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white,))
                        : Text('Send me a recovery link!'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
