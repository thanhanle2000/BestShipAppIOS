import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Pages/order_list_map/bloc/map_bloc.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/status/status_models.dart';
import 'order_list_map_item.dart';

class OrderListMapDrawer extends StatefulWidget {
  final MapBloc mapBloc;
  final BuildContext context;

  const OrderListMapDrawer(
      {super.key, required this.mapBloc, required this.context});

  @override
  State<OrderListMapDrawer> createState() => _OrderListMapDrawerState();
}

class _OrderListMapDrawerState extends State<OrderListMapDrawer> {
  @override
  void initState() {
    // widget.mapBloc
    //     .add(MapBlocStarted(context: context, mapBloc: widget.mapBloc));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<MapBloc, MapBlocState>(builder: (context, state) {
      return Drawer(
          backgroundColor: Colors.grey[200],
          child: state.orderList != null
              ? Column(children: <Widget>[
                  Container(
                      width: double.infinity,
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text(
                            'Đơn đang giao: ',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                fontSize: 18, color: Colours.textDefault),
                          ),
                          Text(
                            '${state.orderList?.length}',
                            // ignore: prefer_const_constructors
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colours.textDefault,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  Expanded(
                      child: ListView(
                          children: _buildListItem(state.orderList!,
                              state.statusModels!, widget.context)))
                ])
              : const SizedBox());
    }));
  }

  List<Widget> _buildListItem(List<OrderModels> lstdata,
      StatusData statusModels, BuildContext contextMain) {
    List<Widget> _lstWidget = [];
    lstdata.map((item) {
      _lstWidget.add(MapConvertItem(
        data: item,
        statusModels: statusModels,
        contextMain: contextMain,
        mapBloc: widget.mapBloc,
      ));
    }).toList();
    return _lstWidget;
  }
}
