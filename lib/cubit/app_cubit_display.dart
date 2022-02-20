import 'package:cubit_flutter/cubit/app_cubit.dart';
import 'package:cubit_flutter/pages/detail_page.dart';
import 'package:cubit_flutter/pages/main_page.dart';
import 'package:cubit_flutter/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitDisplay extends StatefulWidget {
  AppCubitDisplay({Key? key}) : super(key: key);

  @override
  State<AppCubitDisplay> createState() => _AppCubitDisplayState();
}

class _AppCubitDisplayState extends State<AppCubitDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, CubitStates>(
        builder: (context, state) {
          if (state is WelcomeState) {
            return WelcomePage();
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadedState) {
            return MainPage();
          }
          if (state is DetailState) {
            return DetailPage();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
