import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.green),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 150.0,
                        child: Image.asset(
                          'assets/logo.png',
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      // Image.asset('assets/logo.png',height: 200,),
                      Text(
                        "e-Kitab Pasal",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Hire and Rent",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // checkIfAuthenticated();
    Timer(Duration(seconds: 2), () => checkIfAuthenticated());
    super.initState();
  }

  /*
   * Checks if user_id is saved in shared pref or not
   */

  void checkIfAuthenticated() async {
    Navigator.of(context).popUntil((route) => route.isFirst);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('user_id'));
    if (prefs.getInt('user_id') != null) {
      //check if email verified
      _accountVerification(context);
    } else {
      //show login screen
      //force logout
      prefs.clear();
      //navigate
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  Future<void> _accountVerification(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.accountverification;
    var response = await http.post(url, body: {
      'user_id': userid.toString(), //need to send as string
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('Response body: $data');
      if (data['status'] == 200) {
        if (data['verified']) {
          //show home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UnverifiedAccount()),
          );
        }
      }else  if (data['status'] == 403){
         //show login screen
      //force logout
      prefs.clear();
      //navigate
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      }
    } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.   
        print(response);
        throw Exception('Failed to load');
      }
  }
}
