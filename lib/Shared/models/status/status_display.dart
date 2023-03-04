class StatusDisplay {
  bool? success;
  int? total;
  List<Data>? data;

  StatusDisplay({this.success, this.total, this.data});

  StatusDisplay.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? actionId;
  String? actionText;
  int? actionCallTime;

  Data({this.actionId, this.actionText, this.actionCallTime});

  Data.fromJson(Map<String, dynamic> json) {
    actionId = json['action_id'];
    actionText = json['action_text'];
    actionCallTime = json['action_call_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action_id'] = this.actionId;
    data['action_text'] = this.actionText;
    data['action_call_time'] = this.actionCallTime;
    return data;
  }
}
