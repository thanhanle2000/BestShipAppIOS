class ListUserModels {
  bool? success;
  int? total;
  List<DataUser>? data;

  ListUserModels({this.success, this.total, this.data});

  ListUserModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      data = <DataUser>[];
      json['data'].forEach((v) {
        data!.add(new DataUser.fromJson(v));
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

class DataUser {
  int? id;
  String? userName;

  DataUser({this.id, this.userName});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    return data;
  }
}
