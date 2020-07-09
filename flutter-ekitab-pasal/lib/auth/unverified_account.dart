import 'package:ekitaab_pasal/index.dart';
import 'package:http/http.dart' as http;

class UnverifiedAccount extends StatefulWidget {
  UnverifiedAccount({Key key}) : super(key: key);

  @override
  _UnverifiedAccountState createState() => _UnverifiedAccountState();
}

class _UnverifiedAccountState extends State<UnverifiedAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _sendingcode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('eKitab'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            Text('Account needs to be verified !'),
            SizedBox(
              height: 20.0,
            ),
            //button
            MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'I have verified my mail.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                if (!_sendingcode) _resendCode(context);
              },
              color:  _sendingcode ?  Colors.black : Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(15.0), 
                child: Text(
                  _sendingcode ? "Sending code......." : 'Resend Code.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _resendCode(BuildContext context) async {
    setState(() {
      _sendingcode = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');

    var url = ApiHelper.resendcode;
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
        //show snackbar
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Code Sent")));

        setState(() {
          _sendingcode = false;
        });
      }

      setState(() {
        _sendingcode = false;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response);

      setState(() {
        _sendingcode = false;
      });
      throw Exception('Failed to load');
    }
  }
}
