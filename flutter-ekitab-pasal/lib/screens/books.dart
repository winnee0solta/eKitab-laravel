import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isloading = false;
  List<Book> books = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Books"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: _isloading
            ? LoadingLayout()
            : RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: Container(
                    color: Color(0xfff5eded),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              hintText: 'Search Books',
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(20.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(20.0)),
                              suffixIcon: IconButton(
                                onPressed: () => _filterData(),
                                icon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _listViewBuilder(),
                        ),
                      ],
                    )),
              ),
      ),
    );
  }

  Widget _listViewBuilder() {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookSingle(
                              bookId: books[index].id,
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //image
                  Image.network(
                      ApiHelper.domain + "/images/books/" + books[index].image,
                      fit: BoxFit.cover,
                      // width: 190,
                      height: 180),
                  //details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          books[index].book,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Author: ${books[index].author}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'Category: ${books[index].category}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'Rent/Month: रू ${books[index].price}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _filterData() {
    var searchtext = searchController.text;
    if (searchtext != '') {
      print(searchtext);

      _fetchMyBooks().then((response) {
        List<Book> searchedBooks = List<Book>();
        books.forEach((book) {
          //book name
          if (book.book.toLowerCase().contains(searchtext.toLowerCase())) {
            searchedBooks.add(book);
          }
          //author
          if (book.author.toLowerCase().contains(searchtext.toLowerCase())) {
            searchedBooks.add(book);
          }
          if (book.category.toLowerCase().contains(searchtext.toLowerCase())) {
            searchedBooks.add(book);
          }
        });
        setState(() {
          books.clear();
          books = searchedBooks;
        });
      });
    } else {
      _refresh();
    }
  }

  @override
  void initState() {
    _fetchMyBooks();
    super.initState();
  }

  //TODO: move to seperate service
  Future<void> _fetchMyBooks() async {
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
          books.clear();
          _rawbooks.forEach((book) {
            books.add(new Book(
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
          //show snackbar
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(data['message'])));
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        print(response);
        throw Exception('Failed to load');
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<Null> _refresh() {
    return _fetchMyBooks();
    // return _fetchPosts().then((posts) {
    //   setState(() {
    //     jobposts = posts;
    //   });
    // });
  }
}
