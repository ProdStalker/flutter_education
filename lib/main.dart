import 'package:education/core/commons/app/providers/course_of_the_day_notifier.dart';
import 'package:education/core/commons/app/providers/notifications_notifier.dart';
import 'package:education/core/commons/app/providers/user_provider.dart';
import 'package:education/core/res/colours.dart';
import 'package:education/core/res/fonts.dart';
import 'package:education/core/services/injection_container.dart';
import 'package:education/core/services/router.dart';
import 'package:education/firebase_options.dart';
import 'package:education/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => CourseOfTheDayNotifier()),
        ChangeNotifierProvider(
          create: (_) => NotificationNotifier(sl<SharedPreferences>()),
        ),
      ],
      child: MaterialApp(
        title: 'Education',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.transparent),
          colorScheme:
              ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
          fontFamily: Fonts.poppins,
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
