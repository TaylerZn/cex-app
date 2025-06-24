import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 

class MarketShimmer extends StatelessWidget {
  const MarketShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> array = List.generate(8, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: Row(children: <Widget>[
          Container(
            width: 35.0,
            height: 35.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 12,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 12,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white),
              ),
            ],
          ))
        ]),
      );
    });

    return
        // Text('加载');

        Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [...array]),
              ),
            ));
  }
}
