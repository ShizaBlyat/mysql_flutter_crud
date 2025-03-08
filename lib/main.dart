import 'package:Control_de_Empleados/logic/models/mysql.dart';
import 'package:Control_de_Empleados/presentation/ui/product_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
var db = Mysql();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CONTROL DE EMPLEADOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductUi(),
    );
  }
}
