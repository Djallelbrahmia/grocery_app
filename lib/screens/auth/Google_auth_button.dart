import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'dart:developer' as dev;
import '../btm_bar.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({super.key, this.buttonText = "Sign in with google"});
  final String buttonText;
  Future<void> _googleSignIn(context) async {
    dev.log("Hey");

    final googleSignIn = GoogleSignIn();
    dev.log("Again");
    try {
      final googleAccount = await googleSignIn.signIn();
    } catch (e) {
      dev.log(e.toString());
    }
    final googleAccount = await googleSignIn.signIn();

    dev.log(googleAccount.toString());
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResults = await authInstance.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          if (authResults.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResults.user!.uid)
                .set({
              'id': authResults.user!.uid,
              'name': authResults.user!.displayName,
              'adress': '',
              'email': authResults.user!.email,
              'userWish': [],
              'UserCart': [],
              'CreatedDate': Timestamp.now()
            });
          }

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const FetchScreen(),
            ),
          );
        } on FirebaseException catch (error) {
          GlobalMethods.ErrorDialog(
              subtitle: '${error.message}', context: context);
        } catch (error) {
          GlobalMethods.ErrorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () async {
          await _googleSignIn(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                child: Image.asset(width: 40, 'assets/images/google.png')),
            const SizedBox(width: 8),
            TextWidget(text: buttonText, color: Colors.white, textsize: 18),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
