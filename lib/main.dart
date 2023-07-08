import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/Prodivers/cart_prodiver.dart';
import 'package:grocery_app/Prodivers/orders_provider.dart';
import 'package:grocery_app/Prodivers/product_provider.dart';
import 'package:grocery_app/Prodivers/viewd_product_provider.dart';
import 'package:grocery_app/Prodivers/wishlist_provider.dart';
import 'package:grocery_app/inner_screens/cat_screen.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/Prodivers/dark_theme_provider.dart';
import 'package:grocery_app/screens/auth/forget_pass.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/auth/registre.dart';
import 'package:grocery_app/screens/orders/order_screen.dart';
import 'package:grocery_app/screens/viewed/viewed_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'fetch_screen.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_live_51NRIf5GPzHDOrSuHIALf2X8XVkCj4zt5UkMSDWDTOOHXLsDZc4Ck89s6Ina8aYkfRo0YCLc7pSVOpzGVlN4Pn82q00uaxv1JJd";
  await Stripe.instance.applySettings();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.dartThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text("An Error occured"),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (_) {
              return ProductProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return CartProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return WishlistProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ViewdProdProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return OrderProvider();
            })
          ],
          child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme:
                    Styles.themeData(themeChangeProvider.getDarkTheme, context),
                home: const FetchScreen(),
                routes: {
                  OnsaleScreen.routeName: (context) {
                    return const OnsaleScreen();
                  },
                  FeedsScreen.routeName: (context) {
                    return const FeedsScreen();
                  },
                  ProductScreen.routeName: (context) => const ProductScreen(),
                  WishlistScreen.routeName: (context) => WishlistScreen(),
                  OrderScreen.routeName: (context) => const OrderScreen(),
                  ViewedSCreen.routeName: (context) => const ViewedSCreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  RegistreScreen.routeName: (context) => const RegistreScreen(),
                  ForgetPasswordScreen.routeName: (context) =>
                      const ForgetPasswordScreen(),
                  CategoryFeedsScreen.routeName: (context) =>
                      const CategoryFeedsScreen(),
                });
          }),
        );
      },
    );
  }
}
