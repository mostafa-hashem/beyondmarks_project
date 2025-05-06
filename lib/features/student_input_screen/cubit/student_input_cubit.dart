import 'package:beyondmarks/features/student_input_screen/cubit/student_input_states.dart';
import 'package:beyondmarks/features/student_input_screen/data/models/student_input_model.dart';
import 'package:beyondmarks/features/student_input_screen/data/services/student_input_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentInputCubit extends Cubit<StudentInputStates> {
  final StudentInputServices _services = StudentInputServices();

  StudentInputCubit() : super(StudentInputInitial());

  Future<void> predictStudentSuccess(StudentInputModel input) async {
    emit(StudentInputLoading());

    try {
      final result = await _services.predict(input);
      emit(StudentInputSuccess(result));
    } catch (e) {
      emit(StudentInputError(e.toString()));
    }
  }
}
