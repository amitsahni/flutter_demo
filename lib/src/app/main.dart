import 'package:dio/dio.dart';
import 'package:f_d/src/app/recipe_detail.dart';
import 'package:f_d/src/app/vm/recipe_vm.dart';
import 'package:f_d/src/data/model/data_result.dart';
import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/app/bLoc/base/bloc_provider.dart';
import 'package:f_d/src/app/bLoc/movie_bloc.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:koin/koin.dart';
import 'package:koin_flutter/src/widget_extension.dart';
import 'di/module.dart';
import 'localization/app_localization.dart';

void main() {
  startKoin((app) {
    app.module(myModule);
  });
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData();
    Locale _appLocale = Locale('ar');
    return MaterialApp(
        locale: _appLocale,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        title: "Recipe Calculator",
        theme: themeData.copyWith(
            colorScheme: themeData.colorScheme.copyWith(
          primary: Colors.grey,
          secondary: Colors.black,
        )),
        home: const RecipeHomePage(title: 'Batman Movies'));
  }
}

class RecipeHomePage extends StatelessWidget {
  const RecipeHomePage({Key? key, required this.title}) : super(key: key);

  final String title;



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );*/
    // 1
    final bloc = get<MovieBloc>();
    bloc.fetchMovies('query');
    bloc.errorStream.listen((event) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(event.toString()),
          action: SnackBarAction(
              label: 'Done', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    });
    return BlocProvider<MovieBloc>(
        bloc: bloc,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('title')),
          ),
          body: SafeArea(
            child: _buildResults(bloc),
          ),
        ));
  }

  void _showToast(BuildContext context, Search recipeModel) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(recipeModel.title),
        action: SnackBarAction(
            label: 'Done', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
    /*Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );*/
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

  // build list view & manage states
  Widget _buildBody(BuildContext context) {
    var recipeRepository = get<RecipeRepository>();
    final someMap = {
      "s": "batman",
      "apikey": "bbf02d07",
    };
    var recipeVM = get<RecipeViewModel>();
    return FutureBuilder<DataResult<RModel>>(
      future: recipeRepository.fetchMediaList(),
      builder: (context, snapshot) {
        // 1
        final results = snapshot.data;
        var success = results?.success();
        var error = results?.failure();

        if(success != null){
          if (success.list.isEmpty) {
            return const Center(child: Text('No Results'));
          }
          return _buildListView(success.list);
        }

        if(error != null){
            return Center(child: Text(error.toString()));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildResults(MovieBloc bloc) {
    return StreamBuilder<DataResult<RModel>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        final results = snapshot.data;
        var success = results?.success();
        var error = results?.failure();

        if(success != null){
          if (success.list.isEmpty) {
            return const Center(child: Text('No Results'));
          }
          return _buildListView(success.list);
        }

        if(error != null){
          return Center(child: Text(error.toString()));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // build list view & its tile
  Widget _buildListView(List<Search> list) {
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
}
