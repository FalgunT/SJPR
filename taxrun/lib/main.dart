import 'package:flutter/material.dart';
import 'package:taxrun/screen/profile/invoice_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: //LoginPage(loginBloc: LoginBloc()),
          const InvoiceScreen(),
    );
  }
}
