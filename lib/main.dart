import 'package:flutter/material.dart';
import 'package:alphaapplication/flashscreen.dart';
import 'package:provider/provider.dart';
import 'package:alphaapplication/Flashcardprovider.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('flashcards');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FlashcardProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FlashScreen());
  }
}
