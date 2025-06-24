class MyDeviceType {
  static const int ios = 1;
  static const int android = 2;

  static String text(context, int code) {
    String text = '';
    switch (code) {
      case ios:
        // text = S.of(context).device_type_ios;
        break;
      case android:
        // text = S.of(context).device_type_android;
        break;
    }
    return text;
  }
}
