import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/screens/auth/forget_pass.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../../consts/consts.dart';
import '../../fetch_screen.dart';
import '../btm_bar.dart';
import 'Google_auth_button.dart';
import 'auth_button.dart';

class RegistreScreen extends StatefulWidget {
  const RegistreScreen({super.key});
  static const routeName = "/RegistreScreen";

  @override
  State<RegistreScreen> createState() => _RegistreScreenState();
}

class _RegistreScreenState extends State<RegistreScreen> {
  final _adressTextController = TextEditingController();
  final _adressFocusNode = FocusNode();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;
  @override
  void dispose() {
    _adressTextController.dispose();
    _adressFocusNode.dispose();
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegistre() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text);
        User? user = authInstance.currentUser;
        final _uid = user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(_uid).set({
          'id': _uid,
          'name': _nameTextController.text,
          'adress': _adressTextController.text,
          'email': _emailTextController.text,
          'userWish': [],
          'UserCart': [],
          'CreatedDate': Timestamp.now()
        });
        user.updateDisplayName(_nameTextController.text);
        user.reload();
      } catch (e) {
        GlobalMethods.ErrorDialog(subtitle: e.toString(), context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const FetchScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManger(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Consts.authImagesPaths[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: Consts.authImagesPaths.length,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
              ),
              autoplay: true,
              duration: 1800,
              autoplayDelay: 2000,
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const TextWidget(
                      text: "Welcome Back",
                      color: Colors.white,
                      textsize: 30,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const TextWidget(
                        text: "Sing up to continue",
                        color: Colors.white,
                        textsize: 18),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_adressFocusNode);
                              },
                              controller: _nameTextController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid Name';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'name',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ), //password
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocusNode);
                              },
                              controller: _adressTextController,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return 'Please enter a valid adress';
                                } else {
                                  return null;
                                }
                              },
                              focusNode: _adressFocusNode,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Shopping adress',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ), //password
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_passFocusNode);
                              },
                              focusNode: _emailFocusNode,
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return 'Please enter a valid email adress';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ), //password
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                _submitFormOnRegistre();
                              },
                              controller: _passTextController,
                              focusNode: _passFocusNode,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obsecureText,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obsecureText = !_obsecureText;
                                    });
                                  },
                                  child: _obsecureText
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    GlobalMethods.navigateTo(
                                        context: context,
                                        routName:
                                            ForgetPasswordScreen.routeName);
                                  },
                                  child: const Text('Forget password?',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          fontStyle: FontStyle.italic))),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: AuthButton(
                                fct: () {
                                  _submitFormOnRegistre();
                                },
                                buttonText: "Sign Up",
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: GoogleButton(
                                buttonText: "Sign Up with google",
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextWidget(
                                    text: "OR",
                                    color: Colors.white,
                                    textsize: 18),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),

                            RichText(
                                text: TextSpan(
                                    text: 'you already have an account ?',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    children: [
                                  TextSpan(
                                      text: '  Sign in',
                                      style: const TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          GlobalMethods.navigateTo(
                                              context: context,
                                              routName: LoginScreen.routeName);
                                        }),
                                ]))
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
