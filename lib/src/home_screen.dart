import '../movie_go.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;

  Color themeColor = const Color(0xff3C3261);
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = Provider.of<List<Movie>>(context);
  }

  Widget build(BuildContext context) {
    print("mediaquery:${MediaQuery.of(context).size.width}");
    return OrientationBuilder(builder: (context, orientation) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.star),
                  text: "Top Picks",
                ),
                Tab(
                  icon: Icon(Icons.category),
                  text: "Genre",
                ),
                Tab(
                  icon: Icon(Icons.tv),
                  text: "TV shows",
                ),
              ],
            ),
            elevation: 0.3,
            centerTitle: true,
            backgroundColor: themeColor,
            leading: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            title: new Text(
              'Movie Go!',
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              new Icon(
                Icons.menu,
                color: themeColor,
              )
            ],
          ),
          body: TabBarView(
            children: [
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new SectionHeading(themeColor),
                    Expanded(
                      child: new GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).size.width ~/ 250),
                          shrinkWrap: true,
                          itemCount: data == null ? 0 : data.length,
                          itemBuilder: (context, i) {
                            return MaterialButton(
                              child: new MovieCard(data[i]),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(builder: (context) {
                                  return new MoviePage(data[i]);
                                }));
                              },
                              //  padding: const EdgeInsets.all(0.0),
                              color: Colors.white,
                            );
                          }),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_repair_service),
                  Text("Under development"),
                ],
              ),
              Center(
                child: Text("Under development"),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SectionHeading extends StatelessWidget {
  final Color mainColor;

  SectionHeading(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Text(
        'Top Picks',
        style: new TextStyle(
          fontSize: 40.0,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Color themeColor = const Color(0xff3C3261);
  final imageUrl = 'https://image.tmdb.org/t/p/w500/';
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                height: 190,
                child: Container(
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(imageUrl + movie.poster_path),
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    color: Colors.grey,
                    boxShadow: [
                      new BoxShadow(
                        color: themeColor,
                        blurRadius: 10.0,
                        offset: new Offset(2.0, 5.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: RichText(
            text: TextSpan(
              text: "${movie.title}",
              children: [
                TextSpan(
                  text:
                      (' (${movie.release_date.toString().substring(0, movie.release_date.toString().indexOf('-'))})'),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade700),
                )
              ],
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: themeColor),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
