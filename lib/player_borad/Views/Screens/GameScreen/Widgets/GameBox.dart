
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tick_tock_agent/player_borad/Views/Screens/GameScreen/Widgets/Toe_BoxElement.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../../Controllers/Gamecontroller.dart';

class GameBox extends StatelessWidget {

  const GameBox({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    GameController controller=Get.find<GameController>();
    
    return Container(
      decoration: BoxDecoration(
      color: AppColors.primary,
       borderRadius: BorderRadius.circular(AppSizes.md),
      
    
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (int row = 0; row < controller.BOARD_ROWS.value; row++)
        
              Row(
                mainAxisSize: MainAxisSize.min,
              children: [
               for (int col = 0; col < controller.BOARD_COLS.value; col++)
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: 
                 Obx(()=> GestureDetector(onTap: (){
                   if(controller.GameStarted.value && controller.Player_Turn.value=="O"){
                    if(controller.board[row][col] == ''){
                      controller.updateBoard(row, col, controller.Player_Turn.value);
                      controller.updatePlayerTurn();
                    }
                    
                    
                   }

                 },child: Toe_BoxElement(image: controller.board.value[row].value[col],isWinnerBox:controller.isWinnerBox(row, col))))
               )
              ]
              ,)
            
        
            
          ],
        ),
      ),
    );
  }
}
