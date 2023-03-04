import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_body.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_confirm.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/payment_shipper_detail_screen.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';
import 'package:flutter_app_best_shipp/Shared/models/payment/payment_shipper_models.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/payment/payment_respository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../Shared/constants/constants.dart';
import '../bloc/payment_shipper_bloc.dart';
import '../bloc/payment_shipper_bloc_event.dart';

class PaymentShipperItem extends StatefulWidget {
  final PaymentModels data;
  final PaymentShipperBloc paymentBloc;
  final BuildContext contextBloc;
  const PaymentShipperItem(
      {super.key,
      required this.data,
      required this.paymentBloc,
      required this.contextBloc});

  @override
  State<PaymentShipperItem> createState() => _PaymentShipperItemState();
}

class _PaymentShipperItemState extends State<PaymentShipperItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentShipperDetailScreen(
                      paymentRespository:
                          PaymentRespository(PaymentId: widget.data.id!))));
        },
        child: !widget.data.isConfirm!
            ? Slidable(
                endActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                          backgroundColor: Colors.green,
                          label: 'Xác nhận',
                          icon: Icons.done,
                          onPressed: ((context) async {
                            showdialogconfirm(
                                widget.paymentBloc, widget.contextBloc);
                          }))
                    ]),
                child: PaymentShipperBody(data: widget.data),
              )
            : PaymentShipperBody(data: widget.data));
  }

  Future<void> showdialogconfirm(
      PaymentShipperBloc paymentBloc, BuildContext contextBloc) async {
    await showDialog(
        context: contextBloc,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              actions: [
                Column(children: [
                  const Center(
                      child: Text('Xác nhận đã thanh toán',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colours.textDefault,
                              fontWeight: FontWeight.bold))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PaymentShipperConfirm(
                            lr: 10,
                            onpress: () async {
                              await getConfirmPayment(
                                  widget.data.id!, contextBloc);
                            },
                            colorString: Constants.COLOR_BUTTON,
                            title: 'Xác nhận'),
                        PaymentShipperConfirm(
                            lr: 25,
                            onpress: () {
                              Navigator.pop(context);
                            },
                            colorString: Constants.COLOR_APPBAR,
                            title: 'Đóng')
                      ])
                ])
              ]);
        });
  }

  // hàm xử lí xác nhận đã thanh toán
  // ignore: body_might_complete_normally_nullable
  Future<void>? getConfirmPayment(int PaymentID, BuildContext contextBloc) {
    widget.paymentBloc.add(PaymentShipperConfirmEvent(
        paymentBloc: widget.paymentBloc,
        PaymentId: PaymentID,
        context: contextBloc));
  }
}
