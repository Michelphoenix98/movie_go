import 'movie_go.dart';
import 'src/models.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<Movie>>.value(
          initialData: [],
          value: getTopRated(),
        ),
      ],
      child: new MaterialApp(
        title: 'Movie Go!',
        home: new HomeScreen(),
      ),
    );
  }
}
