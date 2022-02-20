import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_flutter/cubit/app_cubit.dart';
import 'package:cubit_flutter/misc/colors.dart';
import 'package:cubit_flutter/misc/string_extension.dart';
import 'package:cubit_flutter/models/place.dart';
import 'package:cubit_flutter/services/data_services.dart';
import 'package:cubit_flutter/widgets/app_large_text.dart';
import 'package:cubit_flutter/widgets/app_text.dart';
import 'package:cubit_flutter/widgets/responsive_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<List<Place>>(
          stream: DataServices().fetchAll(),
          builder: (context, AsyncSnapshot<List<Place>> snapshot) {
            if (snapshot.hasData) {
              final places = snapshot.data;
              return PageView.builder(
                // itemCount: Dummy.locations.length,
                itemCount: places?.length,
                itemBuilder: (context, index) {
                  return Stack(children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 120, left: 20, right: 20),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppLargeText(
                                        maxLines: 1,
                                        text: places![index].name,
                                        bold: true,
                                      ),
                                      AppLargeText(
                                        text: places[index].type.capitalize(),
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: mWidth * 0.6,
                                        child: AppText(
                                          text: places[index].description,
                                          color: AppColors.textColor2,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      ResponisveButton(
                                        onTap: () =>
                                            BlocProvider.of<AppCubit>(context)
                                                .getData(),
                                        width: 100,
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: List.generate(3, (indexDots) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      width: 8,
                                      height: index == indexDots ? 25 : 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.mainColor,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "img/" + places[index].img,
                        height: mHeight * 0.45,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ]);
                },
                scrollDirection: Axis.vertical,
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Something went wrong! ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
