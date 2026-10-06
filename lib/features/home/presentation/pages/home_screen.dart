import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:apple_store/features/home/presentation/widgets/banner_slider.dart';
import 'package:apple_store/features/home/presentation/widgets/category_list.dart';
import 'package:apple_store/features/home/presentation/widgets/product_horizental_list.dart';
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
            if (state is HomeLoadInProgress) {
              return CircularProgressIndicator();
            }
            if (state is HomeLoadFailure) {
              // print("home lode faill");
              return FailureStateWidget(
                message: state.message,
                onRetry: () {
                  // print('Home Refresh');
                  context.read<HomeBloc>().add(HomeRefreshed());
                },
              );
            }
            if (state is HomeLoadSuccess) {
              return CustomScrollView(
                slivers: [
                  SerchAppBar(),
                  BannerSlider(banners: state.banners),
                  CategoryList(categoryList: state.categories),
                  ProductHorizentalList(
                    title: 'پرفروشترین',
                    productList: state.bsetSellerProducts,
                  ),
                  ProductHorizentalList(
                    title: 'جدید ترین',
                    productList: state.hotestproducts,
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
