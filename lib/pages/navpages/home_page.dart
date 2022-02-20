import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubit_flutter/cubit/app_cubit.dart';
import 'package:cubit_flutter/misc/colors.dart';
import 'package:cubit_flutter/misc/dummy.dart';
import 'package:cubit_flutter/widgets/app_text.dart';
import 'package:cubit_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cubit_flutter/widgets/app_large_text.dart';
import 'package:marquee/marquee.dart';

import '../../misc/painter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _tabController = TabController(length: 3, vsync: this);
    final _advancedDrawerController = AdvancedDrawerController();

    void _handleMenuButtonPressed() {
      _advancedDrawerController.showDrawer();
    }

    return BlocBuilder<AppCubit, CubitStates>(builder: (context, state) {
      if (state is LoadedState) {
        final placesData = state.places;
        return AdvancedDrawer(
          backdropColor: Colors.deepPurple,
          openRatio: 0.65,
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          animateChildDecoration: true,
          drawer: const CustomDrawer(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopIcons(
                        onTap: () => _handleMenuButtonPressed,
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: AppLargeText(text: 'Discover'),
                      ),
                      const SizedBox(height: 10),

                      //* =============== TAB BAR ===============
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor:
                              const Color.fromRGBO(189, 189, 189, 1),
                          //* Set the tab bar item to be wide enough for its label
                          isScrollable: true,
                          indicator: const CircleTabIndicator(
                              color: AppColors.mainColor, radius: 4),
                          tabs: const [
                            Tab(text: 'Places'),
                            Tab(text: 'Inspiration'),
                            Tab(text: 'Emotions'),
                          ],
                        ),
                      ),

                      //* =============== TAB BAR VIEW ===============
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: double.infinity,
                        height: 280,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: placesData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () => BlocProvider.of<AppCubit>(
                                              context)
                                          .getDetail(placesData[index].name),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'img/${placesData[index].img}'))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: 200,
                                        height: 70,
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 18.0,
                                            right: 18,
                                            top: 8,
                                            bottom: 20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              AutoSizeText(
                                                placesData[index].name,
                                                maxLines: 1,
                                                minFontSize: 18,
                                                overflowReplacement: SizedBox(
                                                  width: 180,
                                                  height: 18,
                                                  child: Marquee(
                                                    blankSpace: 140,
                                                    scrollAxis: Axis.horizontal,
                                                    velocity: 20,
                                                    text:
                                                        placesData[index].name,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  AppText(
                                                    text: placesData[index]
                                                        .location,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const Text('Inspiration'),
                            const Text('Emotions'),
                          ],
                        ),
                      ),

                      //* =============== EXPLORE MORE ===============
                      ExploreMore()
                    ]),
              ),
            ),
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}

class TopIcons extends StatelessWidget {
  TopIcons({Key? key, this.onTap}) : super(key: key);
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => onTap!(),
            child: const Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade400,
            ),
            child: const Icon(Icons.person),
          )
        ],
      ),
    );
  }
}

class ExploreMore extends StatelessWidget {
  const ExploreMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(text: "Explore more", size: 22),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: AppText(text: 'See All'),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 25),
                      child: Column(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'img/' + Dummy.icons.keys.elementAt(index),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppText(
                            text: Dummy.icons.values.elementAt(index),
                            color: AppColors.textColor2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
