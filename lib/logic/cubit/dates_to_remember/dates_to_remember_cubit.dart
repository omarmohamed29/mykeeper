import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokhatat/data/model/dates_to_remember_model.dart';
import 'package:mokhatat/data/repository/datesTorememberRepository.dart';

import 'package:mokhatat/data/webservice/dates_to_remember_webservice.dart';

part 'dates_to_remember_state.dart';

class DatesToRememberCubit extends Cubit<DatesToRememberState> {
  final DatesToRememberWebService datesToRememberWebService;
  final  DatesToRememberRepo datesToRememberRepo;
  DatesToRememberCubit(
    this.datesToRememberRepo,
    this.datesToRememberWebService,
  ) : super(DatesToRememberInitial());


  Future<void>datesToRememeberUpload(List<String>events , DateTime date) async{
    await datesToRememberWebService.addDateToRemember(events, date).then((response){
      if(response){
        emit(DatesUploadError('Something went wrong try again later'));
      }else{
        emit(DatesUploaded('Event uploaded successfully'));
      }
    });
  }
  Future<void>datesToRemememberList() async{
    await datesToRememberRepo.retrieveData().then((dates){
       if(dates.toString() == {}.toString()){
      emit(DatesUploadError('You dont have any important dates yet try to add some'));
    }else{
      emit(DatesToRememberInitial());
      emit(DatesRetrieved(datesToRemember: dates));
    }
    }
   
    );
  }
}
