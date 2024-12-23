import 'dart:async';
import 'package:loadserv_task/common/data/di/app_injector.dart';
import 'package:loadserv_task/common/domain/exceptions/exceptions.dart';
import 'package:loadserv_task/common/domain/exceptions/exceptions.dart';
import 'package:loadserv_task/common/domain/exceptions/status_codes.dart';
import 'package:loadserv_task/common/presentation/utils/network_info.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



Future<void> collect<T>({
  required Future<void> Function() task,
  void Function(String)? onError,
  void Function(dynamic)? catchError,
}) async {
  try {
    await task();
  } on ApiRequestException catch (e) {
    if (e.statusCode == StatusCodes.unauthorizedCode) {
      return;
    }
    if (onError != null && e.errorMessage.isNotEmpty) {
      onError(e.errorMessage);
    }
    if (catchError != null) {
      catchError(e);
    }
  } on ServerException catch (e) {
    if (onError != null) {
      onError("serverError");
    }
    if (catchError != null) {
      catchError(e);
    }
  } on OfflineException catch (e) {
    if (onError != null) {
      onError("offlineFailure");
    }
    if (catchError != null) {
      catchError(e);
    }
  }
}
