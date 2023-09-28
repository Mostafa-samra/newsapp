import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business/business.dart';
import 'package:newsapp/modules/science/science.dart';
import 'package:newsapp/modules/sports/sports.dart';
import 'package:newsapp/shared/network/remote/diohelper.dart';

part 'news_app_state.dart';

class NewsAppCubit extends Cubit<NewsAppState> {
  NewsAppCubit() : super(NewsAppInitial());
  static NewsAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> screenItem = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'business'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'sports'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'science'),
  ];
  void bottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) const Sports();
    if (index == 2) const Science();
    emit(NewsAppBottomNavBarState());
  }

  List<Widget> screens = [
    const Business(),
    const Sports(),
    const Science(),
  ];

  List<String> titleApp = [
    "Business",
    "Sports",
    "Science",
  ];

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsAppBusinessLodedState());
    DioHelper.getData(
      pathUrl: 'v2/everything',
      queryParameters: {
        'q': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then(
      (value) {
        business = value.data["articles"];
        emit(NewsAppBusinessSucsesState());
        debugPrint("BusinessSucses ==> ${business[0]['title']}");
      },
    ).catchError((onError) {
      emit(NewsAppBusinessErrorState(error: 'Business $onError'));
      debugPrint(onError.toString());
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsAppSportsLodedState());
    DioHelper.getData(
      pathUrl: 'v2/everything',
      queryParameters: {
        'q': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then(
      (value) {
        sports = value.data["articles"];
        emit(NewsAppSportsSucsesState());
        debugPrint("SportsSucses ==> ${sports[0]['title']}");
      },
    ).catchError((onError) {
      emit(NewsAppSportsErrorState(error: 'Sports $onError'));
      debugPrint(onError.toString());
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsAppScienceLodedState());
    DioHelper.getData(
      pathUrl: 'v2/everything',
      queryParameters: {
        'q': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then(
      (value) {
        science = value.data["articles"];
        emit(NewsAppScienceSucsesState());
        debugPrint("ScienceSucses ==> ${sports[0]['title']}");
      },
    ).catchError((onError) {
      emit(NewsAppScienceErrorState(error: 'Science $onError'));
      debugPrint(onError.toString());
    });
  }
}
