import 'package:assignment/bloc/user_bloc.dart';
import 'package:assignment/repository/user_repository.dart';
import 'package:assignment/screens/user_detail_screen.dart';
import 'package:assignment/screens/user_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => UserBloc(context.read<UserRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter User App',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: '/',
          routes: {
            '/': (context) => const UserListScreen(),
            '/detail': (context) => const UserDetailScreen(),
          },
        ),
      ),
    );
  }
}
