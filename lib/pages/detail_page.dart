import 'package:cubit_flutter/cubit/app_cubit.dart';
import 'package:cubit_flutter/misc/colors.dart';
import 'package:cubit_flutter/models/place.dart';

import 'package:cubit_flutter/widgets/app_buttons.dart';
import 'package:cubit_flutter/widgets/app_large_text.dart';
import 'package:cubit_flutter/widgets/app_text.dart';

import 'package:cubit_flutter/widgets/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedButton = -1;
  bool isFavorite = false;

  changeNumber(int index) {
    setState(() {
      selectedButton = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<AppCubit, CubitStates>(
        builder: (context, state) {
          if (state is DetailState) {
            Place place = state.place;
            int ratedStars = place.stars;
            return Stack(
              children: [
                //* =============== IMAGE ===============
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            //* Put a slightly black filter on the image
                            colorFilter: const ColorFilter.mode(
                              Colors.black26,
                              BlendMode.srcOver,
                            ),
                            image: AssetImage('img/' + place.img))),
                  ),
                ),
                //* =============== Top Icons ===============
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubit>(context).backHome();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          size: 30,
                        ),
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                //* =============== Content ===============
                Positioned(
                  top: height * 0.35,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: height * 0.65,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.55,
                                  child: AutoSizeText(
                                    place.name,
                                    maxLines: 1,
                                    minFontSize: 30,
                                    overflowReplacement: SizedBox(
                                      height: 30,
                                      child: Marquee(
                                        blankSpace: 140,
                                        scrollAxis: Axis.horizontal,
                                        velocity: 20,
                                        text: place.name,
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.3,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AppLargeText(
                                      text:
                                          '\$ ${place.price.toStringAsFixed(2)}',
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            const Icon(
                              Icons.location_pin,
                              color: Colors.black54,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            AppText(text: place.location)
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            ...List.generate(
                                5,
                                (index) => Icon(
                                      index < ratedStars
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: index < ratedStars
                                          ? Colors.yellow
                                          : Colors.black26,
                                    )),
                            const SizedBox(width: 5),
                            AppText(
                              text: '(${ratedStars.toStringAsFixed(1)})',
                              color: AppColors.textColor2,
                            )
                          ]),
                          const SizedBox(height: 20),
                          AppLargeText(
                            text: 'People',
                            size: 18,
                          ),
                          const SizedBox(height: 10),
                          AppText(
                            text: 'Number of people in your group',
                            color: AppColors.textColor2,
                          ),
                          Wrap(
                            children: List.generate(
                              5,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  child: AppButton(
                                      isElevated: selectedButton == index
                                          ? false
                                          : true,
                                      onPressed: () {
                                        changeNumber(index);
                                      },
                                      backGroundColor:
                                          AppColors.buttonBackground,
                                      child: Center(
                                        child: AppLargeText(
                                            text: (index + 1).toString(),
                                            bold: index == selectedButton
                                                ? true
                                                : false,
                                            color: index == selectedButton
                                                ? Colors.purple
                                                : AppColors.mainColor,
                                            size: 18),
                                      )),
                                );
                              },
                            ),
                          ),
                          AppLargeText(
                            text: 'Description',
                            size: 18,
                          ),
                          const SizedBox(height: 10),
                          AppText(
                            text: place.description,
                            color: AppColors.textColor2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //* =============== Bottom Buttons ===============
                Positioned(
                    bottom: 10,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                            isElevated: isFavorite ? false : true,
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            backGroundColor: Colors.white,
                            borderColor: AppColors.textColor1,
                            child: isFavorite
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.textColor1,
                                  )),
                        const SizedBox(width: 20),
                        ResponisveButton(
                          isResponsive: true,
                          widgets: [
                            AppLargeText(
                              text: 'Book Trip Now',
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
