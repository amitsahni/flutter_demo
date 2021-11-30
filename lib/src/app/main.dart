import 'package:dio/dio.dart';
import 'package:f_d/src/app/pages/recipe_detail.dart';
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
import 'base/base.dart';
import 'di/module.dart';
import 'localization/app_localization.dart';
import 'widget/home_widget.dart';

void main() {
  startKoin((app) {
    app.modules([myModule]);
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

class RecipeHomePage extends StatefulWidget {
  final String title;
  const RecipeHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  late final MovieBloc bloc;
  late final AppLocalizations _appLocalization;

  @override
  void initState() {
    bloc = get<MovieBloc>();
    _appLocalization = AppLocalizations.of(context);
    super.initState();
  }

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
            title: Text(_appLocalization.translate('title')),
          ),
          body: SafeArea(
            child: buildResults(bloc),
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
          return buildListView(success.list);
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


}
