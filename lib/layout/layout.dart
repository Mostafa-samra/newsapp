import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/news_app_cubit.dart';
import 'package:newsapp/modules/search/search.dart';
import 'package:newsapp/shared/componant/componant.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
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
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    (p0) => const SearchScreen(),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeAppTheme();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
            title: Row(
              children: [
                Text(
                  "News Of ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).primaryColor),
                  child: Text(
                    cubit.titleApp[cubit.currentIndex],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
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
    );
  }
}
