import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/home/home_screen.dart';

import '../../Shared/blocs/theme/color.dart';

class ConnectOffPage extends StatefulWidget {
  @override
  _ConnectOffPageState createState() => _ConnectOffPageState();
}

class _ConnectOffPageState extends State<ConnectOffPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkConect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // NavigatorUtils.pushReplacementNamed(context, routeName: ROUTE_HOME);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // NavigatorUtils.pushReplacementNamed(context, routeName: ROUTE_HOME);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Text('Thiết bị vẫn chưa kết nối internet!'),
                const Text(
                    'Bạn vui lòng kiểm tra kết nối wifi hoặc mạng di động.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.gray_bacground,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_lock,
                    color: Colors.grey[500],
                    size: 50.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text('Vui lòng kiểm tra lại kết nối internet của thiết bị!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[500])),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    onPressed: () => checkConect(),
                    child: Text('Tải lại trang',
                        style: TextStyle(color: Colors.grey[600])),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
