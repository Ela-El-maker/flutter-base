import 'package:dartz/dartz.dart';
import 'package:initial/data/network/failure.dart';
import 'package:initial/data/request/request.dart';
import 'package:initial/data/responses/responses.dart';
import 'package:initial/domain/model/model.dart';

abstract class Repository{
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}