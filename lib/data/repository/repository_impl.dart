import 'package:dartz/dartz.dart';
import 'package:initial/data/data_source/remote_data_source.dart';
import 'package:initial/data/mapper/mapper.dart';
import 'package:initial/data/network/error_handler.dart';
import 'package:initial/data/network/failure.dart';
import 'package:initial/data/network/network_info.dart';
import 'package:initial/data/request/request.dart';
import 'package:initial/domain/model/model.dart';
import '../../domain/repository/repository.dart';


class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        //it safe to call the API
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data
          return Right(
            response.toDomain(),
          );
        } else {
          //return logic error
          return Left(
            Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      //return connection error
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }
}
