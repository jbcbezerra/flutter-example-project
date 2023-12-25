import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

// create mockversion of dependencies
class MockAuthRepo extends Mock implements AuthenticationRepository {}
