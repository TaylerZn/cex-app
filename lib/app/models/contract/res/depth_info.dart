

class DepthTick {
   List<List<num>>? asks;
   List<List<num>>? buys;

   DepthTick({
      this.asks,
      this.buys,
   });

   factory DepthTick.fromJson(Map<String, dynamic> json) => DepthTick(
      asks: json["asks"] == null ? [] : List<List<num>>.from(json["asks"]!.map((x) => List<num>.from(x.map((x) => x)))),
      buys: json["buys"] == null ? [] : List<List<num>>.from(json["buys"]!.map((x) => List<num>.from(x.map((x) => x)))),
   );

   Map<String, dynamic> toJson() => {
      "asks": asks == null ? [] : List<dynamic>.from(asks!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      "buys": buys == null ? [] : List<dynamic>.from(buys!.map((x) => List<dynamic>.from(x.map((x) => x)))),
   };
}
