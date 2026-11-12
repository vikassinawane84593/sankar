
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sankar/home/screen/homescreen.dart';

import 'firebase_options.dart';
import 'package:sankar/auth/block/bloc.dart';
import 'package:sankar/auth/block/event.dart';
import 'package:sankar/auth/repository/auth_repository.dart';
import 'package:sankar/auth/screen/loginscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SankarShopApp());
}

class SankarShopApp extends StatelessWidget {
  const SankarShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(FirebaseAuth.instance),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => AuthBloc(
              context.read<AuthRepository>(),
            )..add(const AuthInitializeEvent()),

            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sankar Shop',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepOrange,
                ),
              ),
              home: const HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
