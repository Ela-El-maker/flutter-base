import 'package:dartz/dartz.dart';
import 'package:initial/data/network/failure.dart';

abstract class BaseUsecase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}