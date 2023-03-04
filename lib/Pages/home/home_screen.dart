import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Shared/blocs/theme/color.dart';
import 'widgets/home_appbar.dart';
import '../../Shared/widgets/nav/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // cấp full quyền hệ thống cho ứng dụng lần đầu login thành công
  Future<void> requestPermission() async {
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.phone.request();
    await Permission.storage.request();
    await Permission.notification.request();
    await Permission.calendar.request();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: HomeAppBar(title: 'Trang chủ')),
        // ignore: prefer_const_constructors
        drawer: NavDrawer('/'),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  constraints: const BoxConstraints(
                      minHeight: 200, minWidth: double.infinity),
                  alignment: Alignment.center,
                  child: const Text('Welcome to BestShip',
                      style:
                          TextStyle(fontSize: 18, color: Colours.textDefault)))
            ]));
  }
}
