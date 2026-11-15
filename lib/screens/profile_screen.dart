// import 'package:apple_store/core/constants/myColor.dart';
// import 'package:apple_store/widgets/tittle_app_bar.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Mycolor.backgroundScreenColor,
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(child: TittleAppBar(title: 'حساب کاربری')),
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   Text(
//                     'محمد حسین ',
//                     style: TextStyle(fontFamily: 'sb', fontSize: 16),
//                   ),
//                   Text(
//                     '2222222222222',
//                     style: TextStyle(
//                       fontFamily: 'sm',
//                       fontSize: 12,
//                       color: Mycolor.gery,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SliverPadding(
//               padding: EdgeInsetsGeometry.symmetric(
//                 horizontal: 44,
//                 vertical: 20,
//               ),
//               sliver: Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: SliverGrid(
//                   delegate: SliverChildBuilderDelegate(childCount: 10, (
//                     context,
//                     index,
//                   ) {
//                     // return CategoryItem();
//                   }),

//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,

//                     childAspectRatio: 1 / 1.2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:apple_store/features/orders/presentation/pages/orders_screen.dart';
import 'package:flutter/material.dart';

/// صفحه حساب کاربری (فعلاً فقط لینک به سابقه خرید).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(Icons.receipt_long),
              title: const Text(
                'سابقه خرید',
                style: TextStyle(fontFamily: 'sb', fontSize: 14),
              ),
              trailing: const Icon(Icons.chevron_left),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
