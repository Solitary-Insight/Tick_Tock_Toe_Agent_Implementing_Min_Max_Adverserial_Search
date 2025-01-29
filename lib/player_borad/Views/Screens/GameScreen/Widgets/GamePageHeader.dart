
import 'package:flutter/material.dart';
import 'package:tick_tock_agent/player_borad/Views/Screens/GameScreen/Widgets/GameHeaderIcon.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class GamePageHeader extends StatelessWidget {
  const GamePageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppSizes.sm * 1.5, top: AppSizes.lg * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GamePageHeaderIcon(
            icon: Icons.light,
            onClick: () {},
          ),
          Text("Legendary Mode",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: AppColors.light)),
          SizedBox(
            width: 32,
          )
        ],
      ),
    );
  }
}
