
import 'package:flutter/material.dart';
import 'package:tick_tock_agent/constants/colors.dart';
import 'package:tick_tock_agent/constants/sizes.dart';


class GamePageHeaderIcon extends StatelessWidget {
  final IconData icon;
  final onClick;
  const GamePageHeaderIcon({
    super.key, required this.icon, this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.sm/2),
    
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.sm))
      ),
      child: Center(child: Icon(icon,fill: 0.2,color: AppColors.light,size: 32,)));
  }
}