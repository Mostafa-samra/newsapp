import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/news_app_cubit.dart';
import 'package:newsapp/shared/componant/componant.dart';

class Business extends StatelessWidget {
  const Business({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsAppCubit.get(context).business;
        return articalBuilder(cubit, context);
      },
    );
  }
}
