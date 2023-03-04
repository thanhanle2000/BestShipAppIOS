class EventGetKey {
  String? key;
  EventGetKey({this.key});
}

class EventDate {
  String? startDate;
  String? endDate;
  EventDate({this.startDate, this.endDate});
}

class EventTextFieldSearch {
  String? customerName;
  String? orderCode;
  String? shopOrderCode;
  EventTextFieldSearch({this.customerName, this.orderCode, this.shopOrderCode});
}

class EventTextFieldPhone {
  String? customerPhone;
  EventTextFieldPhone({this.customerPhone});
}

class EventShopId {
  int? shopId;
  EventShopId({this.shopId});
}

class EventSorts {
  String? SortType;
  EventSorts({this.SortType});
}

class EventListStatus {
  List<int>? orderStatus;
  EventListStatus({this.orderStatus});
}

class TotalPramEvent {
  int? total;
  int? total_succsess;
  int? total_processing;
  int? total_other;

  TotalPramEvent(
      {this.total,
      this.total_succsess,
      this.total_other,
      this.total_processing});
}
