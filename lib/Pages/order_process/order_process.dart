import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/order_process_appbar.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/order_process_filter.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/widgets_action/order_process_slidable_left.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/widgets_action/order_process_slidable_right.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/widgets/widgets_header/order_process_header_report.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/models/auth/auth_models.dart';
import '../../Shared/preferences/preferences.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/endData.dart';
import '../../Shared/widgets/base_widget/loadingIndicator.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import '../order_widgets_shared/order_item.dart';
import 'bloc/order_process_bloc.dart';
import 'bloc/order_process_event.dart';
import 'bloc/order_process_state.dart';

class OrderProcess extends StatefulWidget {
  const OrderProcess({super.key});

  @override
  State<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  final _scrollController = ScrollController();
  late OrderProcessBloc orderBloc;
  String sorts = '';
  String? name = Prefer.prefs?.getString('authenticationViewModel');
  @override
  void initState() {
    super.initState();
    orderBloc = context.read<OrderProcessBloc>();
    orderBloc.add(OrderProcessStartedEvent());
    orderBloc.add(OrderProcessKeyEvent(key: ''));
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45.0),
            child: OrderProcessAppbar(
                title: 'Danh sách đơn hàng',
                orderBloc: orderBloc,
                blocContext: context)),
        body: BlocListener<OrderProcessBloc, OrderProcessState>(
            listener: (context, state) {
          // Bật loading khi tải map
          // ignore: unrelated_type_equality_checks
          if (state.status == "OrderProcessStatus.success") {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: fromHexColor(Constants.COLOR_BUTTON)));
                });
          }
          // Tắt loading khi tải dữ liệu bản đồ thành công
          else {
            // Navigator.of(context).pop();
          }
        }, child: BlocBuilder<OrderProcessBloc, OrderProcessState>(
                builder: (context, state) {
          // ignore: unnecessary_null_comparison
          return state.lstData == null
              ? loadingIndicator()
              : Column(children: [
                  username.userType == 4
                      ? const SizedBox()
                      : OrderProcessFilter(
                          number: state.number,
                          orderBloc: orderBloc,
                          dataListShop: state.dataListShop,
                          blocContext: context,
                          isCheck: state.isCheck),
                  const SizedBox(height: 3),
                  OrderProcessHeaderReport(
                      total: state.data != null ? state.total : 0,
                      totalOth: state.data != null ? state.total_other : 0,
                      totalPro: state.data != null ? state.total_processing : 0,
                      totalSuc: state.data != null ? state.total_succsess : 0,
                      orderBloc: orderBloc,
                      blocContext: context),
                  Expanded(
                      child: RefreshIndicator(
                          color: fromHexColor(Constants.COLOR_BUTTON),
                          backgroundColor: Colors.white,
                          onRefresh: () async {
                            await getStarted(context);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar_message(
                                  'Cập nhật dữ liệu thành công.', "success"));
                          },
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= state.lstData.length) {
                                return (state.total == state.lstData.length
                                    ? endData()
                                    : loadingIndicator());
                              } else {
                                return Slidable(
                                    startActionPane: state.lstData[index]
                                                .baseStatus?.status ==
                                            4
                                        ? ActionPane(
                                            extentRatio: 0.31,
                                            motion: const ScrollMotion(),
                                            children: [
                                                OrderProcessSidableLeft(
                                                    status: state.actionStatus!,
                                                    data: state.lstData[index],
                                                    orderBloc: orderBloc,
                                                    blocContext: context)
                                              ])
                                        : const ActionPane(
                                            motion: ScrollMotion(),
                                            children: []),
                                    endActionPane: state.lstData[index]
                                                .baseStatus?.status ==
                                            4
                                        ? ActionPane(
                                            extentRatio: 0.62,
                                            motion: const ScrollMotion(),
                                            children: [
                                                OrderProcessSidableRight(
                                                    status: state.actionStatus!,
                                                    data: state.lstData[index],
                                                    orderBloc: orderBloc,
                                                    blocContext: context)
                                              ])
                                        : const ActionPane(
                                            motion: ScrollMotion(),
                                            children: []),
                                    child: OrderShareItem(
                                        data: state.lstData[index],
                                        isActiveStatus: false));
                              }
                            },
                            itemCount: state.hasReachedMax
                                ? state.lstData.length
                                : state.lstData.length + 1,
                            controller: _scrollController,
                          )))
                ]);
        })));
  }

  // reload lại trang
  // ignore: body_might_complete_normally_nullable
  Future<void>? getStarted(BuildContext contextBloc) {
    // orderBloc.add(OrderProcessFilterEvent(
    //     endDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    //     startDate: DateFormat('yyyy-MM-dd').format(DateTime(
    //         DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
    //     blocContext: contextBloc,
    //     processBloc: orderBloc,
    //     customerName: '',
    //     customerPhone: '',
    //     orderCode: '',
    //     shopOrderCode: '',
    //     shopId: 0,
    //     orderStatus: const [],
    //     SortType: ''));
    orderBloc.add(OrderProcessStartedEvent());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<OrderProcessBloc>().add(OrderProcessStartedEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
