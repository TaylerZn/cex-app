import 'dart:convert';

class QuickEntryList {
  String title;
  List<QuickEntryInfo> list;

  QuickEntryList({
    required this.title,
    required this.list,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'quickEntryInfos': list.map((x) => x.toMap()).toList(),
    };
  }

  factory QuickEntryList.fromJson(Map<String, dynamic> map) {
    return QuickEntryList(
      title: map['title'],
      list: List<QuickEntryInfo>.from(
          map['list']?.map((x) => QuickEntryInfo.fromMap(x))),
    );
  }
}

class QuickEntryInfo {
  String icon;
  String title;
  String route;
  bool requireLogin = false;
  String logo;

  QuickEntryInfo(
      {required this.icon,
      required this.title,
      required this.route,
      this.requireLogin = false,
      this.logo = ''});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickEntryInfo &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title &&
          requireLogin == other.requireLogin &&
          route == other.route;

  @override
  int get hashCode => icon.hashCode ^ title.hashCode ^ route.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'title': title,
      'route': route,
      'requireLogin': requireLogin,
      'logo':logo
    };
  }

  factory QuickEntryInfo.fromMap(Map<String, dynamic> map) {
    return QuickEntryInfo(
        icon: map['icon'],
        title: map['title'],
        route: map['route'],
        requireLogin: map['requireLogin'] ?? false,
        logo: map['logo'] ?? '');
  }

  factory QuickEntryInfo.fromString(String string) {
    return QuickEntryInfo.fromMap(json.decode(string));
  }

  static List<QuickEntryInfo> fromJsonList(List v) {
    return v
        .map((e) => QuickEntryInfo.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
