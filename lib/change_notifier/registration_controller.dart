import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/dialogs.dart';
import 'package:notes_app/services/auth_service.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;

  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool get isRegisterMode => _isRegisterMode;

  bool _isPasswordHidden = true;

  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  bool get isPasswordHidden => _isPasswordHidden;

  String _fullName = '';

  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String get fullName => _fullName.trim();

  String _email = '';

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> authenticateWithEmailAndPassword(
      {required BuildContext context}) async {
    isLoading = true;
    try {
      if (_isRegisterMode) {
        await AuthService.register(
            fullName: fullName, email: email, passWord: password);

        if (!context.mounted) return;
        showMessageDialog(
            context: context,
            message:
                'A verification email was sent to the provided email address. Please confirm your email to proceed to the app.');

        // reload the user
        while (!AuthService.isEmailVerified) {
          await Future.delayed(
              Duration(seconds: 5), () => AuthService.user?.reload());
        }
      } else {
        await AuthService.logIn(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An unkown error occurred',
      );
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: 'An unkown error occurred',
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> authenticateWithGoogle(
      {required BuildContext context}) async {
    try {
      await AuthService.signInWithGoogle();
    } on NoGoogleAccountChosenException {
      return;
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(context: context, message: 'An unknown error occurred');
    }
  }

  Future<void> resetPassword(
      {required BuildContext context, required String email}) async {
    isLoading = true;
    try {
      await AuthService.resetPassword(email: email);
      if (!context.mounted) return;
      showMessageDialog(
          context: context,
          message: 'A reset password link has been sent to $email');
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An unknown error occurred',
      );
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: 'An unkown error occurred',
      );
    } finally {
      isLoading = false;
    }
  }
}
