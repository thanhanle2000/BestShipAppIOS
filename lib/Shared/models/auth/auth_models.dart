class AuthModels {
  String? token;
  AuthenticationViewModel? authenticationViewModel;
  bool? successful;
  String? error;

  AuthModels(
      {this.token, this.authenticationViewModel, this.successful, this.error});

  AuthModels.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    authenticationViewModel = json['authenticationViewModel'] != null
        ? AuthenticationViewModel.fromJson(json['authenticationViewModel'])
        : null;
    successful = json['successful'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.authenticationViewModel != null) {
      data['authenticationViewModel'] = this.authenticationViewModel!.toJson();
    }
    data['successful'] = this.successful;
    data['error'] = this.error;
    return data;
  }
}

class AuthenticationViewModel {
  int? id;
  String? userName;
  String? email;
  int? shopId;
  int? userType;

  AuthenticationViewModel(
      {this.id, this.userName, this.email, this.shopId, this.userType});

  AuthenticationViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    shopId = json['shopId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['shopId'] = this.shopId;
    data['userType'] = this.userType;
    return data;
  }
}
