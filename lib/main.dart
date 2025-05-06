import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_cubit.dart';
import 'package:bloc_restapi_app/module.dart';
import 'package:bloc_restapi_app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  locator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<GetcontactCubit>(
        create: (context) => getIt.call(),
        child: Home(),
      ),
    );
  }
}
