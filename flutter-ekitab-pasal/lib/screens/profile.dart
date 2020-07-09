import 'package:mdi/mdi.dart';
import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

//String selectedCategorie="All";
class UserProfile extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Notifications", Icons.notifications),
    new DrawerItem("Profile", Icons.person),
    new DrawerItem("Contact Us", Icons.contact_mail),
    // new DrawerItem("Setting", Icons.settings),
    new DrawerItem("FAQs", Icons.question_answer),
    new DrawerItem("About App", Icons.library_books),
    new DrawerItem("Log Out", Icons.close),
  ];

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _updateProfileLayout = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isloading = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final nameController2 = TextEditingController();
  final phoneController2 = TextEditingController();
  final addressController2 = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    nameController2.dispose();
    phoneController2.dispose();
    addressController2.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('User Profile'),
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
      ),
      drawer: AppDrawer(),
      body: Container(
        child: !_updateProfileLayout ? profileLayout() : profileUpdateLayout(),
      ),
    );
  }

  Widget profileLayout() {
    return Container(
      child: new Column(mainAxisAlignment: MainAxisAlignment.start, children: <
          Widget>[
        new Container(
            margin: EdgeInsets.only(top: 30),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Icon(Mdi.faceProfile,
                                size: 40.0, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: Text("User Profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Open-Sans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      letterSpacing: 1.5)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Icon(Mdi.renameBox,
                                size: 30.0, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(nameController.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Open-Sans",
                                    fontSize: 20,
                                    letterSpacing: 1.0)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Icon(Mdi.phoneRing,
                                size: 30.0, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(phoneController.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Open-Sans",
                                    fontSize: 20,
                                    letterSpacing: 1.0)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Icon(Mdi.email,
                                size: 30.0, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(emailController.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Open-Sans",
                                    fontSize: 20,
                                    letterSpacing: 1.0)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Icon(Mdi.mapMarker,
                                size: 30.0, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(addressController.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Open-Sans",
                                    fontSize: 20,
                                    letterSpacing: 1.5)),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: ButtonTheme(
                            minWidth: 120.0,
                            height: 50.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                              color: Colors.green,
                              onPressed: () {
                                nameController2.text = nameController.text;
                                phoneController2.text = phoneController.text;
                                addressController2.text =
                                    addressController.text;
                                _updateProfileLayout = true;
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Update Profile',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Open-Sans",
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            // ),
            ),
      ]),
    );
  }

  Widget profileUpdateLayout() {
    return Container(
      child: new Column(mainAxisAlignment: MainAxisAlignment.start, children: <
          Widget>[
        new Container(
            margin: EdgeInsets.only(top: 30),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Icon(Mdi.faceProfile,
                                size: 40.0, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: Text("User Profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Open-Sans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      letterSpacing: 1.5)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: nameController2,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          labelText: 'Full Name',
                          hintText: "Please Enter your Full Name",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (nameValue) {
                          if (nameValue.isEmpty) {
                            return 'Please enter your name';
                          }
                          // name = nameValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: phoneController2,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          labelText: 'Phone Number',
                          hintText: "Enter your Phone Number",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (phoneNumber) {
                          if (phoneNumber.isEmpty) {
                            return 'Please enter your Contact Number';
                          }
                          //  phone = phoneNumber;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: addressController2,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.place,
                            color: Colors.grey,
                          ),
                          labelText: 'Address',
                          hintText: "Enter your Address",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (addressValue) {
                          if (addressValue.isEmpty) {
                            return 'Please enter your Address';
                          }
                          //  address = addressValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          labelText: 'Password',
                          hintText: "Set Your Password",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (passwordValue) {
                          if (passwordValue.isEmpty) {
                            return 'Please enter some text';
                          }
                          //  password = passwordValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: ButtonTheme(
                            minWidth: 120.0,
                            height: 50.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                              color: Colors.green,
                              onPressed: () {
                                if (!_isloading) {
                                  _updateProfile();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    _isloading ? 'Updating...' : 'Update',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Open-Sans",
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: ButtonTheme(
                            minWidth: 120.0,
                            height: 50.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                              color: Colors.black,
                              onPressed: () {
                                nameController2.text = '';
                                phoneController2.text = '';
                                addressController2.text = '';
                                _updateProfileLayout = false;
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Cancel',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Open-Sans",
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            // ),
            ),
      ]),
    );
  }

  @override
  void initState() {
    _fetchProfileData();
    super.initState();
  }

  //TODO: move to seperate service
  Future<void> _fetchProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.profile;
    await http.post(url, body: {
      'user_id': userid.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          _updateProfileLayout = false;
          nameController.text = data['datas']['name'];
          phoneController.text = data['datas']['phone'];
          addressController.text = data['datas']['address'];
          emailController.text = data['datas']['email'];

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

  Future<void> _updateProfile() async {
    var name = nameController2.text;
    var phone = phoneController2.text;
    var address = addressController2.text;
    var password = passwordController.text;

    if (name == '' || phone == '' || address == '') {
      //show snackbar
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Empty Fields!')));
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.updateprofile;
    await http.post(url, body: {
      'user_id': userid.toString(),
      'name': name.toString(),
      'phone': phone.toString(),
      'address': address.toString(),
      'password': password.toString(),
    }).then((response) async {
      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text("Updated")));
          setState(() {
            _isloading = false;
            _updateProfileLayout = false;
          });
          _fetchProfileData();
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
