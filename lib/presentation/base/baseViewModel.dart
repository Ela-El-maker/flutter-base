import 'dart:async';

import 'package:initial/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseviewmodelInputs with BaseviewmodelOutputs {
  // shared variables and functions that will be used through anyview model

  StreamController _inputStateStreamController = StreamController<FlowState>.broadcast();
  
  @override
  // TODO: implement inputState
  Sink get inputState => _inputStateStreamController.sink;


  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState)=>flowState);



  
  
  @override
  void dispose() {
    _inputStateStreamController.close();
  }



}
abstract class BaseviewmodelInputs{
  void start(); // will be called while init. of the view model
  void dispose(); // will be called when viewmodel dies.


Sink get inputState;

}
mixin BaseviewmodelOutputs{
  
  Stream<FlowState> get outputState;
}