import 'package:flutter/material.dart';
import 'package:imdb_movie/models/MovieListModel.dart';

import 'MovieItem.dart';

class MovieList extends StatelessWidget {
  List<Movie> movies;

  MovieList({required this.movies});

  @override
  Widget build(context) {
    return new Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        addAutomaticKeepAlives: true,
        itemCount: this.movies.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieItem(movie: this.movies[index]);
        },
      ),
    );
  }
}
