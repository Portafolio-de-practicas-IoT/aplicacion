import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  Map<String, dynamic> mockedData = {
    "food_level": 67.0,
    "water_level": 55.0,
    "history": {
      "food": [71, 84, 48, 80, 74, 67],
      "water": [57, 99, 39, 67, 49, 87]
    },
    "pets": [
      {
        "name": "Sierra",
        "age": "3 years",
        "status": "Well fed",
        "weight": "14.65Kg",
        "image":
            "https://cdn.arstechnica.net/wp-content/uploads/2022/04/GettyImages-997016774.jpg"
      },
      {
        "name": "Astro",
        "age": "3 months",
        "status": "Bad fed",
        "weight": "640g",
        "image":
            "https://www.princeton.edu/sites/default/files/styles/half_2x/public/images/2022/02/KOA_Nassau_2697x1517.jpg?itok=iQEwihUn"
      },
      {
        "name": "Sky",
        "age": "8 years",
        "status": "Well fed",
        "weight": "23.4Kg",
        "image":
            "https://cdn.britannica.com/49/161649-050-3F458ECF/Bernese-mountain-dog-grass.jpg"
      }
    ]
  };

  StatisticsBloc() : super(StatisticsInitial()) {
    _loadStatistics();
  }

  void _loadStatistics() {
    return on<LoadStatistics>((event, emit) {
      emit(StatisticsLoading());

      emit(StatisticsLoaded(statistics: mockedData));
    });
  }
}
