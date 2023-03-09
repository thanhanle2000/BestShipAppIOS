import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/bloc/payment_shipper_detail_state.dart';
import 'package:flutter_app_best_shipp/Pages/order_widgets_shared/order_item_details.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/widgets/widget_header/payment_shipper_details_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/custom_appbar.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import 'bloc/payment_shipper_detail_bloc.dart';
import 'bloc/payment_shipper_detail_event.dart';

class PaymentShipperDetails extends StatefulWidget {
  const PaymentShipperDetails({super.key});

  @override
  State<PaymentShipperDetails> createState() => _PaymentShipperDetailsState();
}

class _PaymentShipperDetailsState extends State<PaymentShipperDetails> {
  late PaymentShipperDetailsBloc paymentBloc;
  @override
  void initState() {
    super.initState();
    paymentBloc = context.read<PaymentShipperDetailsBloc>();
    paymentBloc.add(PaymentShipperDetailsStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[100],
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: CustomAppbar(title: 'Chi tiết danh sách thanh toán')),
        body: BlocListener<PaymentShipperDetailsBloc,
            PaymentShipperDetailsState>(listener: (context, state) {
          // Bật loading khi tải map
          if (!state.success) {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: fromHexColor(Constants.COLOR_BUTTON)));
                });
          } else {
            Navigator.of(context).pop();
          }
          if (state.status == 'fail') {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                snackBar_message('Không có dữ liệu.', "warning"),
              );
          }
        }, child:
            BlocBuilder<PaymentShipperDetailsBloc, PaymentShipperDetailsState>(
                builder: (context, state) {
          return Column(
            children: [
              PaymentShipperDetailsHeader(data: state.paymentShip),
              Expanded(
                child: RefreshIndicator(
                    color: fromHexColor(Constants.COLOR_BUTTON),
                    backgroundColor: Colors.white,
                    onRefresh: () async =>
                        paymentBloc.add(PaymentShipperDetailsStartedEvent()),
                    child: OrderItemDetails(orderModel: state.orderModel)),
              )
            ],
          );
        })));
  }
}
