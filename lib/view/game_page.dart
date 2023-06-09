import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_lottery_game/constant/list_image_lottery.dart';
import 'dart:math'as math;
import 'package:flutter_build_lottery_game/controller/game_controller.dart';
import 'package:flutter_build_lottery_game/widget/my_lottery_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin{
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 30),
    vsync: this
    );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  int? n1,n2,n3,n4,n5,n6;
  bool stop = false;
  bool setValue=false;
  bool isCongra=false;
  List<String> listNumber=[];
  List<int> listTap=[];
  List<int> listCongratulatoin=[];
  List<int> listTotteryIndex=[];
  int? currentTap;
  final congratulatonController = ConfettiController();
  void randomLottery(){
    var random = Random();
     n1 = random.nextInt(9);
     n2 = random.nextInt(9);
     n3 = random.nextInt(9);
    //  n4 = random.nextInt(9);
    //  n5 = random.nextInt(9);
    //  n6 = random.nextInt(9);
  }
  void addLottery(){
    String i1 = listImageLottey[n1!];
    String i2 = listImageLottey[n2!];
    String i3 = listImageLottey[n3!];
    if(listNumber.isEmpty){
      listNumber.add(i1);
      listNumber.add(i2);
      listNumber.add(i3);
      // listNumber.add(n4!);
      // listNumber.add(n5!);
      // listNumber.add(n6!);
      listTotteryIndex.add(n1!);
      listTotteryIndex.add(n2!);
      listTotteryIndex.add(n3!);
    }else{
      
    }
  }
  void getLotteryNumber(){
      randomLottery();
      addLottery();
  }
  void startGame(){
    controller.repeat();
    stop=false;
    currentTap=null;
    // ignore: avoid_print
    print('Lenght of List = ${listNumber.length}');
    
  }
  void stopGame(){
   controller.stop();
    getLotteryNumber();
    stop=true;
    // ignore: avoid_print
    for(int i=0;i<listTap.length;i++){
      print(' ListTap =${listTap[i]}');
    }
    for(int i=0;i<listTotteryIndex.length;i++){
      print(' ListRandom =${listTotteryIndex[i]}');
    }
    getMessageCongratulation();
  }
  void repeatGame(){
    controller.stop();
    gameController.setGuesState(true);
    listNumber.clear();
    listTap.clear();
    stop=false;
    currentTap=null;
    // ignore: avoid_print
    print('Lenght of List = ${listNumber.length}');
    for(int i=0;i<listTap.length;i++){
      // ignore: avoid_print
      print('ListTap[$i] = ${listTap[i]}');
    }
  }
  void getCongratulation(){
    for(int i=0;i<listTotteryIndex.length;i++){
      for(int j=0;j<listTap.length;j++){
        if(listTotteryIndex[i]==listTap[j]){
           setState(() {
            isCongra=true;
          });
        }
      }
    }
  }
  void getMessageCongratulation(){
    getCongratulation();
    setState(() {
      if(isCongra){
        listTotteryIndex.clear();
        congratulatonController.play();
        Get.defaultDialog(
          title: 'You Win',
          backgroundColor: Colors.white.withOpacity(0.5),
          content: SizedBox(
            height: 200,
            width: double.infinity,
            child: ConfettiWidget(
              confettiController: congratulatonController,
              blastDirection: 0,
          )
          )
        );
        Timer(const Duration(seconds: 5), () { 
        congratulatonController.stop();
        isCongra=false;
        });
      }else{
        Get.defaultDialog(
          title: 'Unlucky...!',
          backgroundColor: Colors.white.withOpacity(0.5),
          content: SizedBox(
            height: 200,
            //width: double.infinity,
            child: Lottie.asset(
              'assets/smile-and-sad-emoji.json',
              fit: BoxFit.cover
            ),
          )
        );
      //   Get.snackbar(
      //   '','',
      //   titleText: const Text(
      //     'Unlucky',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.red
      //     ),
      //     ),
      //   messageText:  const Text(
      //     'Try again...!',
      //     style: TextStyle(
      //       fontSize: 18,
      //       color: Colors.black
      //     ),
      //     ),
      //   duration: const Duration(seconds: 5),
      //   backgroundColor: Colors.red.withOpacity(0.2)
      // );
      }
    });
  }
  GameController gameController = Get.put(GameController());
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width; 
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boxLottery(heigth, width),
                lotteryRandomResult(heigth, width)
              ],
            ),
          ],
        ),
      )
    );
  }
Column boxLottery(double heigth, double width) {
    return Column(
    children: [
      Stack(
        children: [
          Container(
              height: heigth*0.5,
              width: width*0.3,
              //color: Colors.black,
            ),
           Container(
            alignment: Alignment.center,
              height: width*0.5,
              width: width*0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image/Artboard 13 copy.png'
                  )
                )
              ),
            ),
            
          Container(
            height: width*0.3,
            width: width*0.3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                alignment: Alignment.centerLeft,
                children: List.generate(
                  listImageLottey.length, (index){
                      return AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Transform.rotate(
                            angle: controller.value*300*math.cos(index*4.1),
                          //angle: controller.value*60*index*math.pi,
                          child: Container(    
                            //padding: EdgeInsets.all(10),  
                            alignment: Alignment.bottomCenter,                                              
                            height: width*0.27-(index),
                            width: double.infinity,
                            decoration:    const BoxDecoration(
                              shape: BoxShape.circle,
                              //color: listColor[index].withOpacity(0.2)
                          ),
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              height: width*0.05,
                              width: width*0.05,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    listImageLottey[index]
                                  )
                                )
                              ),
                              
                            )
                          ),
                        );
                      },
                                        );            
                  })
                  ),
                  Container(
                  height: width*0.08,
                  width: width*0.08,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle
                  ),
                ),
                  //======================
                  Container(
                    height: width*0.3,
                    width: width*0.3,
                    child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          return Transform.rotate(
                              angle: controller.value*300*math.cos(1),
                            //angle: controller.value*60*index*math.pi,
                            child: Container(    
                              //padding: EdgeInsets.all(10),  
                              alignment: Alignment.bottomCenter,                                              
                              height: heigth/2 * 0.1,
                              width: double.infinity,
                              decoration:    const BoxDecoration(
                                //shape: BoxShape.circle,
                                //color: listColor[index].withOpacity(0.2)
                            ),
                            child: Container(
                              alignment: Alignment.center,
                                margin: const EdgeInsets.all(5),
                                height: width*0.3,
                                width: width*0.3,
                                decoration:   const BoxDecoration(
                                  shape: BoxShape.circle,
                                  //color: Colors.white.withOpacity(0.5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                  image: AssetImage(
                                  'assets/image/Artboard 11.png'
                                )
                              )
                  
                                ),

                              )
                            ),
                          );
                        },
                      ),
                  ),
              ],
            )
          ),
        ],
      ),
      
    ],
  );
  }
Padding lotteryRandomResult(double heigth, double width) {
    return Padding(
    padding:  EdgeInsets.only(
      top: heigth*0.05
    ),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: heigth*0.1,
          width: width/2,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(
              20
            ),
            border: Border.all(
              width: 1,
              color: Colors.white
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
              ),
            ]
          
          ),
          child:stop? Row(
            children: List.generate(
              listNumber.length, (index){
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  height: heigth*0.08,
                  width: heigth*0.08,
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(listNumber[index])
                    )
                    //color: listColor[index]
                  ),
                  // child: Text(
                  //   listNumber[index].toString()
                  // ),
                );
              }),
          ):const Text(''),
        ),
          myButtonGame(heigth, width),
          showLottery(heigth, width),
          //Check
          MyLotteryWidget(heigth: heigth, width: width, listTap: listTap, gameController: gameController)
        //
      ],
    ),
  );
  }
Container showLottery(double heigth, double width) {
    return Container(
    padding: const EdgeInsets.all(5),
      height: heigth*0.4,
      width: width/1.75,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 85, 85, 84), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.5,
          color: Colors.greenAccent
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2,-1),
            color: Colors.blue,
            blurRadius: 5
          ),
            BoxShadow(
            offset: Offset(2,-1),
            color: Colors.blue,
            blurRadius: 5
          )
        ]
      ),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 1
        ), 
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                currentTap=index;
                listTap.add(index+1);
                print(' Value = ${index+1}');
                gameController.setGuesState(true);
              });
            },
            child: currentTap==index?
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(3),
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color:  Colors.greenAccent,
                border: Border.all(
                  width: 2,
                  color: Colors.yellow
                )
              ),
              child: Text(
                '${index+1}',
                style:  TextStyle(
                  fontSize: width*0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ) : 
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(3),
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.5),
                border: Border.all(
                  width: 0,
                  color: Colors.white
                )
              ),
              child: FittedBox(
                child: Text(
                  '${index+1}',
                  style:  TextStyle(
                    fontSize: width*0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ) ,
          );
        },
      ),
    );
  }
Padding myButtonGame(double heigth, double width) {
    return Padding(
    padding: const EdgeInsets.only(
      top: 10
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            
            setState(() {
              startGame();
            });
          },
          child: Container(
            alignment: Alignment.center,
            height: width*0.08,
            width: width*0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/image/Artboard 3.png'
                )
              )
            ),
            child:  Text(
              'START',
              style: TextStyle(
                fontSize: width*0.03,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            
            setState(() {
              stopGame();
            });
  
          },
          child: Container(
            alignment: Alignment.center,
            height: width*0.08,
            width: width*0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/image/Artboard 3.png'
                )
              )
            ),
            child:  Text(
              'STOP',
              style: TextStyle(
                fontSize: width*0.03,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            
            setState(() {
              repeatGame();
            });
  
          },
          child: Container(
            alignment: Alignment.center,
            height: width*0.08,
            width: width*0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/image/Artboard 3.png'
                )
              )
            ),
            child:  Text(
              'REPEAT',
              style: TextStyle(
                fontSize: width*0.03,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }
}

