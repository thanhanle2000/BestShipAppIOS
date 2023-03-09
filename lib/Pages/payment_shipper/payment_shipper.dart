import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc_state.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_header.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/endData.dart';
import '../../Shared/widgets/base_widget/custom_appbar.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';

class PaymentShipper extends StatefulWidget {
  const PaymentShipper({super.key});

  @override
  State<PaymentShipper> createState() => _PaymentShipperState();
}

class _PaymentShipperState extends State<PaymentShipper> {
  late PaymentShipperBloc paymentBloc;

  @override
  void initState() {
    super.initState();
    paymentBloc = context.read<PaymentShipperBloc>();
    paymentBloc.add(PaymentShipperStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[100],
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: CustomAppbar(title: 'Danh sách thanh toán')),
        body: BlocListener<PaymentShipperBloc, PaymentShipperState>(
            listener: (context, state) {
          // Bật loading khi tải data
          if (!state.success) {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: fromHexColor(Constants.COLOR_BUTTON)));
                });
          }
          // tắt loading
          else {
            Navigator.of(context).pop();
          }
          // khi không có dữ liệu sẽ trả về message fail
          if (state.status == 'fail') {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                snackBar_message('Không có dữ liệu.', "warning"),
              );
          }
          if (state.successStatus == true) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                snackBar_message(state.messStatus!, "success"),
              );
          }
        }, child: BlocBuilder<PaymentShipperBloc, PaymentShipperState>(
                builder: (context, state) {
          // ignore: unnecessary_null_comparison
          return SizedBox(
              child: Column(children: [
            PaymentShipperHeader(totalPayment: state.total),
            Flexible(
                flex: 1,
                child: RefreshIndicator(
                    color: fromHexColor(Constants.COLOR_BUTTON),
                    backgroundColor: Colors.white,
                    onRefresh: () async =>
                        paymentBloc.add(PaymentShipperStartedEvent()),
                    child: ListView.builder(
                        itemCount: state.data.length + 1,
                        itemBuilder: (c, i) {
                          if (i < state.data.length) {
                            return PaymentShipperItem(
                              data: state.data[i],
                              paymentBloc: paymentBloc,
                              contextBloc: context,
                            );
                          } else {
                            // ignore: unnecessary_null_comparison
                            return state.data == null
                                ? const SizedBox()
                                : endData();
                          }
                        })))
          ]));
        })));
  }
}
