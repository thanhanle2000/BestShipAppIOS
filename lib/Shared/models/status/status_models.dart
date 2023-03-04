class StatusModels {
  bool? success;
  String? message;
  StatusData? data;

  StatusModels({this.success, this.message, this.data});

  StatusModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? StatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  StatusModels copyWith({bool? success, String? message, StatusData? data}) {
    return StatusModels(success: success, message: message, data: data);
  }
}

class StatusData {
  int? status;
  String? name;

  StatusData({this.status, this.name});

  StatusData.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}
