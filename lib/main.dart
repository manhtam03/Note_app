import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/change_notifier/registration_controller.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/registration.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifier/note_notifier.dart';
import 'package:notes_app/core/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationController())
      ],
      child: MaterialApp(
        title: 'Note App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primary),
            useMaterial3: true,
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: background,
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                backgroundColor: Colors.transparent,
                titleTextStyle: TextStyle(
                    color: primary,
                    fontSize: 32,
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.bold
                )
            )
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData && AuthService.isEmailVerified
                ? HomePage()
                : Registration();
          }
        ),
      ),
    );
  }
}
