import 'dart:async';

import 'package:initial/domain/usecase/login_usecase.dart';
import 'package:initial/presentation/common/state_renderer/state_renderer.dart';
import 'package:initial/presentation/common/state_renderer/state_renderer_impl.dart';

import '../base/baseViewModel.dart';
import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    //view tells state renderer please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  // TODO: implement inputIsAllInputs
  Sink get inputIsAllInputs => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.userName, loginObject.password),
    ))
        .fold(
            (failure) => {
                  // left->failure
                  print(failure.message),
                  inputState.add(
                    ErrorState(
                        StateRendererType.POPOUP_ERROR_STATE, failure.message),
                  ),
                },
            (data) => {
                  //right ->success(data)
                  print(data.customer?.name),
                  inputState.add(ContentState())
                });
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUsernameValid(userName));

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  //private functions

  _validate() {
    inputIsAllInputs.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.userName);
  }
}

mixin LoginViewModelInputs {
  //three functions
  setUserName(String userName);
  setPassword(String password);
  login();
  //two sinks
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputs;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
