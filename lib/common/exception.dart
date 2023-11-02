import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

@freezed
abstract class StoreAppException implements Exception, _$StoreAppException {
  factory StoreAppException.noRecords() = NoRecordsException;
  factory StoreAppException.empty(String message) = EmptyException;
  factory StoreAppException.failedToParse() = FailedToParseException;
}
