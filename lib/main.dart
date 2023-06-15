import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/Prodivers/cart_prodiver.dart';
import 'package:grocery_app/Prodivers/product_provider.dart';
import 'package:grocery_app/inner_screens/cat_screen.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/auth/forget_pass.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/auth/registre.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/categories.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/orders/order_screen.dart';
import 'package:grocery_app/screens/viewed/viewed_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  Widget build(BuildContext context) {
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
        })
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (context, themeChangeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
            home: const BottomBarScreen(),
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
  }
}
