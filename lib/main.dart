import 'package:comsicon/firebase_options.dart';
import 'package:comsicon/pages/authentication_page.dart';
import 'package:comsicon/pages/course_details.dart';
import 'package:comsicon/pages/home_page.dart';
import 'package:comsicon/pages/login_page.dart';
import 'package:comsicon/pages/profile_setup_page.dart';
import 'package:comsicon/pages/signup_page.dart';
import 'package:comsicon/pages/starter_page.dart';
import 'package:comsicon/pages/student_dashboard.dart';
import 'package:comsicon/pages/tutor_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Import your pages here
import 'package:comsicon/pages/splash_screen.dart';
// Add your other page imports as needed, for example:
// import 'package:comsicon/pages/homePage.dart';
// import 'package:comsicon/pages/authPage.dart';
// etc.

// Import your theme files (you'll need to create these)
import 'package:comsicon/theme/app_theme.dart' show lightTheme, darkTheme;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Tracks whether the app should be in dark mode or light mode
  bool isDarkMode =
      true; // Default: Dark. Set to false if you want Light by default

  /// Method that toggles the theme; called from SettingsScreen
  void toggleTheme(bool enableDark) {
    setState(() {
      isDarkMode = enableDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comsicon',

      // Provide both light and dark themes
      theme: lightTheme,
      darkTheme: darkTheme,

      // Dynamically pick which theme to use
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Define initial route
      initialRoute: '/splash',

      // Define all routes
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/starterPage': (context) => const edTech(), // Your starter page
        '/auth': (context) => AuthenticationPage(),
        '/signUp': (context) => const SignUpScreen(), // Your signup page
        '/login': (context) => const LoginScreen(), // Your login page
        '/profileSetup':
            (context) => const ProfileSetupScreen(), // Your profile setup page
        // Add all your other routes here, for example:
        '/home': (context) => HomePage(),
        '/tutorDashboard': (context) => TutorDashboard(),
        '/studentDashboard': (context) => StudentDashboard(),
        // '/login': (context) => LoginPage(),
        // '/signup': (context) => SignupPage(),
        // '/settings': (context) => SettingsPage(
        //   isDarkMode: isDarkMode,
        //   onDarkModeToggled: toggleTheme,
        // ),
        // Add more routes as needed
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/courseDetails') {
          // Extract the courseId from arguments
          final String courseId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => CourseDetailsScreen(courseId: courseId),
          );
        }
        return null;
      },
    );
  }
}
