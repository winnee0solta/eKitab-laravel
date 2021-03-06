import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  // Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isloading = false;
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
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
            SizedBox(height: 48),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Welcome to ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              )),
                          TextSpan(
                              text: 'E-Kitab ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                          TextSpan(
                            text: 'Pasal ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                      //fit:BoxFit.fill
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            elevation: 30.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Account Login',
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
                                        labelText: "Email",
                                        hintText: "Please enter your Email",
                                        hasFloatingPlaceholder: true,
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
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
                                        labelText: "Password",
                                        hintText: "Enter your Password",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      validator: (passwordValue) {
                                        if (passwordValue.isEmpty) {
                                          return 'Password field cannot be empty';
                                        } else if (passwordValue.length < 6) {
                                          return "the password has to be at least 6 characters long";
                                        }
                                        // password = passwordValue;
                                        return null;
                                      },
                                      //onSaved: (String val) => password = val);
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 8.0, 14.0, 8.0),
                                      child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.teal,
                                          elevation: 0.0,
                                          child: MaterialButton(
                                            onPressed: () {
                                              if (!_isloading) {
                                                _login();
                                              }
                                            },
                                            minWidth: 150,
                                            //minWidth: MediaQuery.of(context).size.width,
                                            child: Text(
                                              _isloading
                                                  ? "Loging in........"
                                                  : "Login",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PasswordReset()),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 5),
                                        child: Text(
                                          "Forgot password?",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ), //card
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
                                          builder: (context) =>
                                              FirstRegister()));
                                },
                                minWidth: 150,
                                child: Text(
                                  'Register Now',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO: move to seperate service

  Future<void> _login() async {
    var emailv = email.text;
    var passwordv = password.text;
    if (emailv == '' || passwordv == '') {
      //show snackbar
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Empty Fields!')));
      return;
    }

    setState(() {
      _isloading = true;
    });

    var url = ApiHelper.loginurl;
    await http.post(url, body: {
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
