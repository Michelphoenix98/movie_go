import 'package:movie_go/movie_go.dart';
import 'dart:ui' as ui;

import 'models.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;
  var imageUrl = 'https://image.tmdb.org/t/p/w500/';
  MoviePage(this.movie);
  Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    final imageWidget = Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        width: 300,
        height: 450.0,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Colors.grey,
          image: new DecorationImage(
              image: new NetworkImage(imageUrl + movie.poster_path),
              fit: BoxFit.cover),
          boxShadow: [
            new BoxShadow(
                color: mainColor, blurRadius: 5.0, offset: new Offset(2.0, 5.0))
          ],
        ),
      ),
    );

    final castAvatars = FutureBuilder<List<Cast>>(
        future: getCast(movie.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircleAvatar();
          print(snapshot.data);

          return GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 250),
              children: [
                ...snapshot.data.map<Widget>((element) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: element.profile_path != null
                            ? NetworkImage(imageUrl + element.profile_path)
                            : null,
                        child: element.profile_path == null
                            ? Icon(Icons.account_circle)
                            : Container(),
                      ),
                      Text(
                        element.name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                }).toList()
              ]);
        });

    final metaInfo = Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  movie.title,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  '${movie.vote_average}/10',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: castAvatars,
          ),
        ],
      ),
    );

    final descriptionBox = Container(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          movie.overview,
          textAlign: TextAlign.left,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    final layoutChildren = <Widget>[
      (MediaQuery.of(context).orientation == Orientation.landscape)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: imageWidget,
                ),
                Expanded(
                  flex: 1,
                  child: metaInfo,
                ),
              ],
            )
          : Column(
              children: [
                imageWidget,
                metaInfo,
              ],
            ),
      descriptionBox,
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl + movie.backdrop_path,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: layoutChildren,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
