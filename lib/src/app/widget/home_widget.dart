
import 'package:f_d/src/app/bLoc/base/bloc_provider.dart';
import 'package:f_d/src/app/bLoc/movie_bloc.dart';
import 'package:f_d/src/app/base/base.dart';
import 'package:f_d/src/data/model/data_result.dart';

import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:flutter/material.dart';

Widget buildResults(MovieBloc bloc) {
  return ResultStreamBuilder<RModel>(
    stream: bloc.locationStream,
    successBuilder: (context, snapshot) {
      var success = snapshot.data!.success()!;
      if (success.list.isEmpty) {
        return const Center(child: Text('No Results'));
      }
      return buildListView(success.list);
    },
    loadingBuilder: (context, snapshot){
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    errorBuilder: (context, snapshot){
      var error = snapshot.data!.failure()!;
      return Center(child: Text(error.toString()));
    },
  );
}

// build list view & its tile
Widget buildListView(List<Search> list) {
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        var item = list[index];
        return GestureDetector(
            onTap: () {
              //_showToast(context, item);
              var movieBloc = BlocProvider.of<MovieBloc>(context);
              item.title = "Test";
              list[index] = item;
              movieBloc.update(list);
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RecipeDetailPage(model: item);
                    },
                  ),
                );*/
            },
            child: buildRecipeWidget(item));
      });
}

Widget buildRecipeWidget(Search recipeModel) {
  return Card(
      elevation: 3.0,
      color: Colors.white,
      shadowColor: Colors.yellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          children: [
            Image(image: NetworkImage(recipeModel.poster), height: 80),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              recipeModel.title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Palatino"),
            )
          ],
        ),
      ));
}