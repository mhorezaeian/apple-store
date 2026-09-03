import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//product_category
import 'package:apple_store/features/product_category/presentation/bloc/product_category_state.dart';
import 'package:apple_store/features/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:apple_store/features/product_category/presentation/bloc/product_category_event.dart';

class ProductCategoryScreen extends StatelessWidget {
  const ProductCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator.get<ProductCategoryBloc>()..add(ProductCategoryStarted()),
      child: ProductCategoryView(),
    );
  }
}

class ProductCategoryView extends StatelessWidget {
  const ProductCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
          builder: (context, state) {
            var CategoryContaine = Container();
            //
            if (state is ProductCategoryLoadInProgress) {
              CategoryContaine = Container(
                child: Column(
                  children: [
                    TittleAppBar(title: 'دسته بندی محولات'),
                    Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              );
            }
            //loadSucsess
            if (state is ProductCategoryLoadSuccess) {
              CategoryContaine = Container(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: TittleAppBar(title: 'دسته بندی محولات'),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 44),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.categories.length,
                          (context, index) {
                            final category = state.categories[index];
                            return CachedImage(imageUrl: category.imageUrl);
                            // return Text('${category.imageUrl}');
                          },
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is ProductCategoryLoadFailure) {
              CategoryContaine = Container(
                child: Column(
                  children: [
                    TittleAppBar(title: 'دسته بندی محولات'),
                    Expanded(
                      child: Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CategoryContaine;
          },
        ),
      ),
    );
  }
}
// CustomScrollView(
//           slivers: [
//             TittleAppBar(title: 'دسته بندی محولات'),
//             SliverPadding(
//               padding: EdgeInsets.symmetric(horizontal: 44),
//               sliver: SliverGrid(
//                 delegate: SliverChildBuilderDelegate((context, index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   );
//                 }),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),