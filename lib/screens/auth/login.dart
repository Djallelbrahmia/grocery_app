import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/auth/forget_pass.dart';
import 'package:grocery_app/screens/auth/registre.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../../consts/consts.dart';
import '../../consts/firebase_consts.dart';
import '../../fetch_screen.dart';
import '../btm_bar.dart';
import 'Google_auth_button.dart';
import 'auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text);
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
                        text: "Sing in to continue",
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
                                    .requestFocus(_passFocusNode);
                              },
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
                                _submitFormOnLogin();
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
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: AuthButton(
                                fct: () {
                                  _submitFormOnLogin();
                                },
                                buttonText: "Login",
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: GoogleButton(),
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
                            SizedBox(
                              width: double.infinity,
                              child: AuthButton(
                                fct: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const FetchScreen();
                                  }));
                                },
                                buttonText: "Continue as guest ",
                                primary: Colors.black38,
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    text: 'Don\'t have an account?',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    children: [
                                  TextSpan(
                                      text: '  Sign up',
                                      style: const TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          GlobalMethods.navigateTo(
                                              context: context,
                                              routName:
                                                  RegistreScreen.routeName);
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
