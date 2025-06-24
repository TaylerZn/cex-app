import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';

class PostChildWrapper {
  PostChild? type = PostChild.graph;
  Widget? widget;
  String? tag;
  PostChildWrapper({this.type,this.tag, this.widget});
}

enum PostChild {
  graph,
  vote,
  quote
}

enum TrendDirection {
 up('BULLISH'),//看涨
 down('BEARISH'); //看跌
 const TrendDirection(this.key);
 final String key;

 String title(){
   switch(this){
     case up:
       return  LocaleKeys.community52.tr;//'看涨';
     case down:
       return LocaleKeys.community53.tr;//'看跌';
   }
 }
}