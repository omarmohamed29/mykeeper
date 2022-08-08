part of 'dates_to_remember_cubit.dart';

@immutable
abstract class DatesToRememberState {}

class DatesToRememberInitial extends DatesToRememberState {}

class DatesUploaded extends DatesToRememberState{
  final String  succeed;

  DatesUploaded(this.succeed);
}

class DatesUploadError extends DatesToRememberState{
  final String error;

  DatesUploadError(this.error);
}


class DatesRetrieved extends DatesToRememberState {
  final List<DatesToRememberModel> datesToRemember;
  DatesRetrieved({
    required this.datesToRemember,
  });
}
