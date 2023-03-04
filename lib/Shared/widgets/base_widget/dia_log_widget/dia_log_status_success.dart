// import 'package:flutter/material.dart';

// import '../../../blocs/theme/color.dart';
// import '../../../constants/constants.dart';
// import '../../../models/order_list/order_list_models.dart';
// import '../../../utils/app_utils.dart';
// import '../button_confirm.dart';

// class DiaLogStatus {
//   // chuyển đổi trạng thái thành công
//   void showdiasuccess(BuildContext context, Order_Models data) async {
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8.0))),
//               actions: [
//                 SizedBox(
//                     height: 90,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Chuyển đơn thành công',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colours.textDefault,
//                                   fontWeight: FontWeight.bold)),
//                           Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 10, right: 10),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     ButtonConfirm(
//                                       title: 'Xác nhận',
//                                       onpress: () async {
//                                         // await GetOrderSuccsess(data.shopId,
//                                         //     data.orderCode, data.shipper);
//                                         // showInSnackBar(model, context);
//                                         Navigator.pop(context);
//                                       },
//                                       color:
//                                           fromHexColor(Constants.COLOR_BUTTON),
//                                     ),
//                                     const SizedBox(width: 20),
//                                     ButtonConfirm(
//                                         title: 'Hủy bỏ',
//                                         onpress: () => Navigator.pop(context),
//                                         color: fromHexColor(
//                                             Constants.COLOR_APPBAR))
//                                   ]))
//                         ]))
//               ]);
//         });
//   }

//   void showInSnackBar(BuildContext context, Order_Models data) {
//     // ignore: unnecessary_new
//     ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//         elevation: 0,
//         backgroundColor: data.baseStatus?.status != 2
//             ? Colors.greenAccent
//             : Colors.redAccent,
//         duration: const Duration(seconds: 3),
//         // ignore: unnecessary_new
//         content: SizedBox(
//             height: 30.0,
//             child: Text('${data.baseStatus?.name}',
//                 style: const TextStyle(
//                     color: Colours.textDefault, fontSize: 16)))));
//   }
// }
