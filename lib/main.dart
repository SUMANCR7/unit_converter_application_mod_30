import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_converter_app/providers/converter_provider.dart';
import 'package:unit_converter_app/screen/converter_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ConverterProvider(),
    child:  MaterialApp(
        title: 'Unit Converter',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const ConverterScreen(),
    )
    );
  }
}


