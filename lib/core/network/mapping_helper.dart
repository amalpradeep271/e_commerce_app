import 'package:dartz/dartz.dart';

Either<String, List<T>> mapListResponse<T>(
  Either<String, dynamic> data,
  T Function(Map<String, dynamic>) mapper,
) {
  return data.fold(
    (error) => Left(error),
    (list) {
      try {
        final mappedList = List.from(list)
            .map((e) => mapper(Map<String, dynamic>.from(e)))
            .toList();
        return Right(mappedList);
      } catch (e) {
        return Left('Parsing error: ${e.toString()}');
      }
    },
  );
}

Either<String, T> mapResponse<T>(
  Either<String, dynamic> data,
  T Function(Map<String, dynamic>) mapper,
) {
  return data.fold(
    (error) => Left(error),
    (map) {
      try {
        return Right(mapper(Map<String, dynamic>.from(map)));
      } catch (e) {
        return Left('Parsing error: ${e.toString()}');
      }
    },
  );
}
