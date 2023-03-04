import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/bloc/payment_shipper_detail_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/bloc/payment_shipper_detail_state.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/payment/payment_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentShipperDetailsBloc
    extends Bloc<PaymentShipperDetailsEvent, PaymentShipperDetailsState> {
  final PaymentRespository _paymentRespository;
  PaymentShipperDetailsBloc({required PaymentRespository paymentRespository})
      // ignore: unnecessary_null_comparison
      : assert(paymentRespository != null),
        _paymentRespository = paymentRespository,
        super(PaymentShipperDetailsState.empty()) {
    on<PaymentShipperDetailsEvent>((event, emit) async {
      // khai báo dữ liệu ở trên
      PaymentShipperDetailModels paymentShipperDetailModels =
          PaymentShipperDetailModels();
      PaymentShipperModel paymentShipperModel = PaymentShipperModel();
      List<OrderModels> orderModel = [];
      PaymentShip paymentShip = PaymentShip();
      if (event is PaymentShipperDetailsStartedEvent) {
        // set empty cho hàm khởi tạo
        emit(PaymentShipperDetailsState.empty());
        // lấy dữ liệu cho danh sách thanh toán chi tiết
        paymentShipperDetailModels =
            await _paymentRespository.getDataPaymentDetails();
        try {
          paymentShipperModel = paymentShipperDetailModels.data!;
          paymentShip = paymentShipperModel.paymentShip!;
          orderModel = paymentShipperModel.paymentShipOrders!;
        } catch (e) {
          emit(PaymentShipperDetailsState.fail('Không có dữ liệu'));
        }
      }
      // emit data tổng dưới này
      emit(PaymentShipperDetailsState.start(
          true, "PaymentShipperDetailsStartedEvent", paymentShip, orderModel));
    });
  }
}
