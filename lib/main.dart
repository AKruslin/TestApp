import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/home_bloc.dart';
import 'di/injection.dart';
import 'presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: BlocProvider(
        create: (context) => getIt<HomeBloc>(),
        child: const HomePage(),
      ),
    );
  }
}
