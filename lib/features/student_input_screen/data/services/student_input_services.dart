import 'package:beyondmarks/features/student_input_screen/data/models/student_input_model.dart';
import 'package:dio/dio.dart';

class StudentInputServices {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> predict(StudentInputModel input) async {
    // const host = '192.168.1.6:5001';
    // const host = '127.0.0.1:5001';
    const host = 'web-production-ae39.up.railway.app';
    final response = await _dio.post(
      'https://$host/predict',
      data: input.toJson(),
    );
    return response.data as Map<String, dynamic>;
  }
}
