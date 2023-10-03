import 'package:blog_rise/controller/blogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/screens/blogs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BlogsProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            appBarTheme: const AppBarTheme(
              color: Colors.blueGrey,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            useMaterial3: true,
          ),
          home: const BlogsScreen()),
    );
  }
}
