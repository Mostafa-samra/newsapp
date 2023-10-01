import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/news_app_cubit.dart';
import 'package:newsapp/shared/componant/componant.dart';

class SearchScreen extends StatelessWidget {
  static TextEditingController searchControler = TextEditingController();
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsAppCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchControler,
                  type: TextInputType.text,
                  validate: (p0) {
                    if (p0!.isEmpty) {
                      return 'please entar search';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                  onChange: (p0) {
                    list.getSearch(p0);
                  },
                ),
              ),
              Expanded(
                child: articalBuilder(list.search, context, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
