import 'dart:ffi';

import 'package:initial/domain/model/model.dart';
import 'package:initial/domain/usecase/store_details_usecase.dart';
import 'package:initial/presentation/base/baseviewmodel.dart';
import 'package:initial/presentation/common/state_renderer/state_render_impl.dart';
import 'package:initial/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await storeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
