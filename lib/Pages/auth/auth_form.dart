import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/auth/widgets/authentication/auth_button_confirm.dart';
import 'package:flutter_app_best_shipp/Pages/auth/widgets/authentication/auth_check_remember.dart';
import 'package:flutter_app_best_shipp/Pages/auth/widgets/authentication/auth_textfield_account.dart';
import 'package:flutter_app_best_shipp/Pages/auth/widgets/authentication/auth_textfield_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/blocs/theme/color.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/snackbar_loading.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/login/login_bloc.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // final TextEditingController _userNameController =
  //     TextEditingController(text: 'locxipo');
  // final TextEditingController _passwordController =
  //     TextEditingController(text: 'admin@114');
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isPopulated =>
      _userNameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;
  // check submit
  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool isForgotPasswordEnabled(LoginState state) {
    return state.isUserNameValid && _userNameController.text.isNotEmpty;
  }

  bool _isPasswordHidden = false;
  bool _checkRemmemBer = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _userNameController.addListener(_onUserNameChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[200],
          body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
            if (state.isSuccess) {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLoggedInEvent());
            }
            if (state.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  snackBar_message(state.error.toString(), "error"),
                );
            }
          }, child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            top: (isKeyboardShowing == true) ? 5 : 40),
                        child: Column(children: [
                          Image.asset('assets/images/Bestship_logo.png',
                              height: 100, width: 150),
                          Center(
                              // ignore: prefer_const_literals_to_create_immutables
                              child: Column(children: [
                            const Text('Bestship ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 28, color: Colours.textDefault)),
                            const Text(
                                'Dịch vụ giao hàng tốt nhất dành cho bạn ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colours.textDefault))
                          ]))
                        ])),
                    const SizedBox(height: 30),
                    Container(
                        height: 370,
                        width: double.infinity,
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0))),
                        child: Form(
                            key: _formKey,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 50),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text('Tài khoản',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black)),
                                      const SizedBox(height: 10),
                                      AuthTextFieldAccount(
                                          hintText: 'Vui lòng nhập (*)',
                                          myController: _userNameController,
                                          validator: (_) =>
                                              !state.isUserNameValid
                                                  ? 'Vui lòng nhập tài khoản.'
                                                  : null),
                                      const SizedBox(height: 10),
                                      const Text('Mật khẩu',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black)),
                                      const SizedBox(height: 10),
                                      AuthTextFieldPassword(
                                          hintText: 'Vui lòng nhập (*)',
                                          check: _isPasswordHidden,
                                          onpress: () {
                                            _toggleVisibility();
                                          },
                                          myControllers: _passwordController,
                                          ispass: _isPasswordHidden,
                                          validator: (_) =>
                                              !state.isPasswordValid
                                                  ? 'Vui lòng nhập mật khẩu'
                                                  : null),
                                      AuthCheckRememberMe(
                                          title: 'Nhớ mật khẩu',
                                          checkValue: _checkRemmemBer,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _checkRemmemBer = value!;
                                            });
                                          }),
                                      AuthButtonConfirm(
                                        isSubmitting: state.isSubmitting,
                                        title: 'Đăng nhập',
                                        onTap: isLoginButtonEnabled(state)
                                            ? _onFormSubmitted
                                            : null,
                                        color: fromHexColor(
                                            Constants.COLOR_BUTTON),
                                        width: size.width,
                                      )
                                    ]))))
                  ]);
            },
          ))),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUserNameChanged() {
    _loginBloc.add(UserNameChangedEvent(username: _userNameController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChangedEvent(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressedEvent(
        username: _userNameController.text,
        password: _passwordController.text));
  }
}
