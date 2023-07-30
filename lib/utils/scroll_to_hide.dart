
import 'package:flutter/material.dart';
import 'package:midlr/utils/size_config.dart';

class ScrollToHideBottomNavigationBar extends StatelessWidget {
  ScrollToHideBottomNavigationBar({
    Key? key,
    required this.isVisible,
    required this.child,
  }) : super(key: key);

  final bool isVisible;
  final Widget child;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        return AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          height: isVisible ? 20.heightAdjusted : 0,
          child: child,
        );
      },
      child: Wrap(
        children: [child],
      ),
    );
  }
}
