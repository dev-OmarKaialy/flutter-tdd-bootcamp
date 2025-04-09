import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/core/usecase/usecase.dart';

import '../repository/logo_repository.dart';

class GetLogoUsecase implements Usecase<Uint8List, String> {
  final LogoRepository repo;

  GetLogoUsecase({required this.repo});

  @override
  Future<Either<Failure, Uint8List>> call(String params) async {
    return await repo.getLogo(params);
  }
}
