import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class FirstRegister extends StatefulWidget {
  @override
  FirstRegisterState createState() => FirstRegisterState();
}

class FirstRegisterState extends State<FirstRegister> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isloading = false;
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8),
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 150,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            elevation: 4.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Account Register',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                      controller: name,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                      controller: email,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.grey,
                                        ),
                                        labelText: 'Email',
                                        hintText: "Enter your valid Email",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      validator: (emailValue) {
                                        if (emailValue.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                        //email = emailValue;
                                        return null;
                                      },
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                      controller: phone,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                      controller: address,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                      controller: password,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: FlatButton(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 10,
                                              right: 10),
                                          child: Text(
                                            _isloading
                                                ? "Registering....."
                                                : "Register",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        color: Colors.teal,
                                        disabledColor: Colors.grey,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    20.0)),
                                        onPressed: () {
                                          if (!_isloading) {
                                            _register();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.teal,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                minWidth: 150,
                                child: Text(
                                  'Already Have an Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO: move to seperate service

  Future<void> _register() async {
    var namev = name.text;
    var emailv = email.text;
    var phonev = phone.text;
    var addressv = address.text;
    var passwordv = password.text;
    if (namev == '' ||
        emailv == '' ||
        phonev == '' ||
        addressv == '' ||
        passwordv == '') {
      //show snackbar
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Empty Fields!')));
      return;
    }

    setState(() {
      _isloading = true;
    });

    var url = ApiHelper.registerurl;
    await http.post(url, body: {
      'name': namev,
      'phone': phonev,
      'address': addressv,
      'email': emailv,
      'password': passwordv,
    }).then((response) async {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        print('Response body: $data');
        if (data['status'] == 200) {
          //store value
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('user_id', data['user']['id']);

          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
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
}
