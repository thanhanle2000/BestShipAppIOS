import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Shared/constants/constants.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import '../../Shared/utils/app_utils.dart';

class OderItemShop extends StatelessWidget {
  final OrderModels data;
  const OderItemShop({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        !IsNullOrEmpty(data.shopPhone!)
            ? Row(children: [
                GestureDetector(
                    onTap: () async {
                      // ignore: deprecated_member_use
                      launch('tel://${data.shopPhone}'); // phương thức gọi
                    },
                    child: Text(data.shopPhone!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: fromHexColor(Constants.COLOR_APPBAR)))),
                const SizedBox(width: 5),
                GestureDetector(
                    onTap: () {
                      FlutterClipboard.copy(data.shopPhone!);
                      Navigator.pop(context);
                      showNotiCopy(
                          'Bạn vừa copy số điện thoại : ${data.shopPhone}',
                          context);
                    },
                    child: const Icon(Icons.content_copy_outlined, size: 15))
              ])
            : const SizedBox(),
        Text(data.shopName!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: fromHexColor(Constants.COLOR_APPBAR)))
      ]),
    );
  }
}
