import 'dart:convert';

import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/bloc/get_income_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/bloc/get_income_state.dart';
import 'package:flutter_app_best_shipp/Shared/models/auth/list_user/list_user_models.dart';
import 'package:flutter_app_best_shipp/Shared/models/payment/income_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../presentation/repositories/payment/payment_respository.dart';
import '../../../presentation/repositories/user/user_repository.dart';

class GetIncomeBloc extends Bloc<GetIncomeEvent, GetIncomeState> {
  final PaymentRespository _paymentRespository;
  final UserRepository _userRepository;

  GetIncomeBloc(
      {required PaymentRespository paymentRespository,
      required UserRepository userRepository})
      // ignore: unnecessary_null_comparison
      : assert(paymentRespository != null, userRepository != null),
        _paymentRespository = paymentRespository,
        _userRepository = userRepository,
        super(GetIncomeState.empty()) {
    on<GetIncomeEvent>((event, emit) async {
      // khai báo dữ liệu ban đầu
      IncomeModels incomeFist = IncomeModels();
      IncomeModels incomeSecond = IncomeModels();
      IncomeModels incomeThird = IncomeModels();
      ListUserModels listUserModels = ListUserModels();
      List<DataUser> dataUser = [];

      Income firstData = Income();
      Income secondData = Income();
      Income thirdData = Income();

      // set ngày
      final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final dateYesterday = DateFormat('yyyy-MM-dd').format(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));
      String? name = Prefer.prefs?.getString('authenticationViewModel');

      final now = DateTime.now();
      var date = DateTime(now.year, now.month, 1).toString();
      var dateParse = DateTime.parse(date);
      var dateFirst = DateFormat('yyyy-MM-dd').format(dateParse);
      if (event is GetIncomeStartedEvent) {
        final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
        emit(GetIncomeState.empty());
        // lấy dữ liệu cho danh sách đợi thanh toán
        incomeFist = await _paymentRespository.getDataIncome(
            username.userName!, dateNow, dateNow);
        incomeSecond = await _paymentRespository.getDataIncome(
            username.userName!, dateYesterday, dateYesterday);
        incomeThird = await _paymentRespository.getDataIncome(
            username.userName!, dateFirst, dateNow);
        try {
          firstData = incomeFist.data!;
          secondData = incomeSecond.data!;
          thirdData = incomeThird.data!;
          emit(GetIncomeState.start(true, "GetIncomeStartedEvent", firstData,
              secondData, thirdData, dataUser));
        } catch (e) {
          emit(GetIncomeState.fail('Không có dữ liệu'));
        }
      } else if (event is GetIncomeListUserEvent) {
        emit(GetIncomeState.empty());
        listUserModels = await _userRepository
            .listDataUser(event.key.isNotEmpty ? event.key : '');
        dataUser = listUserModels.data!;
        emit(GetIncomeState.start(true, "GetIncomeListUserEvent", firstData,
            secondData, thirdData, dataUser));
      } else if (event is GetIncomeReloadEvent) {
        emit(GetIncomeState.empty());
        // lấy dữ liệu cho danh sách đợi thanh toán
        incomeFist = await _paymentRespository.getDataIncome(
            event.key, dateNow, dateNow);
        incomeSecond = await _paymentRespository.getDataIncome(
            event.key, dateYesterday, dateYesterday);
        incomeThird = await _paymentRespository.getDataIncome(
            event.key, dateFirst, dateNow);
        firstData = incomeFist.data!;
        secondData = incomeSecond.data!;
        thirdData = incomeThird.data!;
        emit(GetIncomeState.start(true, "GetIncomeStartedEvent", firstData,
            secondData, thirdData, dataUser));
      }
    });
  }
}
