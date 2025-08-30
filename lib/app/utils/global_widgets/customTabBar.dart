import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabNames;
  final Function(int) onTabSelected;
  final RxInt selectedIndex;

  const CustomTabBar({
    Key? key,
    required this.tabNames,
    required this.onTabSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Obx(
              () => Row(
            children: List.generate(
              tabNames.length,
                  (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTabSelected(index);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                      color: selectedIndex.value == index
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.horizontal(
                        left: index == 0 ? Radius.circular(10) : Radius.zero,
                        right: index == tabNames.length - 1 ? Radius.circular(10) : Radius.zero,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          tabNames[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedIndex.value == index
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}