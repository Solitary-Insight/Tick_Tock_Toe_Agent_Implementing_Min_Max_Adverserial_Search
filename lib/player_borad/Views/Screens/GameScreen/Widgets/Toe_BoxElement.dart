
import 'package:flutter/material.dart';
import 'package:tick_tock_agent/constants/colors.dart';
import 'package:tick_tock_agent/player_borad/Controllers/Gamecontroller.dart';

import '../../../../../constants/sizes.dart';

class Toe_BoxElement extends StatelessWidget {
  final String? image;
  bool isWinnerBox;
   Toe_BoxElement({
    
    super.key, required this.image,this.isWinnerBox=false
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(decoration: BoxDecoration(

         color:  isWinnerBox?image=="X"?AppColors.info: AppColors.success:const Color.fromARGB(255, 35, 44, 70),
         
         borderRadius: BorderRadius.circular(AppSizes.md)),
         child: Padding(
           padding: const EdgeInsets.all(AppSizes.sm),
           child:image==''? SizedBox(height: 60,
               width: 60,): Center(child: Image.asset(
               image=="X"?'assets/images/cross_curvy.png':'assets/images/check_curvy.png',
               height: 60,
               width: 60,
             ),),
         ),
         
         );
  }
}