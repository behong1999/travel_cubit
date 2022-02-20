import 'dart:async';
import 'dart:developer';

import 'package:cubit_flutter/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

import 'package:cubit_flutter/misc/colors.dart';

class AppButton extends StatefulWidget {
  Color backGroundColor;
  Color borderColor;
  double width;
  double height;
  bool isElevated;

  Widget? child;
  Function? onPressed;

  AppButton({
    Key? key,
    this.backGroundColor = AppColors.buttonBackground,
    this.borderColor = AppColors.buttonBackground,
    this.child,
    this.width = 50,
    this.height = 50,
    this.onPressed,
    this.isElevated = true,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    bool elevation = widget.isElevated;
    return GestureDetector(
      onTap: () {
        widget.onPressed!();
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        width: widget.width,
        height: widget.height,
        child: widget.child,
        //* Neumorphism Button
        decoration: BoxDecoration(
            boxShadow: elevation
                ? const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
            color: widget.backGroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.borderColor),
            shape: BoxShape.rectangle),
      ),
    );
  }
}
