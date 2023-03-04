import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/bloc/payment_waiting_list_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/bloc/payment_waiting_list_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/bloc/payment_waiting_list_state.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/widgets/payment_waiting_list_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/custom_appbar.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import '../order_widgets_shared/order_item_details.dart';

class PaymentWaitingList extends StatefulWidget {
  const PaymentWaitingList({super.key});

  @override
  State<PaymentWaitingList> createState() => _PaymentWaitingListState();
}

class _PaymentWaitingListState extends State<PaymentWaitingList> {
  late PaymentWaitingBloc paymentBloc;

  @override
  void initState() {
    super.initState();
    paymentBloc = context.read<PaymentWaitingBloc>();
    paymentBloc.add(PaymentWaitingListStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: CustomAppbar(title: 'Danh sách chờ thanh toán')),
      body: BlocListener<PaymentWaitingBloc, PaymentWaitingListState>(
          listener: (context, state) {
        // Bật loading khi tải map
        if (!state.success) {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                    child: CircularProgressIndicator(
                        color: fromHexColor(Constants.COLOR_BUTTON)));
              });
        }
        if (state.success) {
          Navigator.of(context).pop();
        }
        if (state.status == 'fail') {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              snackBar_message('Không có dữ liệu.', "warning"),
            );
        }
      }, child: BlocBuilder<PaymentWaitingBloc, PaymentWaitingListState>(
              builder: (context, state) {
        return Column(
          children: [
            PaymentWaitingListHeader(data: state.paymentShip),
            Expanded(
                child: RefreshIndicator(
                    color: fromHexColor(Constants.COLOR_BUTTON),
                    backgroundColor: Colors.white,
                    onRefresh: () async =>
                        paymentBloc.add(PaymentWaitingListStartedEvent()),
                    child: OrderItemDetails(orderModel: state.lstOrder)))
          ],
        );
      })),
    );
  }
}
