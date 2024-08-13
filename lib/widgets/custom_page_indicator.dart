import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  final int currentPage;
  final int numPages;
  final void Function(int index)? onTap;

  const CustomPageIndicator({
    super.key,
    required this.currentPage,
    required this.numPages,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        numPages,
        (index) {
          return InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: onTap != null ? () => onTap!(index) : null,
            child: Container(
              width: currentPage == index ? 20 : 10,
              height: 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: currentPage == index ? Colors.yellow[600] : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
