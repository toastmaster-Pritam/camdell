import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';

class FilterItem {
  final String text;
  final IconData? icon;

  FilterItem({required this.text, this.icon});
}
class FilterNavigationBar extends StatelessWidget {
  final List<FilterItem> items;
  final Function(int) onItemSelected;

  const FilterNavigationBar({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              elevation: 0,
              side: BorderSide(color: Colors.grey[300]!),
              label: items[index].icon != null
                  ? Icon(items[index].icon, size: 20)
                  : AppText(
                      items[index].text,
                      style: Ts.regular11(),
                    ),
              selected: false,
              onSelected: (_) => onItemSelected(index),
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

            ),
          );
        },
      ),
    );
  }
}