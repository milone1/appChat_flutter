import 'package:appchat_flutter/screens/chat_screen.dart';
import 'package:appchat_flutter/screens/loading_screen.dart';
import 'package:appchat_flutter/screens/login_screen.dart';
import 'package:appchat_flutter/screens/register_screen.dart';
import 'package:appchat_flutter/screens/user_screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'user': ( _ ) => const UserScreen(),
  'chat': ( _ ) => const ChatScreen(),
  'login': ( _ ) => const LoginScreen(),
  'register': ( _ ) => const RegisterScreen(),
  'loading': ( _ ) => const LoadingScreen(), 
};
