import 'package:dio/dio.dart';
import 'package:ekitaab_pasal/index.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';


class AddBookForm extends StatefulWidget {
  final Book book;

  AddBookForm({this.book});

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  //variables
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Color fieldColor = Color(0xffedeef3);
  bool isloading = false;
  final booknameController = TextEditingController();
  final priceController = TextEditingController();
  final authornameController = TextEditingController();
  final detailController = TextEditingController();
  BookCategory selectedCategory;
  File _image;

  List<BookCategory> _categoryList = List<BookCategory>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void dispose() {
    booknameController.dispose();
    priceController.dispose();
    authornameController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var bookNotifier = Provider.of<BookNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Rent Your Book'),
        backgroundColor: Colors.green,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                //Job Title
                TextField(
                  controller: booknameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor,
                    hintText: 'Book Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),
                //Job Title
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor,
                    hintText: 'Rent Price',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                //Job Title
                TextField(
                  controller: authornameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor,
                    hintText: 'Author Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: detailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor,
                    hintText: 'Description',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(0.0)),
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),
                Text('Category'),
                DropdownButton<BookCategory>(
                  isExpanded: true,
                  items: _categoryList.map((BookCategory category) {
                    return new DropdownMenuItem<BookCategory>(
                      value: category,
                      child: new Text(category.name),
                    );
                  }).toList(),
                  onChanged: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  value: selectedCategory,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('Book Image'),
                //image
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    _pickimage();
                  },
                  child: Image.asset(
                    _image == null
                        ? 'assets/images/placeholder.png'
                        : _image.path,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                //button
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (!isloading) _addBook();
                    },
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        !isloading ? 'Add Book' : 'Please Wait..',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _getAllCategories();
  }

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
            BookCategory bookCategory = BookCategory(
              id: category['id'],
              name: category['name'],
              icon: category['image'],
            );
            _categoryList.add(bookCategory);
            selectedCategory = bookCategory;
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

  Future<void> _pickimage() async {
    print("Asd");
    _image = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['jpg']);

    if (_image != null) {
      setState(() {});
    }
  }

  Future<void> _addBook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var book = booknameController.text;
    var price = priceController.text;
    var author = authornameController.text;
    var detail = detailController.text;

    if (book == '' ||
        price == '' ||
        author == '' ||
        detail == '' ||
        selectedCategory == null ||
        _image == null) {
      //show snackbar
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Empty Fields!')));
      return;
    }

    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap({
      'user_id': userid.toString(),
      'image': await MultipartFile.fromFile(_image.path, filename: "image.jpg"),
      'book': book.toString(),
      'price': price.toString(),
      'author': author.toString(),
      'detail': detail.toString(),
      'category_id': selectedCategory.id.toString(),
    }); // just like JS

    var url = ApiHelper.addbook;
    await dio.post(url, data: formdata).then((response) {
      print(response.data.toString());
      var data = response.data;
      if (data['status'] == 200) {
        //clear all
        booknameController.text = '';
        priceController.text = '';
        authornameController.text = '';
        detailController.text = '';
        _image = null;

        _sendLocalNotifications();

        if (mounted) setState(() {});
        //show snackbar
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Book Added!')));
      }
    });
  }

  Future<void> _sendLocalNotifications() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        priority: Priority.High,
        importance: Importance.Max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Book Added',
        'New book has been added by you.', platformChannelSpecifics);
  }
  // Future<void> _sendLocalNotifications()(
  //   }

}
