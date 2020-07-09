import 'package:ekitaab_pasal/index.dart';
import 'package:ekitaab_pasal/screens/updatebook.dart';
import 'package:http/http.dart' as http;

class BookSingle extends StatefulWidget {
  final String bookId;
  BookSingle({this.bookId});

  @override
  _BookSingleState createState() => _BookSingleState();
}

class _BookSingleState extends State<BookSingle> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isloading = false;
  Book _book;
  bool _isowner;
  bool _ishired;
  bool _ishirer;
  bool _requestapprove;
  var _renterInfo = {
    'email': '',
    'name': '',
    'phone': '',
    'address': '',
  };
  var _hirerInfo = {
    'email': '',
    'name': '',
    'phone': '',
    'address': '',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_book == null ? '' : _book.book),
      ),
      body: Container(
        child: _isloading
            ? LoadingLayout()
            : SingleChildScrollView(
                child: Container(
                  child: _book == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //image
                              Center(
                                child: Image.network(
                                    ApiHelper.domain +
                                        "/images/books/" +
                                        _book.image,
                                    fit: BoxFit.cover,
                                    width: 190,
                                    height: 180),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              //name
                              ListTile(
                                title: Text("Book Name"),
                                subtitle: Text(_book.book),
                              ),
                              ListTile(
                                title: Text("Category"),
                                subtitle: Text(_book.category),
                              ),
                              ListTile(
                                title: Text("Author"),
                                subtitle: Text(_book.author),
                              ),
                              ListTile(
                                title: Text("Price"),
                                subtitle: Text("रू " + _book.price),
                              ),
                              ListTile(
                                title: Text("Added At"),
                                subtitle: Text(_book.createdAt),
                              ),
                              ListTile(
                                title: Text("Detail"),
                                subtitle: Text(_book.detail),
                              ),
                              _isowner ? _updateBookInformaion() : SizedBox(),
                              _ishirer ? _renterInformation() : SizedBox(),
                              _buildStatusBasedLayouts(),
                            ],
                          ),
                        ),
                ),
              ),
      ),
    );
  }

  Widget _buildStatusBasedLayouts() {
    if (_isowner == false && _ishired == false && _ishirer == false) {
      return _addToCart();
    }
    if (_isowner == true && _ishired == true && _ishirer == false) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          _hirerInformation()
        ],
      );
    }
    return SizedBox();
  }

  Widget _hirerInformation() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Hirer Information',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: Text("Name"),
            subtitle: Text(_hirerInfo['name']),
          ),
          ListTile(
            title: Text("Address"),
            subtitle: Text(_hirerInfo['address']),
          ),
          ListTile(
            title: Text("Phone"),
            subtitle: Text(_hirerInfo['phone']),
          ),
          ListTile(
            title: Text("Email"),
            subtitle: Text(_hirerInfo['email']),
          ),
          MaterialButton(
            onPressed: () {
              _changeBookHiredStatus();
            },
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                _requestapprove ? 'Mark as returned' : 'Approve to hire',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renterInformation() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Renter Information',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: Text("Name"),
            subtitle: Text(_renterInfo['name']),
          ),
          ListTile(
            title: Text("Address"),
            subtitle: Text(_renterInfo['address']),
          ),
          ListTile(
            title: Text("Phone"),
            subtitle: Text(_renterInfo['phone']),
          ),
          ListTile(
            title: Text("Email"),
            subtitle: Text(_renterInfo['email']),
          ),
          //add to cart ie rent it
        ],
      ),
    );
  }

  Widget _updateBookInformaion() {
    return Container(
      child: Column(
        children: <Widget>[
          //button
          MaterialButton(
            minWidth: double.infinity,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateBook(
                            book: _book,
                          )));
            },
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Update Book Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          MaterialButton(
            minWidth: double.infinity,
            onPressed: () {
              _removeBook();
            },
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Remove Book',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addToCart() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
          minWidth: double.infinity,
          onPressed: () {
            _hireBook();
          },
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Request to hire book',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _fetchMyBooks();
    super.initState();
  }

  //TODO: move to seperate service
  Future<void> _fetchMyBooks() async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.book;
    await http.post(url, body: {
      'user_id': userid.toString(),
      'book_id': widget.bookId.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          var book = data['book'];

          Book rawBook = Book(
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
          );
          _book = rawBook;

          _isowner = data['book_status']['isowner'];
          _ishired = data['book_status']['ishired'];
          _ishirer = data['book_status']['ishirer'];
          _requestapprove = data['book_status']['requestapprove'];

          _renterInfo['email'] = data['renter_info']['email'];
          _renterInfo['name'] = data['renter_info']['name'];
          _renterInfo['phone'] = data['renter_info']['phone'];
          _renterInfo['address'] = data['renter_info']['address'];

          _hirerInfo['email'] = data['hirer_info']['email'];
          _hirerInfo['name'] = data['hirer_info']['name'];
          _hirerInfo['phone'] = data['hirer_info']['phone'];
          _hirerInfo['address'] = data['hirer_info']['address'];

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

  Future<void> _removeBook() async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.removebook;
    await http.post(url, body: {
      'user_id': userid.toString(),
      'book_id': widget.bookId.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          _sendLocalNotifications(
              'Book Removed', 'Book has been removed from Ekitab.');
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Book Removed')));
          _isloading = false;
          setState(() {});
          Navigator.of(context).pop();
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

  Future<void> _hireBook() async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.hirebook;
    await http.post(url, body: {
      'user_id': userid.toString(),
      'book_id': widget.bookId.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          _sendLocalNotifications(
              'Book Hire', 'Book hire request sent to renter.');
          _isloading = false;
          setState(() {});
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          );
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

  Future<void> _changeBookHiredStatus() async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.changehirestatus;
    await http.post(url, body: {
      'user_id': userid.toString(),
      'book_id': widget.bookId.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          _sendLocalNotifications('Book Status', 'Book status changed.');
          _isloading = false;
          setState(() {});
          Navigator.of(context).pop();
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

  Future<void> _sendLocalNotifications(title, message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        priority: Priority.High,
        importance: Importance.Max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics);
  }
}
