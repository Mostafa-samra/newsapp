import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/cubit/news_app_cubit.dart';
import 'package:newsapp/layout/layout.dart';
import 'package:newsapp/shared/bloc_observer.dart';
import 'package:newsapp/shared/network/locale/cache_helper.dart';
import 'package:newsapp/shared/network/remote/diohelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsAppCubit()
        ..changeAppTheme(fromShared: isDark)
        ..getBusinessData()
        ..getSportsData()
        ..getScienceData(),
      child: BlocConsumer<NewsAppCubit, NewsAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsAppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.amber,
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Color.fromARGB(255, 173, 140, 18),
                elevation: 20.0,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
              useMaterial3: true,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 160, 160, 160),
                ),
              ),
              primaryColor: const Color.fromARGB(255, 238, 189, 43),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color.fromARGB(255, 158, 120, 4),
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              primaryColor: const Color.fromARGB(255, 158, 120, 4),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const LayoutScreen(),
          );
        },
      ),
    );
  }
}
