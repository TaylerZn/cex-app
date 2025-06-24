import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyFileUtil {
  static Future<String> getBase64(path) async {
    final file = File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  static Future<Uint8List> parseBase64(data) async {
    var base64String = data;

    // 移除Data URI Scheme头（如果存在的话）
    final RegExp regExp = RegExp(r'data:image\/[a-zA-Z]+;base64,');
    final String base64Str = base64String.replaceFirst(regExp, '');

    // 去除所有换行符
    final String cleanBase64 =
        base64Str.replaceAll('\n', '').replaceAll('\r', '');

    return base64.decode(cleanBase64);
  }

  static String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }

  /// A method returns a human readable string representing a file _size
  static String filesize(dynamic size, [int round = 2]) {
    /**
   * [size] can be passed as number or as string
   *
   * the optional parameter [round] specifies the number
   * of digits after comma/point (default is 2)
   */
    var divider = 1024;
    int _size;
    try {
      _size = int.parse(size.toString());
    } catch (e) {
      throw ArgumentError('Can not parse the size parameter: $e');
    }

    if (_size < divider) {
      return '$_size B';
    }

    if (_size < divider * divider && _size % divider == 0) {
      return '${(_size / divider).toStringAsFixed(0)} KB';
    }

    if (_size < divider * divider) {
      return '${(_size / divider).toStringAsFixed(round)} KB';
    }

    if (_size < divider * divider * divider && _size % divider == 0) {
      return '${(_size / (divider * divider)).toStringAsFixed(0)} MB';
    }

    if (_size < divider * divider * divider) {
      return '${(_size / divider / divider).toStringAsFixed(round)} MB';
    }

    if (_size < divider * divider * divider * divider && _size % divider == 0) {
      return '${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB';
    }

    if (_size < divider * divider * divider * divider) {
      return '${(_size / divider / divider / divider).toStringAsFixed(round)} GB';
    }

    if (_size < divider * divider * divider * divider * divider &&
        _size % divider == 0) {
      num r = _size / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} TB';
    }

    if (_size < divider * divider * divider * divider * divider) {
      num r = _size / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} TB';
    }

    if (_size < divider * divider * divider * divider * divider * divider &&
        _size % divider == 0) {
      num r = _size / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} PB';
    } else {
      num r = _size / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} PB';
    }
  }
}
