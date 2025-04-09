import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/failure.dart';

abstract class LogoRepository {
  Future<Either<Failure, Uint8List>> getLogo(String param);
}
