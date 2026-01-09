import 'package:bloc/bloc.dart';
import '../../../domain/repository/ai_repository.dart';
import 'ai_state.dart';

class AiResponseCubit extends Cubit<AiResponseState> {
  final AiRepository aiRepository;

  AiResponseCubit({required this.aiRepository}) : super(AiResponseLoading());

  void send(String prompt) {
    try {
      Stream<String> response = aiRepository.send(prompt);
      emit(AiResponseLoaded(response: response));
    } catch (e) {
      emit(AiResponseError(e));
    }
  }
}