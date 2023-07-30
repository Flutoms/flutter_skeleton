// import 'package:alajo/ui/global_components/bottom_nav_widget.dart';
// import 'package:alajo/ui/nav_screens/dashboard/dashboard.dart';
// import 'package:alajo/ui/nav_screens/loan/loan.dart';
// import 'package:alajo/ui/nav_screens/more/more.dart';
// import 'package:alajo/ui/nav_screens/more/settings/personal_info/personal_info_cubit.dart';
// import 'package:alajo/ui/nav_screens/payments/payments.dart';
// import 'package:alajo/ui/nav_screens/savings/savings.dart';
// import 'package:alajo/utils/multi_value_listenable.dart';
// import 'package:alajo/utils/scroll_to_hide.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:midlr/utils/multi_value_listenable.dart';
//
// final isNavVisible = ValueNotifier(true);
//
// class Domain extends StatefulWidget {
//   const Domain({Key? key}) : super(key: key);
//
//   @override
//   State<Domain> createState() => _DomainState();
// }
//
// class _DomainState extends State<Domain> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<PersonalInfoCubit>().getProfile();
//   }
//
//   Widget bottomPages({required int index}) {
//     final bottomPages = [
//       const Dashboard(),
//       const Savings(),
//       const Loan(),
//       const Payments(),
//       const More()
//     ];
//     return bottomPages[index];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: MultiValueListenableBuilder(
//           valueListenables: [pagePosition, isNavVisible],
//           builder: (context, List value, child) {
//             return Scaffold(
//               backgroundColor: Colors.white,
//               bottomNavigationBar: ScrollToHideBottomNavigationBar(
//                   isVisible: value[1], child: const BottomNavigation()),
//               body: bottomPages(index: value[0]),
//             );
//           }),
//     );
//   }
// }
