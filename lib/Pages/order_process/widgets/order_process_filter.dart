import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/order_process_filter_change.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/order_process_status.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import '../../../Shared/models/order_scan/order_scan_list_shop.dart';
import '../../../Shared/widgets/base_widget/modal_bottom_sheet.dart';
import '../../order_scan/widgets/order_list_textfield_shop.dart';
import '../../order_scan/widgets/order_scan_list_item.dart';
import '../bloc/order_process_event.dart';
import 'order_process_date_range.dart';

class OrderProcessFilter extends StatefulWidget {
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  final List<int> number;
  final List<DataListShop> dataListShop;
  final bool isCheck;
  const OrderProcessFilter(
      {super.key,
      required this.orderBloc,
      required this.dataListShop,
      required this.blocContext,
      required this.number,
      required this.isCheck});

  @override
  State<OrderProcessFilter> createState() => _OrderProcessFilterState();
}

class _OrderProcessFilterState extends State<OrderProcessFilter> {
  final TextEditingController _shopController = TextEditingController();
  String titleShop = '';
  String dateNow = '';
  List<String> titlteStatus = [];
  @override
  void initState() {
    super.initState();
    getListShop('');
  }

  getDate(String date) {
    setState(() {
      dateNow = date;
    });
  }

  getTitleStatus(List<String> title) {
    setState(() {
      titlteStatus = title;
    });
  }

  // Hàm lấy danh sách shop
  // ignore: body_might_complete_normally_nullable
  Future<void>? getListShop(String key) {
    widget.orderBloc.add(OrderProcessKeyEvent(key: key));
  }

  // sự kiện lọc theo shop
  // ignore: body_might_complete_normally_nullable
  Future<void>? getFilterShop(int shopId, BuildContext context) {
    widget.orderBloc.add(OrderProcessFilterShopIdEvent(
        shopId: shopId, blocContext: context, processBloc: widget.orderBloc));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 35) / 2.8;
    final double itemWidth = size.width / 2;
    final double itemHeightDate = (size.height - kToolbarHeight - 35) / 2.3;
    final double itemWidthDate = size.width / 2;
    return Row(
      children: [
        OrderProcessFilterChange(
          title: IsNullOrEmpty(titleShop) ? 'Shop' : titleShop,
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 500), () async {
              await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ModalBottomSheet(
                      title: '',
                      height: (itemWidth / itemHeight),
                      HasTitle: false,
                      UI: Expanded(
                          child: Column(children: [
                        OrderListTextFieldShop(
                            controller: _shopController,
                            iconfx: Icons.clear,
                            onpress: () async {
                              _shopController.clear();
                              await getListShop('');
                            },
                            title: 'Nhập vào Shop cần tìm',
                            icon: Icons.search_rounded,
                            onchanged: (value) async {
                              await getListShop(value);
                            }),
                        Expanded(
                            child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: widget.dataListShop.length,
                                    itemBuilder: (c, i) {
                                      var e = widget.dataListShop[i];
                                      return OrderScanListItem(
                                        onTap: () async {
                                          setState(() {
                                            titleShop = e.name!;
                                            getFilterShop(
                                                e.id!, widget.blocContext);
                                            Navigator.pop(context);
                                          });
                                        },
                                        name: e.name!,
                                      );
                                    })))
                      ]))));
            });
          },
          color: Colors.grey[200]!,
          padleft: 5,
          colorText: (IsNullOrEmpty(titleShop) || widget.isCheck == true)
              ? Colors.grey[600]!
              : fromHexColor(Constants.COLOR_BUTTON),
          colorIcon: (IsNullOrEmpty(titleShop) || widget.isCheck == true)
              ? Colors.grey[600]!
              : fromHexColor(Constants.COLOR_BUTTON),
          iconData: Icons.shopping_cart,
        ),
        OrderProcessFilterChange(
          title: IsNullOrEmpty(dateNow) ? 'Ngày' : dateNow,
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 100), () async {
              await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ModalBottomSheet(
                      title: '',
                      height: (itemWidthDate / itemHeightDate),
                      HasTitle: false,
                      UI: OrderProcessDateRange(
                        date: getDate,
                        orderBloc: widget.orderBloc,
                        blocContext: widget.blocContext,
                      )));
            });
          },
          colorText: (IsNullOrEmpty(dateNow) || widget.isCheck == true)
              ? Colors.grey[600]!
              : fromHexColor(Constants.COLOR_BUTTON),
          color: Colors.grey[100]!,
          colorIcon: (IsNullOrEmpty(dateNow) || widget.isCheck == true)
              ? Colors.grey[600]!
              : fromHexColor(Constants.COLOR_BUTTON),
          padleft: 5,
          iconData: Icons.date_range_rounded,
        ),
        OrderProcessFilterChange(
          title: titlteStatus.isEmpty ? 'Trạng thái' : titlteStatus.toString(),
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 100), () async {
              await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ModalBottomSheet(
                      title: '',
                      height: (itemWidth / itemHeight),
                      HasTitle: false,
                      UI: OrderProcessEventSatus(
                        numberCheck: widget.number,
                        orderBloc: widget.orderBloc,
                        blocContext: widget.blocContext,
                        titleStatus: getTitleStatus,
                      )));
            });
          },
          colorText: (titlteStatus.isEmpty || widget.isCheck == true)
              ? Colors.grey[600]!
              : fromHexColor(Constants.COLOR_BUTTON),
          color: Colors.grey[50]!,
          colorIcon: (titlteStatus.isEmpty || widget.isCheck == true)
              ? Colors.grey[600]!
              : fromHexColor(Constants.COLOR_BUTTON),
          padleft: 5,
          iconData: Icons.fact_check_rounded,
        ),
      ],
    );
  }
}
