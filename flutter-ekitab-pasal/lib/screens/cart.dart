import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isloading = false;
  List books = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("My Cart"),
      ),
      body: new Center(
        child: _isloading
            ? LoadingLayout()
            : RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: Container(
                  color: Color(0xfff5eded),
                  child: books.length == 0
                      ? Text("You have no books yet ")
                      : ListView.builder(
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
                                                  bookId: books[index]['book_id'].toString(),
                                                )));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //image
                                      Image.network(
                                          ApiHelper.domain +
                                              "/images/books/" +
                                              books[index]['image'],
                                          fit: BoxFit.cover,
                                          // width: 190,
                                          height: 180), 
                                      //details
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              books[index]['book'],
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Text(
                                              'Author: ${books[index]['author']}',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              'Category: ${books[index]['category']}',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                              'Rent/Month: रू ${books[index]['price']}',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                _removeBookFromCart(books[index]
                                                    ['hiredbook_id']);
                                              },
                                              color: Colors.red,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
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
                        ),
                ),
              ),
      ),
    );
  }

  Future<Null> _refresh() {
    return _fetchMyCart();
  }

  @override
  void initState() {
    _fetchMyCart();
    super.initState();
  }

  //TODO: move to seperate service
  Future<void> _fetchMyCart() async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.mycart;
    await http.post(url, body: {
      'user_id': userid.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          books.clear();
          books = data['books'];

          _isloading = false;
          setState(() {});
        } else {
          //show snackbar
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(data['message'])));
        }
        setState(() {
          _isloading = false;
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setState(() {
          _isloading = false;
        });

        print(response);
        throw Exception('Failed to load');
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _removeBookFromCart(hiredbookId) async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.removecartbook;
    await http.post(url, body: {
      'user_id': userid.toString(),
      'hiredbook_id': hiredbookId.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          _isloading = false;
          setState(() {});
          _fetchMyCart();
        } else {
          //show snackbar
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(data['message'])));
        }
        setState(() {
          _isloading = false;
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setState(() {
          _isloading = false;
        });

        print(response);
        throw Exception('Failed to load');
      }
    }).catchError((e) {
      print(e);
    });
  }
}
