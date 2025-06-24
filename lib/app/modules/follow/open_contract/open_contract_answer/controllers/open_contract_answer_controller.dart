import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class OpenContractAnswerController extends GetxController {
  var isDone = false;
  var isChecked = false.obs;

  List<ContractAnswerModel> array = [];
  @override
  void onInit() {
    super.onInit();
    List<ContractAnswerModel> tempArray = Get.arguments['model'];
    array.addAll(tempArray);
    if (array.isEmpty) {
      ContractApi.instance().contractAnswer().then((value) {
        value.forEach((v) {
          array.add(ContractAnswerModel.fromJson(v));
        });
        update();
      }).catchError((e) {
        print('$e');
      });
    }
  }

  void checkData() {
    isDone = array.every((element) => element.selectIndex != null && element.showError == false);
    update();
  }

  void resetData() {
    for (var element in array) {
      element.selectIndex = null;
    }
    checkData();
  }

  void openContract() {
    ContractApi.instance().openTrade().then((value) {
      if (value == true) {
        UserGetx.to.user?.openContract = 1;
        UserGetx.to.update(['open_contract']);
        Bus.getInstance().emit(EventType.openContract, null);
        Get.back();
        Get.back();
        Get.back();
        UIUtil.showSuccess(LocaleKeys.trade233.tr);
      } else {
        Get.back();
        UIUtil.showError(LocaleKeys.trade281.tr);
      }
    }).catchError((e) {
      UIUtil.showError(LocaleKeys.trade281.tr);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class ContractAnswerModel {
  int? quiestionId;
  String quiestionText = '';
  int? optionsType;
  List<ContractOptionsModel>? options;
  int? selectIndex;
  int answerIndex = 0;
  bool get showError => selectIndex != null && selectIndex! != answerIndex;

  ContractAnswerModel({this.quiestionId, this.quiestionText = '', this.optionsType, this.options});

  ContractAnswerModel.fromJson(Map<String, dynamic> json) {
    quiestionId = json['quiestionId'];
    quiestionText = json['quiestionText'] ?? '';
    optionsType = json['optionsType'];
    if (json['options'] != null) {
      options = <ContractOptionsModel>[];

      List tempArr = json['options'];
      for (var i = 0; i < tempArr.length; i++) {
        var v = tempArr[i];
        if (v['isAnswer']) {
          answerIndex = i;
        }
        options!.add(ContractOptionsModel.fromJson(v)..i = i);
      }
    }
  }
}

class ContractOptionsModel {
  String? optionId;
  String optionText = '';
  bool? isAnswer;
  int i = 0;

  ContractOptionsModel({this.optionId, this.optionText = '', this.isAnswer});

  ContractOptionsModel.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    optionText = json['optionText'] ?? '';
    isAnswer = json['isAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['option_id'] = optionId;
    data['option_text'] = optionText;
    data['is_answer'] = isAnswer;
    return data;
  }
}


/*
[
  {quiestionId: 1,
   quiestionText: 这是问题内容, 
   options: [
    {isAnswer: true, optionId: 1, optionText: 这个是选项1}, 
    {isAnswer: false, optionId: 2, optionText: 这个是选项2}, 
    {isAnswer: false, optionId: 3, optionText: 这个是选项3}, 
    {isAnswer: false, optionId: 4, optionText: 这个是选项4}, 
    {isAnswer: false, optionId: 5, optionText: 这个是选项5}],
     optionsType: 0}, 
  {quiestionId: 2,
   quiestionText: 这是问题内容, 
   options: [
    {isAnswer: true, optionId: 1, optionText: 这个是选项1},
     {isAnswer: false, optionId: 2, optionText: 这个是选项2}, 
     {isAnswer: false, optionId: 3, optionText: 这个是选项3}, 
     {isAnswer: false, optionId: 4, optionText: 这个是选项4}, 
     {isAnswer: false, optionId: 5, optionText: 这个是选项5}], 
     optionsType: 0}]




     [
      {quiestionId: 1, 
      quiestionText: 这是问题内容, 
     
     options: [{isAnswer: true, optionId: 1, optionText: 这个是选项1}, {isAnswer: false, optionId: 2, optionText: 这个是选项2}, {isAnswer: false, optionId: 3, optionText: 这个是选项3}, {isAnswer: false, optionId: 4, optionText: 这个是选项4}, {isAnswer: false, optionId: 5, optionText: 这个是选项5}],
     
     optionsType: 0}, 
     
     
     
     
     {quiestionId: 2, quiestionText: 这是问题内容, options: [{isAnswer: true, optionId: 1, optionText: 这个是选项1}, {isAnswer: false, optionId: 2, optionText: 这个是选项2}, {isAnswer: false, optionId: 3, optionText: 这个是选项3}, {isAnswer: false, optionId: 4, optionText: 这个是选项4}, {isAnswer: false, optionId: 5, optionText: 这个是选项5}], optionsType: 0}]

*/