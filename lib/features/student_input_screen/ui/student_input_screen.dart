import 'package:beyondmarks/features/student_input_screen/cubit/student_input_cubit.dart';
import 'package:beyondmarks/features/student_input_screen/cubit/student_input_states.dart';
import 'package:beyondmarks/features/student_input_screen/data/models/student_input_model.dart';
import 'package:beyondmarks/route_manager.dart';
import 'package:beyondmarks/ui/resources/app_colors.dart';
import 'package:beyondmarks/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentInputScreen extends StatefulWidget {
  const StudentInputScreen({super.key});

  @override
  State<StudentInputScreen> createState() => _StudentInputScreenState();
}

class _StudentInputScreenState extends State<StudentInputScreen> {
  final _formKey = GlobalKey<FormState>();

  String? gender;
  String? race;
  String? parentalEducation;
  String? lunch;
  String? testPrep;

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      gender = null;
      race = null;
      parentalEducation = null;
      lunch = null;
      testPrep = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800;
    final isSmallScreen = screenWidth < 600;

    final leftFields = [
      _buildRadioFormField(
        'Gender',
        ['Male', 'Female'],
        gender,
        (val) => setState(() => gender = val),
        isSmallScreen,
      ),
      _buildDropdownField(
        'Race/Ethnicity',
        ['group A', 'group B', 'group C', 'group D', 'group E'],
        (val) => setState(() => race = val),
      ),
      _buildDropdownField(
        'Parental Level of Education',
        [
          'Some high school',
          'High school',
          'Some College',
          "Associate's Degree",
          "Bachelor's Degree",
          "Master's Degree",
        ],
        (val) => setState(() => parentalEducation = val),
      ),
    ];

    final rightFields = [
      _buildRadioFormField(
        'Lunch',
        ['Standard', 'Free/reduced'],
        lunch,
        (val) => setState(() => lunch = val),
        isSmallScreen,
      ),
      _buildRadioFormField(
        'Test Preparation Course',
        ['None', 'Completed'],
        testPrep,
        (val) => setState(() => testPrep = val),
        isSmallScreen,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beyond Marks',
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () =>
                Navigator.pushNamed(context, Routes.settingsScreen),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 24,
          vertical: 16,
        ),
        child: Form(
          key: _formKey,
          child: BlocConsumer<StudentInputCubit, StudentInputStates>(
            listener: (context, state) {
              if(state is StudentInputError){
                debugPrint(state.message);
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
                  if (isWideScreen)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Column(children: leftFields)),
                        const SizedBox(width: 24),
                        Expanded(child: Column(children: rightFields)),
                      ],
                    )
                  else
                    Column(children: [...leftFields, ...rightFields]),
                  const SizedBox(height: 20),
                  if (state is StudentInputLoading)
                    const Center(child: LoadingIndicator())
                  else
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBarColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final input = StudentInputModel(
                                  gender: gender!.toLowerCase(),
                                  race: race!,
                                  parentalEducation: parentalEducation!.toLowerCase(),
                                  lunch: lunch!.toLowerCase(),
                                  testPreparation: testPrep!.toLowerCase(),
                                );
                                context
                                    .read<StudentInputCubit>()
                                    .predictStudentSuccess(input);
                              }
                            },
                            child: Text(
                              'Predict Success',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: AppColors.appBarColor,
                          ),
                          onPressed: _resetForm,
                          tooltip: 'Reset',
                        ),
                      ],
                    ),
                  if (state is StudentInputSuccess) ...[
                    const SizedBox(height: 30),
                    _buildResultCard(state.result, textTheme),
                  ] else if (state is StudentInputError) ...[
                    const SizedBox(height: 30),
                    _buildResultCard({'error': state.message}, textTheme),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> result, TextTheme textTheme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prediction Result',
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (result.containsKey('error'))
              Text(
                result['error'] as String,
                style: const TextStyle(color: Colors.red),
              )
            else
              ...result.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child:
                      Text('${e.key}: ${e.value}', style: textTheme.bodyMedium),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.iconColor),
          ),
        ),
        items: options
            .map(
              (option) => DropdownMenuItem(value: option, child: Text(option)),
            )
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }

  Widget _buildRadioFormField(
    String label,
    List<String> options,
    String? groupValue,
    Function(String) onChanged,
    bool isSmallScreen,
  ) {
    final theme = Theme.of(context);
    return FormField(
      validator: (_) => groupValue == null ? 'Please select $label' : null,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: state.hasError
                      ? Colors.red
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
              Column(
                children: options
                    .map(
                      (option) => RadioListTile(
                        activeColor: AppColors.iconColor,
                        title: Text(
                          option,
                          style: TextStyle(fontSize: isSmallScreen ? 13 : 15),
                        ),
                        value: option,
                        groupValue: groupValue,
                        onChanged: (val) {
                          onChanged(val!);
                          state.didChange(val);
                        },
                        contentPadding: EdgeInsets.zero,
                        dense: isSmallScreen,
                      ),
                    )
                    .toList(),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildScoreSlider(
  //   String label,
  //   double value,
  //   ValueChanged<double> onChanged,
  // ) {
  //   final theme = Theme.of(context);
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           '$label: ${value.toStringAsFixed(0)}',
  //           style: theme.textTheme.bodyLarge
  //               ?.copyWith(fontWeight: FontWeight.w600),
  //         ),
  //         Slider(
  //           value: value,
  //           max: 100,
  //           divisions: 100,
  //           label: value.toStringAsFixed(0),
  //           activeColor: AppColors.iconColor,
  //           inactiveColor: theme.colorScheme.primary.withValues(alpha: 0.3),
  //           onChanged: onChanged,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
