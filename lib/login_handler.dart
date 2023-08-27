import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studenttutorapp/ScreenBeforeLogin.dart';
import 'package:studenttutorapp/home_view.dart';
import 'package:studenttutorapp/login_view.dart';
import 'package:studenttutorapp/main.dart';
import 'package:studenttutorapp/tutor_homeView.dart';
import 'package:studenttutorapp/tutor_loginView.dart';
import 'package:studenttutorapp/view_model.dart';

class LoginHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    // TODO: implement build
    return _authState.when(
      data: (data) {
        if (data != null) {
          if (role == "student") {
            return StudentHomeView();
          } else if (role == "tutor") {
            return TutorHomeScreen();
          } else {
            return ScreenBeforeLogin();
          }
        } else {
          if (role == "student") {
            return StudentLoginView();
          } else if (role == "tutor") {
            return TutorLogin();
          } else {
            return ScreenBeforeLogin();
          }
        }
      },
      error: (error, stackTrace) {
        return ScreenBeforeLogin();
      },
      loading: () => CircularProgressIndicator(),
    );
  }
}
