import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/bloc/payment_waiting_list_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/bloc/payment_waiting_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/payment/payment_shipper_detail_models.dart';
import '../../../presentation/repositories/payment/payment_respository.dart';

class PaymentWaitingBloc
    extends Bloc<PaymentWaitingListEvent, PaymentWaitingListState> {
  final PaymentRespository _paymentRespository;
  PaymentWaitingBloc({required PaymentRespository paymentRespository})
      // ignore: unnecessary_null_comparison
      : assert(paymentRespository != null),
        _paymentRespository = paymentRespository,
        super(PaymentWaitingListState.empty()) {
    on<PaymentWaitingListEvent>((event, emit) async {
      // khai báo dữ liệu ban đầu
      PaymentShipperDetailModels paymentShipperDetailModels =
          PaymentShipperDetailModels();
      PaymentShipperModel paymentShipperModel = PaymentShipperModel();
      PaymentShip paymentShip = PaymentShip();
      List<OrderModels> orderModel = [];

      if (event is PaymentWaitingListStartedEvent) {
        emit(PaymentWaitingListState.empty());
        // lấy dữ liệu cho danh sách đợi thanh toán
        paymentShipperDetailModels =
            await _paymentRespository.getDataPaymentWaitingList();
        try {
          paymentShipperModel = paymentShipperDetailModels.data!;
          paymentShip = paymentShipperModel.paymentShip!;
          orderModel = paymentShipperModel.paymentShipOrders!;
          emit(PaymentWaitingListState.start(
              true, "PaymentWaitingListStartedEvent", paymentShip, orderModel));
        } catch (e) {
          emit(PaymentWaitingListState.fail('Không có dữ liệu'));
        }
      }
    });
  }
}
