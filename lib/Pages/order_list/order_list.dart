import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_list/widgets/order_list_total.dart';
import 'package:flutter_app_best_shipp/Shared/models/order_list/order_list_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/endData.dart';
import '../../Shared/widgets/base_widget/loadingIndicator.dart';
import '../../Shared/widgets/base_widget/custom_appbar.dart';
import '../order_widgets_shared/order_item.dart';
import 'bloc/order_list_bloc.dart';
import 'bloc/order_list_state.dart';

class OrderList extends StatefulWidget {
  final String title;

  const OrderList({super.key, required this.title});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final scrollController = ScrollController();
  List<OrderModels> dataJson = [];
  int total = 0;
  bool isLoading = false;
  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<OrderListBloc>(context).loadPosts();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupScrollController(context);
    BlocProvider.of<OrderListBloc>(context).loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: CustomAppbar(title: widget.title)),
      body: buildList(),
    );
  }

  Widget buildList() {
    return BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
      if (state is OrderListGetDataEvent && state.isLoading) {
        return loadingIndicator();
      }
      // loadmore -> có data
      if (state is OrderListGetDataEvent) {
        dataJson = state.getData;
        isLoading = true;
      }
      // data khởi tạo
      else if (state is OrderListLoadingEvent) {
        dataJson = state.data;
        total = state.totalOrder;
      }
      return RefreshIndicator(
          color: fromHexColor(Constants.COLOR_BUTTON),
          backgroundColor: Colors.white,
          onRefresh: () async => context.read<OrderListBloc>().loadPosts(),
          child: Column(children: [
            OrderScanFailTotal(
              total: total,
            ),
            Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      if (index < dataJson.length) {
                        // ignore: curly_braces_in_flow_control_structures
                        return OrderShareItem(
                          data: dataJson[index],
                          isActiveStatus: false,
                        );
                      } else {
                        Timer(const Duration(milliseconds: 10), () {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                        var data = (total == dataJson.length)
                            ? endData()
                            : loadingIndicator();
                        Future.delayed(const Duration(seconds: 10), () async {
                          data;
                        });
                        return data;
                      }
                    },
                    itemCount: dataJson.length + (isLoading ? 1 : 0)))
            // (widget.totalOrder == posts.length) ? endData() : const SizedBox()
          ]));
    });
  }
}
