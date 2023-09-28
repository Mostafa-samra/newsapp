import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/news_app_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsAppCubit()
        ..getBusinessData()
        ..getSportsData()
        ..getScienceData(),
      child: BlocConsumer<NewsAppCubit, NewsAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsAppCubit.get(context);
          return Scaffold(
            /* floatingActionButton: FloatingActionButton(
                onPressed: () {
                  DioHelper.getData(
                    pathUrl: 'v2/top-headlines',
                    queryParameters: {
                      'country': 'eg',
                      'category': 'science',
                      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
                    },
                  ).then((value) => print(value)).catchError((onError) {
                    print(onError.toString());
                  });
                },
                child: const Icon(Icons.add)), */
            appBar: AppBar(
              title: Row(
                children: [
                  const Text("News Of "),
                  Text(
                    cubit.titleApp[cubit.currentIndex],
                    style: const TextStyle(backgroundColor: Colors.amber),
                  )
                ],
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                items: cubit.screenItem,
                currentIndex: cubit.currentIndex,
                onTap: (value) {
                  cubit.bottomNavBar(value);
                },
                type: BottomNavigationBarType.fixed),
          );
        },
      ),
    );
  }
}
