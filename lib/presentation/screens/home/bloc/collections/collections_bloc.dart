import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/store_models/products/product_collection.dart';

import '../../../../../domain/usecase/retrieve_collections_usecase.dart';

part 'collections_event.dart';
part 'collections_state.dart';
part 'collections_bloc.freezed.dart';
@injectable
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  CollectionsBloc(this._usecase) : super(const _Loading()) {
    on<_RetrieveCollections>((event, emit) async {
      final result = await _usecase(queryParameters: event.queryParameters);
      result.when((collections) => emit(_Loaded(collections)), (error) => emit(_Error(error.message)));
    });
  }

  final RetrieveCollectionsUsecase _usecase;
}
