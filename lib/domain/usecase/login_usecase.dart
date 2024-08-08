import 'package:dartz/dartz.dart';
import 'package:initial/app/functions.dart';
import 'package:initial/data/network/failure.dart';
import 'package:initial/data/request/request.dart';
import 'package:initial/domain/model/model.dart';
import 'package:initial/domain/repository/repository.dart';
import 'package:initial/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUsecase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(
      LoginRequest(
        input.email,
        input.password,
        deviceInfo.identifier,
        deviceInfo.name,
      ),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
