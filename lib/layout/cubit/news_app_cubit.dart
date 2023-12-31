import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business/business.dart';
import 'package:newsapp/modules/science/science.dart';
import 'package:newsapp/modules/sports/sports.dart';
import 'package:newsapp/shared/network/locale/cache_helper.dart';
import 'package:newsapp/shared/network/remote/diohelper.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      pathUrl: 'v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'business',
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
      pathUrl: 'v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'sports',
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
      pathUrl: 'v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'science',
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

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsAppSearchLodedState());
    search = [];
    DioHelper.getData(
      pathUrl: 'v2/everything',
      queryParameters: {
        'q': value,
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then(
      (value) {
        search = value.data["articles"];
        emit(NewsAppSearchSucsesState());
        debugPrint("SearchSucses ==> ${sports[0]['title']}");
      },
    ).catchError((onError) {
      emit(NewsAppSearchErrorState(error: 'search $onError'));
      debugPrint(onError.toString());
    });
  }

  bool isDark = false;
  // ThemeMode appMode = ThemeMode.dark;
  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark)
          .then((value) => emit(NewsAppChangeThemeState()));
    }
  }

  late final WebViewController controller;
  webView(String url) {
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(url),
      ).then((value) => NewsAppWebViewState());
  }
}
