import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:foobar/services/auth.dart';
import 'package:foobar/screens/loading/loading.dart';
import 'package:foobar/screens/home/home.dart';
import 'package:foobar/screens/authenticate/authenticate.dart';

class RedirectionService {
  StreamBuilder builder = StreamBuilder(
    stream: AuthService().user,
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.done:
        case ConnectionState.waiting:
          return const Loading();
        case ConnectionState.active:
          if (snapshot.data == null) {
            return const Authenticate();
          } else {
            return Provider<User>(
              create: (_) => snapshot.data,
              child: Home(),
            );
          }
        default:
          return const Loading();
      }
    },
  );
}
