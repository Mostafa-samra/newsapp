part of 'news_app_cubit.dart';

sealed class NewsAppState {}

final class NewsAppInitial extends NewsAppState {}

final class NewsAppBottomNavBarState extends NewsAppState {}

final class NewsAppBusinessLodedState extends NewsAppState {}

final class NewsAppBusinessSucsesState extends NewsAppState {}

final class NewsAppBusinessErrorState extends NewsAppState {
  final String error;

  NewsAppBusinessErrorState({required this.error});
}

final class NewsAppSportsLodedState extends NewsAppState {}

final class NewsAppSportsSucsesState extends NewsAppState {}

final class NewsAppSportsErrorState extends NewsAppState {
  final String error;

  NewsAppSportsErrorState({required this.error});
}

final class NewsAppScienceLodedState extends NewsAppState {}

final class NewsAppScienceSucsesState extends NewsAppState {}

final class NewsAppScienceErrorState extends NewsAppState {
  final String error;

  NewsAppScienceErrorState({required this.error});
}

final class NewsAppChangeThemeState extends NewsAppState {}

final class NewsAppSearchLodedState extends NewsAppState {}

final class NewsAppSearchSucsesState extends NewsAppState {}

final class NewsAppSearchErrorState extends NewsAppState {
  final String error;

  NewsAppSearchErrorState({required this.error});
}
