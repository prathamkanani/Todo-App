abstract interface class AiRepository {
  Stream<String> send(String prompt);
}