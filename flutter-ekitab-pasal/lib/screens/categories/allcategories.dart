import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class AllCategoriesScreen extends StatefulWidget {
  final List<BookCategory> categoryList;
  AllCategoriesScreen({Key key, this.categoryList}) : super(key: key);

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ), 
      body: Container(
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(widget.categoryList.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BooksByCategoryScreen(
                            categoryName: widget.categoryList[index].name,
                            categoryId: widget.categoryList[index].id)));
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                        _getImagePath(widget.categoryList[index].icon),
                        width: 190,
                        height: 160),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.categoryList[index].name),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

/*

*/
  _getImagePath(imagename) {
    return ApiHelper.categoryimageurl + imagename;
  }
}
