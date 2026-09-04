import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:apple_store/features/home/presentation/widgets/banner_slider.dart';
import 'package:apple_store/features/home/presentation/widgets/category_list.dart';
import 'package:apple_store/widgets/item_horizental_list.dart';
import 'package:apple_store/features/home/presentation/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator.get<HomeBloc>()..add(HomeStarted()),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var homeWidget = Container();
            if (state is HomeInLoadInProgress) {
              homeWidget = Container(child: CircularProgressIndicator());
            }
            if (state is HomeLoadFailure) {
              homeWidget = Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(44.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'sm', fontSize: 13),
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Mycolor.blueIndicator,

                            onTap: () {
                              context.read<HomeBloc>().add(HomeRefreshed());
                            },
                            child: Container(
                              // width: 56,
                              // height: 56,
                              decoration: ShapeDecoration(
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Mycolor.blue,
                                    blurRadius: 30,
                                    spreadRadius: -6,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                color: Mycolor.blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'تلاش مجدد',
                                  style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (state is HomeLoadSuccess) {
              homeWidget = Container(
                child: CustomScrollView(
                  slivers: [
                    SerchAppBar(),
                    BannerSlider(banners: state.banners),
                    CategoryList(categoryList: state.categories),
                    ItemHorizentalList(),
                    ItemHorizentalList(),
                  ],
                ),
              );
            }

            return homeWidget;
          },
        ),
      ),
    );
  }
}
