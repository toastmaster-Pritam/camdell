import 'package:flutter/material.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';

class CustomStepper extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onStepBack;

  const CustomStepper({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onStepBack,
  });

  @override
  Widget build(BuildContext context) {
    final int containerCount = (totalPages + 1) ~/ 2;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: onStepBack,
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColor.grey,
              size: 24,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                containerCount * 2 - 1,
                (index) {
                  if (index.isEven) {
                    return _buildContainer(index ~/ 2);
                  } else {
                    return _buildLine(index ~/ 2);
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildContainer(int containerIndex) {
    final int correspondingPage = containerIndex * 2 + 1;
    bool isActive = currentPage >= correspondingPage;
    bool isCurrent = currentPage == correspondingPage;

    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColor.primary : (isCurrent ? Colors.white : Colors.transparent),
        border: Border.all(
          color: isActive || isCurrent ? AppColor.primary : AppColor.grey.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '${containerIndex + 1}',
          style: Ts.bold(
            color: isActive ? Colors.white : (isCurrent ? AppColor.primary : AppColor.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildLine(int lineIndex) {
    final int leftPage = lineIndex * 2 + 1;
    final int currentLinePage = leftPage + 1;
    double progress = 0.0;

    if (currentPage > currentLinePage) {
      progress = 1.0;
    } else if (currentPage == currentLinePage) {
      progress = 0.5;
    }

    return SizedBox(
      width: 40,
      child: Stack(
        children: [
          Container(
            height: 2,
            color: AppColor.grey.withOpacity(0.5),
          ),
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: 2,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}