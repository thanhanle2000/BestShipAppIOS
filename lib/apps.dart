import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/connect/bloc/conect_bloc.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Pages/auth/auth_screen.dart';
import 'Pages/auth/bloc/authentication/authentication_bloc.dart';
import 'Pages/home/home_screen.dart';
import 'Pages/splash_screen/splash_screen.dart';
import 'Shared/blocs/theme/app_theme.dart';
import 'Shared/blocs/theme/theme_bloc.dart';

class Apps extends StatefulWidget {
  final UserRepository userRepository;
  const Apps({super.key, required this.userRepository});

  @override
  State<StatefulWidget> createState() => AppsState();
}

class AppsState extends State<Apps> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();

    // Kiểm tra lại trạng thái đăng nhập
    _authenticationBloc = context.read<AuthenticationBloc>();

    // AuthenticationBloc(userRepository: widget.userRepository);

    // Vào màn hình chờ khoảng 3s
    Future.delayed(const Duration(seconds: 3), () async {
      _authenticationBloc.add(AuthenticationStartedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ConectBloc>(create: (context) => ConectBloc()),
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc())
    ], child: _buildWithTheme(context));
  }

  Widget _buildWithTheme(BuildContext context) {
    return BlocBuilder<ThemeBloc, AppTheme>(builder: (context, appTheme) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HVNet Advanced Apps',
          theme: appThemeData[appTheme],
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationInitial) {
                  // ignore: prefer_const_constructors
                  return SplashScreen();
                }
                if (state is AuthenticationFailure) {
                  return AuthScreen(userRepository: widget.userRepository);
                }
                if (state is AuthenticationSuccess) {
                  return const HomeScreen();
                }
                // ignore: prefer_const_constructors
                return SplashScreen();
              });
            }
            // '/map': (context) => OrderListMapPage(
            //     mapRepository: MapRepository(),
            //     orderRespository: OrderRespository()),
          });
    });
  }
}
