import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themovieapp/constants/secret.dart';
import 'package:themovieapp/helpers/colors.dart';
import 'package:themovieapp/helpers/spacing.dart';
import 'package:themovieapp/model/movie_model.dart';
import 'package:themovieapp/views/details_page.dart';

class MovieCardWidget extends StatelessWidget {
   const MovieCardWidget({
    super.key,
    required this.movies,

  });
  final List<MovieModel>? movies;

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: ListView.builder(
        itemCount: movies!.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          MovieModel movie = movies![index];       
          return GestureDetector(
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: carousalBackgroundColor()),
                      child: Padding(
                        padding: const EdgeInsets.all(1.2),
                        child: Container(
                          width: width*0.44,
                          height: height*0.27,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 2, 11, 49),
                            borderRadius: BorderRadius.circular(19),
                            image: DecorationImage(
                              image: NetworkImage('${ApiConstants().imageUrl}${movie.posterPath}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                     width: width*0.44,
                      height: height*0.08,
                      decoration: BoxDecoration(
                        color: Colors.grey[900]!.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.title!,style: GoogleFonts.poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                                Text(movie.releasedate!,style: GoogleFonts.poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),                      
                              ],
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
                spacingWidth(20),
              ],
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DetailsPage(
                type: "movie",
                backgroundImage: movie.posterPath!,
                 date: movie.releasedate!,
                 name: movie.title!,
                 overview: movie.overview!,
                 voteraverage: movie.voteAverage!,
                 votercount: movie.voterCount!,
                 id: movie.id!,
              )));
            },
          );
        },
      ),
    );
  }
}
