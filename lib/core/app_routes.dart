import 'package:go_router/go_router.dart';
import 'package:sippy_ca/features/auth/presentation/pages/login_page.dart';
import 'package:sippy_ca/features/auth/presentation/pages/sign_up_page.dart';
import 'package:sippy_ca/features/cart_page.dart/presentation/pages/cart_page.dart';
import 'package:sippy_ca/features/homepage/data/models/beverage.dart';
import 'package:sippy_ca/features/homepage/presentation/pages/confirmation_page.dart';
import 'package:sippy_ca/features/homepage/presentation/pages/home_page.dart';
import 'package:sippy_ca/features/product/presentation/pages/product_page.dart';
import 'package:sippy_ca/wrapper.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
// ⛔ prevents GoRouter from routing automatically
  routes: [
    GoRoute(
        path: '/invite/:code',
        name: 'invite',
        builder: (context, state) => const Wrapper()),
    GoRoute(
        path: '/',
        name: 'welcome',
        builder: (context, state) => const Wrapper()),
    GoRoute(
        path: '/login',
        name: 'login-page',
        builder: (context, state) => const LoginPage()),
    GoRoute(
        path: '/sign-up',
        name: 'sign-up-page',
        builder: (context, state) => const SignUpPage()),
    GoRoute(
        path: '/home',
        name: 'home-page',
        builder: (context, state) => HomePage(
              invite: state.extra as bool?,
            )),
    GoRoute(
        path: '/product',
        name: 'product-page',
        builder: (context, state) => ProductPage(
              product: state.extra as BeverageItem?,
            )),
    GoRoute(
        path: '/cart-page',
        name: 'cart-page',
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return CartPage(
            cartName: extraData?['cartName'],
            cartId: extraData?['cartId'],
          );
        }),
    GoRoute(
        path: '/confirmation-page',
        name: 'confirmation-page',
        builder: (context, state) {
          return const ConfirmationPage();
        }),
  ],
);

GoRouter get router => _router;
