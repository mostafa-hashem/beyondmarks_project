abstract class StudentInputStates {}

class StudentInputInitial extends StudentInputStates {}

class StudentInputLoading extends StudentInputStates {}

class StudentInputSuccess extends StudentInputStates {
  final Map<String, dynamic> result;
  StudentInputSuccess(this.result);
}

class StudentInputError extends StudentInputStates {
  final String message;
  StudentInputError(this.message);
}
