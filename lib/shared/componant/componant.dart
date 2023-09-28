import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget itembuilder(article) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              /*    image: NetworkImage(
                  '  https://www.freecodecamp.org/news/content/images/size/w2000/2022/03/Cover.png'), */
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0), color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  // "title",
                  '${article["title"]}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text('${article['publishedAt']}'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget articalBuilder(list) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return itembuilder(list[index]);
          },
          /*  separatorBuilder: (context, index) {
            return const Divider();
          }, */
          itemCount: list.length);
    },
    fallback: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
