import 'package:get/get.dart';
class GameController extends GetxController{
  RxBool isGues = false.obs;
  void setGuesState(bool state){
    isGues.value=state;
  }
}