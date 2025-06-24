import 'package:flutter/cupertino.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class MarketIcon extends StatelessWidget {
  const MarketIcon({super.key, required this.iconName, this.width = 32, this.isOval = true,this.boxFit = BoxFit.contain});
  final String iconName;
  final double width;
  final bool isOval;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    var icon = MyImage(MarketDataManager.instance.getIconWithName(iconName), width: width, height: width,fit:boxFit);
    return isOval ? ClipOval(child: icon) : icon;
  }
}
