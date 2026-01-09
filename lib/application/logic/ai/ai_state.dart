sealed class AiResponseState {}

final class AiResponseLoading extends AiResponseState {}

final class AiResponseLoaded extends AiResponseState {
  Stream<String> response;
  AiResponseLoaded({required this.response});
}

final class AiResponseError extends AiResponseState {
  final Object? error;
  AiResponseError(this.error);
}