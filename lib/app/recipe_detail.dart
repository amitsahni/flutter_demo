import 'package:f_d/data/model/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key, required this.model}) : super(key: key);

  final RModel model;

  @override
  State<StatefulWidget> createState() {
    return _RecipeDetailPageStage();
  }
}

class _RecipeDetailPageStage extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: Column(children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image(
                image: NetworkImage(widget.model.poster),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(widget.model.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
        ),
      ),
    );
  }
}
