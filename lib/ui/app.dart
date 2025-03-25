import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/bloc/app_cubit.dart';
import 'common/app_theme/theme.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp.router(
          builder: (context, child) {
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) {
                    FToast().init(context);
                    return child!;
                  },
                )
              ],
            );
          },
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          routerConfig: appRouter,
          title: 'Flutter Demo',
          theme: makeAppTheme(),
          darkTheme: makeAppTheme(isDark: true),
        );
      },
    );
  }
}
