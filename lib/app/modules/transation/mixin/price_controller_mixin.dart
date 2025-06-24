import 'package:k_chart/entity/depth_entity.dart';

mixin PriceControllerMixin {
  List<DepthEntity> mergeDepthEntities(List<DepthEntity> entities) {
    // 使用 Map 存储合并后的结果，price 作为 key，vol 作为 value
    Map<double, double> priceVolMap = {};

    for (var entity in entities) {
      // 如果相同价格已经存在，则累加 vol
      if (priceVolMap.containsKey(entity.price)) {
        priceVolMap[entity.price] = priceVolMap[entity.price]! + entity.vol;
      } else {
        // 否则新增一条记录
        priceVolMap[entity.price] = entity.vol;
      }
    }

    // 将 Map 转换回 List<DepthEntity>
    return priceVolMap.entries.map((entry) {
      return DepthEntity(entry.key, entry.value);
    }).toList();
  }
}
