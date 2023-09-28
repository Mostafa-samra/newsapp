import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/news_app_cubit.dart';
import 'package:newsapp/shared/componant/componant.dart';

class Sports extends StatelessWidget {
  const Sports({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsAppCubit.get(context).sports;
        return articalBuilder(cubit);
      },
    );
  }
}
