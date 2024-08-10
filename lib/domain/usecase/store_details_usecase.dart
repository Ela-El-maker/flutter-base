import 'package:initial/data/network/failure.dart';
import 'package:initial/domain/model/model.dart';
import 'package:initial/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
