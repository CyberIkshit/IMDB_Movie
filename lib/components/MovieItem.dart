import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb_movie/models/MovieListModel.dart' as models;

import '../models/MovieModel.dart';
import '../repository/MovieRepository.dart';

class MovieItem extends StatelessWidget {
  models.Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieInfo>(
        future: getMovie(this.movie.imdbID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 0,
            );
          }
          return Container(
              padding: EdgeInsets.all(10.0),
              width: 150.0,
              height: MediaQuery.of(context).size.height * 0.43,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 33.0, bottom: 10, right: 10),
                    padding: EdgeInsets.only(
                        top: 10.0, left: 10, right: 10, bottom: 15),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(.5),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 30,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    this.movie.title,
                                    style: GoogleFonts.lato(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              //height: 30,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    snapshot.data!.genre.replaceAll(",", " |"),
                                    style: GoogleFonts.lato(color: Colors.grey),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 20,
                              width: 70,
                              child: Container(
                                height: 15,
                                width: 28,
                                // color: Colors.green,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blue),
                                child: Text(
                                  '${snapshot.data!.rating.split("/")[0]}  IMDB',
                                  style: GoogleFonts.lato(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (this.movie.poster != "N/A")
                    Positioned(
                      bottom: 10,
                      left: 2.0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 4.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(this.movie.poster),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ));
        });
  }
}
