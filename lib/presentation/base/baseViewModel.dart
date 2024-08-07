abstract class BaseViewModel extends BaseviewmodelInputs with BaseviewmodelOutputs {
  // shared variables and functions that will be used through anyview model

}
abstract class BaseviewmodelInputs{
  void start(); // will be called while init. of the view model
  void dispose(); // will be called when viewmodel dies.

}
mixin BaseviewmodelOutputs{
  
}