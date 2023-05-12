part of 'patient_cubit.dart';

abstract class PatientState {
  const PatientState();
}

class PatientInitial extends PatientState {}

class PatientEmptyData extends PatientState {}

class PatientServerError extends PatientState {}

class PatientDone extends PatientState {}

class PatientLoading extends PatientState {}

class PatientDoneRead extends PatientState {}
