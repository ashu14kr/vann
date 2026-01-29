import 'package:flutter/material.dart';

abstract class AuthInterface {
  Future<bool> signInWithApple({required BuildContext context});
}
