import 'package:flutter/cupertino.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class SelectOptionWidget extends StatelessWidget {
  final bool selected;
  const SelectOptionWidget({super.key, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return  selected ?  MyImage('otc/c2c/selected_icon'.svgAssets()) : MyImage('otc/c2c/unselected_icon'.svgAssets());
  }
}
