import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_routes.dart';
import 'package:sippy_ca/core/config/app_theme.dart';
import 'package:sippy_ca/core/config/get_it_setup.dart';
import 'package:sippy_ca/core/data/data_sources/firebase_auth_service.dart';
import 'package:sippy_ca/core/data/data_sources/firestore_service.dart';
import 'package:sippy_ca/features/auth/data/repository/auth_repository.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:sippy_ca/features/cart_page.dart/presentation/provider/cart_provider.dart';
import 'package:sippy_ca/features/homepage/data/repositories/invite_repository.dart';
import 'package:sippy_ca/features/homepage/presentation/provider/invite_provider.dart';
import 'package:sippy_ca/features/product/data/repository/product_repository.dart';
import 'package:sippy_ca/features/product/presentation/provider/product_provider.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(
        create: (_) => ProductProvider(ProductRepository(
            firestoreService: getIt<FirestoreService>()))),
    ChangeNotifierProvider(
        create: (_) => InviteProvider(
            inviteRepository: InviteRepository(
                firebaseAuthService: getIt<FirebaseAuthService>(),
                firestoreService: getIt<FirestoreService>()))),
    ChangeNotifierProvider(
        create: (_) => AuthProvider(
            authRepository: AuthRepository(
                firebaseService: getIt<FirebaseAuthService>(),
                firestoreService: getIt<FirestoreService>())))
  ], child: const MyApp()));
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      routerConfig: router,
      title: 'Sippy Cart Assessment',
      debugShowCheckedModeBanner: false,
      darkTheme: MainAppTheme.lightTheme,
      theme: MainAppTheme.lightTheme,
    );
  }
}
