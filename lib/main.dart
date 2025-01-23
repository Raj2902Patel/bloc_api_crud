import 'package:bloc_api/bloc/user_bloc.dart';
import 'package:bloc_api/ui/displayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => UserBloc()..add(LoadUserEvent()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.lexendTextTheme(),
      ),
      home: const DisplayDataPage(),
    );
  }
}
