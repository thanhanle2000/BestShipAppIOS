import 'package:flutter/cupertino.dart';

class TagKeyWordModel {
  String? keyword;
  String? selectKey;
  int? type;
  dynamic value;

  TagKeyWordModel({
    this.keyword,
    this.type,
    this.selectKey,
    this.value,
  });
}

class Item {
  String name;
  int id;
  Item({required this.name, required this.id});
}

class ActionItemModel {
  int action_item_id;
  String action_item_text;
  ActionItemModel(
      {required this.action_item_id, required this.action_item_text});
}

class ActionModel {
  IconData? icon;
  Color? color;
  int? action_id;
  String? action_text;
  ActionModel({this.action_id, this.action_text, this.color, this.icon});
}

class DateRangeModels {
  int? id;
  String? date;
  String? dateStart;
  String? dateEnd;

  DateRangeModels({this.id, this.date, this.dateStart, this.dateEnd});
}

class EventSaved {
  String? order;
  String? orderCode;
  String? userName;

  EventSaved({this.order, this.orderCode, this.userName});
}

class ListStatusEvent {
  int? id;
  String? title;
  bool? value;
  ListStatusEvent({this.id, this.title, this.value = false});
}
