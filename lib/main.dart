import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(
  new Center(
    child: new Text(
      'Coding Dojo Angola',
      textDirection: TextDirection.ltr,
    ),
  )
);