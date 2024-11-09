import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';

class SelectableContainer extends StatefulWidget {
  final List<String> items;
  final Function(int) onSelected;

  const SelectableContainer({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  State<SelectableContainer> createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth > 600 
          ? 150 
          : constraints.maxWidth / 2 - 16;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(
            widget.items.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onSelected(index);
              },
              child: Container(
                width: containerWidth,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.black,
                    width: _selectedIndex == index ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_month, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: AppText(
                        widget.items[index],
                        style: Ts.medium15(color: AppColor.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}