import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jokes_app/core/netowrk_info/network_info.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkInfo extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    networkInfoImpl = NetworkInfoImpl(instance: mockNetworkInfo);
  });

  group('isConnected', () {
    test('should forward the call to internetconnectionchecker.hasconnection',
        () async {
      //arrange
      final tHasConnection = Future.value(true);
      when(() => mockNetworkInfo.hasConnection)
          .thenAnswer((_) => tHasConnection);
      //act
      final result = networkInfoImpl.isConnected;

      //verify
      verify(() => mockNetworkInfo.hasConnection);
      expect(result, tHasConnection);
    });
  });
}
