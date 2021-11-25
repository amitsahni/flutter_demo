abstract class UseCase<I,O> {
  Future<O> executes({I input});
}