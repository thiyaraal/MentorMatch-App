import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:my_flutter_app/Mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/admin/screen/dasboard_admin_screen.dart';
import 'package:my_flutter_app/firebase_options.dart';
import 'package:my_flutter_app/login/login_screen.dart';
import 'package:my_flutter_app/mentee/provider/review_mentor_provider.dart';
import 'package:my_flutter_app/mentee/screen/landing_page.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';
import 'package:my_flutter_app/mentor/Screens/register_mentor/verification_page.dart';
import 'package:my_flutter_app/mentor/provider/create_class_provider.dart';
import 'package:my_flutter_app/mentor/provider/create_session_provider.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await UserPreferences.init();

  final isLoggedIn = UserPreferences.isLoggedIn();
  final userType = UserPreferences.getUserType();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    userType: userType,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userType;

  const MyApp({super.key, required this.isLoggedIn, this.userType});

  @override
  Widget build(BuildContext context) {
    Widget homeScreen = const LandingPage();
    if (isLoggedIn) {
      switch (userType) {
        case 'Mentee':
          homeScreen = const MenteeHomePage();
          break;
        case 'Mentor':
          homeScreen = const MentorHomePage();
          break;
        case 'Admin':
          homeScreen = DashboardAdminScreen();
          break;
        case 'PendingMentor' || 'RejectedMentor':
          homeScreen = VerificationPage();
          break;
        case null || '':
          homeScreen = const LandingPage();
          break;
        default:
          homeScreen = const LoginScreen();
      }
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateSessionProvider()),
        ChangeNotifierProvider(create: (_) => CreateClassProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mentor Match',
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        //   home: Scaffold(
        // body: SearchWidgetini(),
        home: homeScreen,
        // home: const RegisterMentorScreen(),
        //  homeScreen,
      ),
    );
  }
}
