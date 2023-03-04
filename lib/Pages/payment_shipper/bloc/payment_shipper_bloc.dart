import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc_state.dart';
import 'package:flutter_app_best_shipp/Shared/models/payment/payment_shipper_models.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/payment/payment_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/models/payment/confirm_payment_models.dart';

class PaymentShipperBloc
    extends Bloc<PaymentShipperEvent, PaymentShipperState> {
  final PaymentRespository _paymentRespository;
  PaymentShipperBloc({required PaymentRespository paymentRespository})
      // ignore: unnecessary_null_comparison
      : assert(paymentRespository != null),
        _paymentRespository = paymentRespository,
        super(PaymentShipperState.empty()) {
    on<PaymentShipperEvent>((event, emit) async {
      // dữ liệu rỗng sẽ được khai báo trên này để nhận data từng event
      PaymentShipperModels paymentShipperModels = PaymentShipperModels();
      ConfirmPaymentModels confirmPaymentModels = ConfirmPaymentModels();
      List<PaymentModels> data = [];
      // sự kiện khởi tạo data
      if (event is PaymentShipperStartedEvent) {
        // khởi tạo đầu tiên sẽ set dữ liệu là empty
        emit(PaymentShipperState.empty());
        // hàm lấy danh sách order scan fail
        paymentShipperModels = await _paymentRespository.getDataListPayment();
        try {
          data = paymentShipperModels.data!;
          emit(PaymentShipperState.start(
              true,
              state.status,
              paymentShipperModels.total!,
              data,
              confirmPaymentModels.success ?? false,
              confirmPaymentModels.message ?? ''));
        } catch (e) {
          emit(PaymentShipperState.fail('Không có dữ liệu.'));
        }
      }
      // sự kiện chuyển trạng thái phiếu thanh toán chưa xác nhận -> đã xác nhận
      else if (event is PaymentShipperConfirmEvent) {
        confirmPaymentModels =
            await _paymentRespository.getConfirmPayment(event.PaymentId);
        paymentShipperModels = await _paymentRespository.getDataListPayment();
        try {
          data = paymentShipperModels.data!;
          emit(PaymentShipperState.start(
              true,
              state.status,
              paymentShipperModels.total!,
              data,
              confirmPaymentModels.success ?? false,
              confirmPaymentModels.message ?? ''));
        } catch (e) {
          emit(PaymentShipperState.fail(confirmPaymentModels.message!));
        }
      }
    });
  }
}
