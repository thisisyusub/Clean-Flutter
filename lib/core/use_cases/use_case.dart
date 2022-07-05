import 'package:equatable/equatable.dart';

import '../either.dart';
import '../error/failure.dart';

abstract class Usecase<T, Type, Params> {
  Future<Either<Failure<T>, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
