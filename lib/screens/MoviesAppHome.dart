import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb_movie/components/MovieList.dart';
import 'package:imdb_movie/models/MovieListModel.dart';
import 'package:imdb_movie/repository/MovieRepository.dart';
import 'package:loading_animations/loading_animations.dart';

class MoviesAppHome extends StatefulWidget {
  @override
  MoviesAppHomeState createState() => MoviesAppHomeState();
}

class MoviesAppHomeState extends State<MoviesAppHome> {
  final searchTextController = new TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Home'),
            ),
            body: Center(child: Text('NO INTERNET CONNECTION')),
          );
        }
        return child;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "  Home",
              style: GoogleFonts.lato(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
            elevation: 0.0,
          ),
          body: Column(
            children: <Widget>[
              Container(
                child: Row(children: <Widget>[
                  Flexible(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        setState(() {
                          searchText = searchTextController.text;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                      },
                      controller: searchTextController,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        labelText: "Search for movies",
                        hintText:
                            "Enter 3 or more characters to start searching",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          tooltip: 'Go',
                          onPressed: () {
                            setState(() {
                              searchText = searchTextController.text;
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ]),
                padding: EdgeInsets.all(10),
              ),
              if (searchText.length > 0)
                FutureBuilder<List<Movie>>(
                    future: searchMovies(searchText.toString()),
                    builder: (context, snapshot) {
                      // print(snapshot.data.toString());
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                            child: MovieList(movies: snapshot.data!.toList()));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return LoadingIndicator();
                    }),
            ],
          )),
    );
  }

  Widget LoadingIndicator() {
    return Container(
      alignment: Alignment.center,
      child: LoadingBouncingGrid.circle(
        backgroundColor: Colors.blue,
        size: 60.0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
