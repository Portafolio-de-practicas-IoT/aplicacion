import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth/user_auth_repository.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(StatisticsInitial()) {
    _loadStatistics();
  }

  void _loadStatistics() {
    return on<LoadStatistics>((event, emit) async {
      emit(StatisticsLoading());

      String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
      if (useruid == "") {
        print("\t\tUser not authenticated");
        emit(StatisticsError(message: "User not authenticated"));
        return;
      }

      final QuerySnapshot statistics = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: useruid)
          .get();

      final List<DocumentSnapshot> documents = statistics.docs;
      if (documents.length == 0) {
        print("\t\tUser not found");
        emit(StatisticsError(message: "User not found"));
        return;
      }

      final Map<String, dynamic> data = documents[0]['statistics'];

      final QuerySnapshot pets = await FirebaseFirestore.instance
          .collection('pets')
          .where('useruid', isEqualTo: useruid)
          .get();

      final List<DocumentSnapshot> petsDocuments = pets.docs;

      final Map<String, dynamic> petsData = {
        "pets": petsDocuments.map((e) => e.data()).toList()
      };

      final Map<String, dynamic> mergedData = {...data, ...petsData};

      emit(StatisticsLoaded(statistics: mergedData));
    });
  }
}
