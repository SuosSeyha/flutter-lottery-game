import 'package:flutter/material.dart';
import 'package:flutter_build_lottery_game/controller/game_controller.dart';
class MyLotteryWidget extends StatelessWidget {
  const MyLotteryWidget({
    super.key,
    required this.heigth,
    required this.width,
    required this.listTap,
    required this.gameController,
  });

  final double heigth;
  final double width;
  final List<int> listTap;
  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(
        top: heigth*0.03
      ),
      height: heigth*0.2,
      width: width*0.55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Colors.greenAccent
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2,-1),
            color: Colors.blue,
            blurRadius: 5
          ),
           BoxShadow(
            offset: Offset(-2,1),
            color: Colors.blue,
            blurRadius: 5
          )
        ]
      ),
      child: GridView.builder(
        itemCount: listTap.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 1
        ), 
        itemBuilder: (context, index) {
          if(gameController.isGues.value){
            return Container(
              alignment: Alignment.center,
              //color: Colors.amber,
              child: Text(
              listTap[index].toString(),
              style:  TextStyle(
                fontSize: width*0.05,
                fontWeight: FontWeight.bold, 
                color: Colors.greenAccent
              ),
            ) 
            );
          }
          return null;
        },
        ),
    );
  }
}