import 'package:cubit_flutter/cubit/app_cubit.dart';
import 'package:cubit_flutter/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponisveButton extends StatelessWidget {
  bool? isResponsive;
  double? height;
  double? width;
  List<Widget>? widgets;
  Function? onTap;
  Color color;

  ResponisveButton({
    Key? key,
    this.onTap,
    this.widgets,
    this.isResponsive = false,
    this.color = AppColors.mainColor,
    this.width,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          onTap!();
          // BlocProvider.of<AppCubit>(context).getData();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: isResponsive == true ? double.maxFinite : width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Row(
            mainAxisAlignment: isResponsive == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (widgets == null) const SizedBox.shrink() else ...widgets!,
              Image.asset(
                'img/swipe_right_main.gif',
                height: 20,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }
}
