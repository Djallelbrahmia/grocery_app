import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/Prodivers/dark_theme_provider.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/orders/order_screen.dart';
import 'package:grocery_app/screens/viewed/viewed_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:provider/provider.dart';

import '../widgets/text_wiget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _adressController = TextEditingController();
  final User? user = authInstance.currentUser;
  bool _isLoading = false;
  String? _email, _name, _adress;
  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(_uid).get();
      _email = userDoc.get('email');
      _name = userDoc.get('name');
      _adress = userDoc.get('adress');
      _adressController.text = _adress = userDoc.get('adress');
    } catch (e) {
      GlobalMethods.ErrorDialog(subtitle: e.toString(), context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    _adressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return LoadingManger(
      isLoading: _isLoading,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                        text: "hey,    ",
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _name ?? "User",
                            style: TextStyle(
                              color: color,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(height: 5),
                  TextWidget(
                    text: _email ?? "E-mail",
                    color: color,
                    textsize: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                      title: "Adress",
                      subtitle: _adress ?? "My adress",
                      icon: IconlyBold.profile,
                      onPressed: () {
                        _showAdressDialog();
                      },
                      color: color),
                  _listTiles(
                      title: "Orders",
                      icon: IconlyBold.bag,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context: context, routName: OrderScreen.routeName);
                      },
                      color: color),
                  _listTiles(
                      title: "Wishlist",
                      icon: IconlyBold.heart,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context: context,
                            routName: WishlistScreen.routeName);
                      },
                      color: color),
                  _listTiles(
                      title: "Forget Password",
                      icon: IconlyBold.unlock,
                      onPressed: () {},
                      color: color),
                  _listTiles(
                      title: "Viewed Items",
                      icon: IconlyBold.show,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context: context, routName: ViewedSCreen.routeName);
                      },
                      color: color),
                  SwitchListTile(
                      title: Text(
                        themeState.getDarkTheme ? "Dark Mode" : "Light Mode",
                        style: TextStyle(
                            color: color,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      secondary: Icon(themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                      value: themeState.getDarkTheme,
                      onChanged: (bool value) {
                        themeState.setDarkTheme = value;
                      }),
                  _listTiles(
                      title: user == null ? "login" : "Logout",
                      icon: user == null ? IconlyBold.login : IconlyBold.logout,
                      onPressed: () {
                        user == null
                            ? Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }))
                            : GlobalMethods.WarningDialog(
                                title: "Sign out ",
                                subtitle: "Are you sure  you wanna sign out",
                                fct: () async {
                                  await authInstance.signOut();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const LoginScreen();
                                  }));
                                },
                                context: context);
                      },
                      color: color),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> _showAdressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          actions: [
            TextButton(
              onPressed: () async {
                if (user == null) {
                  GlobalMethods.ErrorDialog(
                      subtitle: "You need to login first", context: context);
                  Navigator.of(context).pop();
                  return;
                }
                String _uid = user!.uid;
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .update({'adress': _adressController.text});
                  _adress = _adressController.text;
                } catch (e) {
                  GlobalMethods.ErrorDialog(
                      subtitle: e.toString(), context: context);
                } finally {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Update"),
            ),
          ],
          content: TextField(
            onChanged: (value) {
              // _adressController.text,
            },
            maxLines: 5,
            decoration: InputDecoration(hintText: "Your address"),
            controller: _adressController,
          ),
        );
      },
    );
  }
}

Widget _listTiles({
  required String title,
  String? subtitle,
  required IconData icon,
  required onPressed,
  required Color color,
}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textsize: 24,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle ?? '',
        color: color,
        textsize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyBold.arrowRight2),
    ),
  );
}
