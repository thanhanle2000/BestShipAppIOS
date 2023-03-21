import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/auth/tag_key/tagkeyword.dart';
import '../../payment_shipper/widgets/payment_shipper_confirm.dart';
import '../bloc/order_process_bloc.dart';
import '../bloc/order_process_event.dart';

class OrderProcessEventSatus extends StatefulWidget {
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  final Function(List<String>) titleStatus;
  final List<int> numberCheck;

  const OrderProcessEventSatus(
      {super.key,
      required this.orderBloc,
      required this.blocContext,
      required this.titleStatus,
      required this.numberCheck});

  @override
  State<OrderProcessEventSatus> createState() => _OrderProcessEventSatusState();
}

class _OrderProcessEventSatusState extends State<OrderProcessEventSatus> {
  final List<int> number = [];
  late List<int> numberLst = [];
  final List<String> alltitle = [];
  late List<String> lstTitle = [];
  int numberItem = 10;
  final allChecked = ListStatusEvent(title: 'Tất cả trạng thái', id: 0);
  var listCheckBox = [
    ListStatusEvent(title: 'Mới', id: 1),
    ListStatusEvent(title: 'Đang lấy hàng', id: 2),
    ListStatusEvent(title: 'Đã lấy hàng', id: 3),
    ListStatusEvent(title: 'Đang giao hàng', id: 4),
    ListStatusEvent(title: 'Giao thành công', id: 5),
    ListStatusEvent(title: 'Khách hàng hủy', id: 6),
    ListStatusEvent(title: 'Trả hàng Shop', id: 7),
    ListStatusEvent(title: 'Lưu kho', id: 8)
  ];

  @override
  void initState() {
    super.initState();
    processCheckFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(children: [
      Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: const Border(
                  top: BorderSide(width: 1, color: Colours.textDefault))),
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: const Text('Chọn trạng thái lọc',
              style: TextStyle(fontSize: 18, color: Colours.classicText))),
      ListTile(
          onTap: () => onClicked(allChecked, "checkAll"),
          leading: Checkbox(
            value: allChecked.value,
            onChanged: (value) => onClicked(allChecked, "checkAll"),
          ),
          title: Text('${allChecked.title}',
              style:
                  const TextStyle(fontSize: 15, color: Colours.classicText))),
      ...listCheckBox.map((e) => ListTile(
          onTap: () => onClicked(e, "checkItem"),
          leading: Checkbox(
            value: e.value,
            onChanged: (value) => onClicked(e, "checkItem"),
          ),
          title: Text('${e.title}',
              style:
                  const TextStyle(fontSize: 15, color: Colours.classicText)))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        PaymentShipperConfirm(
            onpress: () async {
              await getFilterStatus(
                  (numberLst == [0, 8]) ? [0] : numberLst, widget.blocContext);
              widget.titleStatus(alltitle.isEmpty ? lstTitle : alltitle);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            title: 'Xác nhận',
            colorString: Constants.COLOR_BUTTON,
            lr: 10),
        PaymentShipperConfirm(
            onpress: () => Navigator.pop(context),
            title: 'Đóng',
            colorString: Constants.COLOR_APPBAR,
            lr: 20)
      ])
    ]));
  }

  // lọc theo trạng thái
  // ignore: body_might_complete_normally_nullable
  Future<void>? getFilterStatus(List<int> number, BuildContext contextbloc) {
    widget.orderBloc.add(OrderProcessFilterStatusEvent(
        orderStatus: number,
        blocContext: contextbloc,
        processBloc: widget.orderBloc));
  }

  // xử lí ontap cho all list
  onClicked(ListStatusEvent cbItem, String type) {
    if (type == 'checkAll') {
      // Xử lý check all
      if (cbItem.value == false) {
        alltitle.add(cbItem.title!);
      } else {
        alltitle.clear();
      }
      var newValue = !cbItem.value!;

      setState(() {
        cbItem.value = !cbItem.value!;
        for (var element in listCheckBox) {
          element.value = newValue;
        }
      });
    } else {
      // Xử lý từng item
      if (numberLst.isEmpty) {
        numberLst.add(cbItem.id!);
        lstTitle.add(cbItem.title!);
      } else {
        var idDulicate =
            numberLst.where((element) => element == cbItem.id).isEmpty;
        if (!idDulicate) {
          numberLst.remove(cbItem.id);
          lstTitle.remove(cbItem.title);
        } else {
          numberLst.add(cbItem.id!);
          lstTitle.add(cbItem.title!);
        }
      }

      setState(() {
        cbItem.value = !cbItem.value!;
      });
    }
  }

  processCheckFirst() {
    var lstCBCurrent = <ListStatusEvent>[];
    if (widget.numberCheck.isNotEmpty) {
      numberLst = widget.numberCheck;
      for (var item in listCheckBox) {
        var it =
            widget.numberCheck.where((element) => element == item.id).isEmpty;
        if (!it) {
          item.value = true;
          lstTitle.add(item.title!);
        }
        lstCBCurrent.add(item);
      }
      listCheckBox = lstCBCurrent;
    }
  }
}
