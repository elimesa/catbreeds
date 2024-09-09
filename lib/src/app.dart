import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'blocs/cat_images_bloc.dart';
import 'package:catbreeds/src/ui/home_page.dart';
import 'package:catbreeds/src/resources/repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<CatImagesBloc>(
      create: (context) => CatImagesBloc(Repository()),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
