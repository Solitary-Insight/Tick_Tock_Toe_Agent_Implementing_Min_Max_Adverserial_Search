import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tick_tock_agent/constants/colors.dart';
import 'package:tick_tock_agent/constants/elevated_button_theme.dart';
import 'package:tick_tock_agent/constants/sizes.dart';
import 'package:tick_tock_agent/constants/text_theme.dart';
import 'package:tick_tock_agent/player_borad/Controllers/Gamecontroller.dart';
import 'package:tick_tock_agent/player_borad/Views/Screens/GameScreen/Widgets/GameHeaderIcon.dart';
import 'package:tick_tock_agent/player_borad/Views/Screens/GameScreen/Widgets/Toe_BoxElement.dart';

import '../Widgets/GameBox.dart';
import '../Widgets/GamePageHeader.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});
  @override
  Widget build(BuildContext context) {
    int rows = 3;
    int cols = 3;
    GameController controller = Get.isRegistered<GameController>()
        ? Get.find<GameController>()
        : Get.put(GameController(rows, cols));

    return MaterialApp(
      theme: ThemeData(
          textTheme: AppTextTheme.lighAppTextTheme,
          elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme),
      debugShowCheckedModeBanner: false,
      home: SizedBox(
        child: Container(
          color: const Color.fromARGB(255, 35, 44, 70),
          child: Column(
            children: [
              GamePageHeader(),
              SizedBox(height: AppSizes.spaceBtwItems),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.sm * 1.5, vertical: AppSizes.lg * 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(()=>
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          border: controller.Player_Turn.value=="O"?Border.all(color: AppColors.info):null,
                          borderRadius: BorderRadius.circular(AppSizes.sm)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm * 1.5,
                            vertical: AppSizes.sm),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/man.png',
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("You    :",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: AppColors.light)),
                                SizedBox(
                                  width: 20,
                                ),
                                Obx(()=>Text(controller.rounds_record["O"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: AppColors.light))),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppSizes.sm)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm * 1.5,
                            vertical: AppSizes.sm),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/value.png',
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Draw    :",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: AppColors.light)),
                                SizedBox(
                                  width: 20,
                                ),
                                Obx(()=>Text(controller.rounds_record["Draw"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: AppColors.light))),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(()=>Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          border: controller.Player_Turn.value=="X"?Border.all(color: AppColors.warning):null,
                          borderRadius: BorderRadius.circular(AppSizes.sm)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm * 1.5,
                            vertical: AppSizes.sm),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/robot.png',
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Bot    :",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: AppColors.light)),
                                SizedBox(
                                  width: 20,
                                ),
                                Obx(()=>Text(controller.rounds_record["X"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: AppColors.light))),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.sm / 2,
              ),
              Obx(
                () => Text(
                    controller.GameStarted.value && controller.Winner.value==''?controller.Heading_message.value:"Start new game",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.apply(
                          color: AppColors.light,
                          fontWeightDelta: 500,
                        )),
              ),
              const SizedBox(
                height: AppSizes.sm / 2,
              ),
              const GameBox(),
              const SizedBox(
                height: AppSizes.sm / 2,
              ),
               Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.lg, vertical: AppSizes.sm * 1.5),
                child:  SizedBox(
                    width: double.infinity,
                    child: Obx((){
                      return !controller.GameStarted.value==true? ElevatedButton(
                        onPressed: () {
                          controller.startGame();
                        },
                        child: Text("Start Game")): SizedBox();
                    })),
              ),
              const SizedBox(
                height: AppSizes.sm / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.lg, vertical: AppSizes.sm * 1.5),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.resetBoard();
                        },
                        child: Text("Reset board"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
