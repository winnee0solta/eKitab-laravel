import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  SliderService _sliderService = SliderService();
  CategoryService _categoryService = CategoryService();
  BookService _bookService = BookService();

//declaring instance of catgeory list
  List<BookCategory> _categoryList = List<BookCategory>();
  List<Book> _bookList = List<Book>();

  var items = [];
  double deviceHeight;
  double deviceWidth;
  AnimationController controller;
  Animation animation;
  Animation<double> opacityAnimation;
  Animation slideAnimation;

  @override
  Widget build(BuildContext context) {
    return buildHomeScreen();
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Home'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              }),
        ],
        backgroundColor: Colors.green,
      ),
      drawer: AppDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            // carouselSlider(items),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Browse Categories',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            TimelineBrowseCategories(
              categoryList: _categoryList,
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 8.0, 100.0, 6.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllCategoriesScreen(
                                categoryList: _categoryList,
                              )),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Colors.green,
                )),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Available Books',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            TimelineBrowseBooks(
              bookList: _bookList,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 8.0, 100.0, 6.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BooksScreen()),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Colors.green,
                )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _getAllSliders();
    _getAllCategories();
    _getAllBooks();
  }

  // _getAllSliders() async {
  //   var sliders = await _sliderService.getSliders();
  //   var result = json.decode(sliders.body);
  //   result['data'].forEach((data) {

  //     setState(() {
  //       items.add(NetworkImage(data['image_url']));
  //     });
  //   });
  //   print(result);
  // }

  //TODO: move to seperate service
  Future<void> _getAllCategories() async {
    var url = ApiHelper.categories;
    await http.get(url).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          List _rawcategories = data['categories'];
          _rawcategories.forEach((category) {
            _categoryList.add(new BookCategory(
              id: category['id'],
              name: category['name'],
              icon: category['image'],
            ));
            setState(() {});
          });
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response);
        throw Exception('Failed to get response');
      }
    }).catchError((e) {
      print(e);
    });
  }

//books
  Future<void> _getAllBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.books;
    await http.post(url, body: {
      'user_id': userid.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          List _rawbooks = data['books'];
          _rawbooks.forEach((book) {
            _bookList.add(new Book(
              id: book['book_id'].toString(),
              userId: book['user_id'].toString(),
              image: book['image'].toString(),
              book: book['book'].toString(),
              price: book['price'].toString(),
              author: book['author'].toString(),
              detail: book['detail'].toString(),
              categoryId: book['category_id'].toString(),
              category: book['category'].toString(),
              createdAt: book['created_at'].toString(),
            ));
          });
          setState(() {});
        } else {
          print(response);
          throw Exception('Failed to load');
        }
      }
    }).catchError((e) {
      print(e);
    });
  }
}
