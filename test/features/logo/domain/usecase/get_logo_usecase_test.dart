import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/features/logo/domain/repository/logo_repository.dart';
import 'package:jokes_app/features/logo/domain/usecase/get_logo_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockLogoRepository extends Mock implements LogoRepository {}

void main() {
  group('getlogousecase test', () {
    late final GetLogoUsecase getLogoUsecase;
    late final MockLogoRepository repo;

    setUp(() {
      repo = MockLogoRepository();
      getLogoUsecase = GetLogoUsecase(repo: repo);
    });

    test('should return Uint8List', () async {
      //arrange
      var uint8list = Uint8List.fromList([0]);

      when(() => repo.getLogo('facebook.com')).thenAnswer((_) async {
        return Right(uint8list);
      });
      //act
      final result = await getLogoUsecase('facebook.com');
      //verify
      expect(result, Right(uint8list));
      verify(() => repo.getLogo('facebook.com')).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
