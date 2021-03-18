import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/apis/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'order_event.dart';
part 'order_state.dart';

// ignore_for_file: close_sinks
// ignore_for_file: non_constant_identifier_names

class OrderListBloc extends Bloc<OrderEvent, OrderListState> {
  final BuildContext context;

  OrderListBloc(this.context) : super(OrderListState.initial());

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Stream<OrderListState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is RefreshOrderList) {
      yield await RestService.instance.getOrders(query: {
        'pageNo': 1,
        'pageSize': state.pageSize,
        'sorter': '-id'
      }).then<OrderListState>((value) {
        refreshController.refreshCompleted();
        return state.copyWith(
            list: value.data ?? [], pageNo: 2, totalCount: value.totalCount);
      }).catchError((onError) {
        refreshController.refreshFailed();
        return state.copyWith(list: [], pageNo: 1, totalCount: 0);
      });
    }

    if (event is LoadOrderList) {
      if (state.list.length < state.totalCount) {
        yield await RestService.instance.getOrders(query: {
          'pageNo': state.pageNo,
          'pageSize': state.pageSize,
          'sorter': '-id'
        }).then<OrderListState>((value) {
          refreshController.loadComplete();
          return state.copyWith(
              list: state.list + value.data,
              pageNo: state.pageNo + 1,
              totalCount: value.totalCount);
        }).catchError((onError) {
          refreshController.refreshFailed();
          return state;
        });
      } else {
        refreshController.loadComplete();
      }
    }
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  OrderBloc() : super(OrderState.initial());

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is RefreshOrder) {
      yield await RestService.instance
          .getOrder('${event.id}')
          .then<OrderState>((value) {
        refreshController.refreshCompleted();
        return state.copyWith(order: value);
      }).catchError((onError) {
        refreshController.refreshFailed();
      });
    }
  }
}

class DropDownData extends Equatable {
  final int service;
  final int main;
  final int sub;

  DropDownData({this.service, this.main, this.sub});

  static generateMain({int service, int length}) {
    return List<DropDownData>.generate(
        length, (index) => DropDownData(service: service, main: index++));
  }

  static generateSub({int service, int main, int length}) {
    return List<DropDownData>.generate(length,
        (index) => DropDownData(service: service, main: main, sub: index++));
  }

  @override
  List<Object> get props => [service, main, sub];
}

class OrderFormBloc extends FormBloc<String, String> {
  final BuildContext context;

  SelectFieldBloc status;
  SelectFieldBloc service;

  SelectFieldBloc<DropDownData, Object> main_info;
  SelectFieldBloc<DropDownData, Object> sub_info;

  InputFieldBloc<DateTime, Object> from_date;
  InputFieldBloc<DateTime, Object> to_date;

  TextFieldBloc code;
  TextFieldBloc lat;
  TextFieldBloc lng;
  // TextFieldBloc address;
  InputFieldBloc<Address, Object> address;
  bool nextStep;

  Order data;

  OrderFormBloc(this.context, this.data, bool post) {
    status =
        SelectFieldBloc(items: [0, 1, 2, 3, 4, 5], initialValue: data.status);
    service = SelectFieldBloc(items: [0, 1, 2, 3, 4, 5], initialValue: data.service);
    main_info = SelectFieldBloc(
        items: DropDownData.generateMain(
            service: data.service,
            length: Localization.of(context).mainInfo[data.service].length),
        initialValue:
            DropDownData(service: data.service, main: data.main_info));
    sub_info = SelectFieldBloc(
        items: DropDownData.generateSub(
            service: data.service,
            main: data.main_info,
            length: Localization.of(context)
                .subInfo[data.service][data.main_info]
                .length),
        initialValue: DropDownData(
            service: data.service, main: data.main_info, sub: data.sub_info));

    from_date = InputFieldBloc<DateTime, Object>(
        initialValue:
            data.from_date != null ? DateTime.parse(data.from_date) : null);
    to_date = InputFieldBloc<DateTime, Object>(
        initialValue:
            data.to_date != null ? DateTime.parse(data.to_date) : null);
    code = TextFieldBloc(initialValue: '${data.code ?? ''}');
    // address = TextFieldBloc(initialValue: '${data.address ?? ''}');
    address =
        InputFieldBloc(initialValue: Address(address: '${data.address ?? ''}'));
    lat = TextFieldBloc(initialValue: data?.lat?.toString());
    lng = TextFieldBloc(initialValue: data?.lng?.toString());
    nextStep = false;

    addFieldBlocs(fieldBlocs: [
      status,
      service,
      main_info,
      sub_info,
      from_date,
      to_date,
      code,
      address,
    ]);

    addValidators();

    if (post) {
      addListen();
    }
  }

  void addListen() {
    service
      ..listen((value) async {
        if (value != null && value.value != null) {
          main_info.updateValue(DropDownData(service: value.value, main: data.main_info));
          sub_info
              .updateValue(DropDownData(service: value.value, main: data.main_info, sub: data.sub_info));

          main_info.updateItems(DropDownData.generateMain(
              service: value.value,
              length: Localization.of(context).mainInfo[value.value].length));

          sub_info.updateItems(DropDownData.generateSub(
              service: value.value,
              main: 0,
              length: Localization.of(context).subInfo[value.value][0].length));
        }
      });

    main_info
      ..listen((value) async {
        if (value != null && value.value != null) {
          sub_info.updateValue(DropDownData(
              service: service.value, main: value.value.main, sub: data.sub_info));

          sub_info.updateItems(DropDownData.generateSub(
              service: service.value,
              main: value.value.main,
              length: Localization.of(context)
                  .subInfo[service.value][value.value.main]
                  .length));
        }
      });

    sub_info
      ..listen((value) async {
        if (value != null && value.value != null) {
          if (Localization.of(context)
                      .subInfo[value.value.service][value.value.main]
                      .length -
                  1 ==
              value.value.sub) {
            nextStep = true;
          } else {
            nextStep = false;
          }
        }
      });
  }

  void addValidators() {
    from_date.addValidators([
      RequiredDateTimeValidator(
          errorText: Localization.of(context).requiredString)
    ]);
    to_date.addValidators([
      RequiredDateTimeValidator(
          errorText: Localization.of(context).requiredString)
    ]);
    address.addValidators([
      RequiredAddressValidator(
          errorText: Localization.of(context).requiredString)
    ]);
  }

  void addErrors(Map<String, dynamic> errors) {
    if (errors == null) {
      return;
    }

    status.addFieldError(errors['status']);
    service.addFieldError(errors['service']);
    address.addFieldError(errors['address']);
    from_date.addFieldError(errors['from_date']);
    to_date.addFieldError(errors['from_date'] ?? errors['non_field_errors']);
  }

  @override
  void onSubmitting() {
    RestService.instance.postOrder({
      'service': service.value,
      'main_info': main_info.value.main,
      'sub_info': sub_info.value.sub,
      'address': address.value.address ?? address.value.toTitle,
      'lat': lat.valueToDouble,
      'lng': lat.valueToDouble,
      'from_date': DateFormat('yyyy-MM-dd HH:mm:ss').format(from_date.value),
      'to_date': DateFormat('yyyy-MM-dd HH:mm:ss').format(to_date.value)
    }).then((value) {
      data = value;
      emitSuccess(canSubmitAgain: true);
    }).catchError((onError) {
      emitFailure();
      addErrors(onError?.response?.data);
    });
  }
}

class RequiredDateTimeValidator extends FieldValidator<DateTime> {
  RequiredDateTimeValidator({@required String errorText}) : super(errorText);

  @override
  // ignore: override_on_non_overriding_member
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(DateTime value) {
    return value != null;
  }

  @override
  String call(DateTime value) {
    return isValid(value) ? null : errorText;
  }
}

class RequiredAddressValidator extends FieldValidator<Address> {
  RequiredAddressValidator({@required String errorText}) : super(errorText);

  @override
  // ignore: override_on_non_overriding_member
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(Address value) {
    return value != null;
  }

  @override
  String call(Address value) {
    return isValid(value) ? null : errorText;
  }
}
