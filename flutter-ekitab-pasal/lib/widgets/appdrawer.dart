import 'package:ekitaab_pasal/index.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  buildList(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'sans',
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.grey,
            child: Center(
                child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage('assets/logo.png'),
                  minRadius: 20,
                  maxRadius: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'E-Kitab Pasal',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ])),
          ),
          buildList(
            'Home',
            Icons.home,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return Home();
                  },
                ),
              );
            },
          ),
          new Divider(
            color: Colors.greenAccent,
            height: 3.0,
          ),
          buildList(
            'Contact Us',
            Icons.contact_mail,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return ContactPage();
                  },
                ),
              );
            },
          ),
          new Divider(
            color: Colors.greenAccent,
            height: 2.0,
          ),
          buildList(
            'FAQs',
            Icons.question_answer,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return FAQPage();
                  },
                ),
              );
            },
          ),
          new Divider(
            color: Colors.greenAccent,
            height: 2.0,
          ),
          buildList(
            'About App',
            Icons.library_books,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return AboutPage();
                  },
                ),
              );
            },
          ),
          new Divider(
            color: Colors.greenAccent,
            height: 2.0,
          ),
          buildList(
            'Log Out',
            Icons.exit_to_app,
            () {
              //logout user
              _logout(context);
            },
          ),
          new Divider(
            color: Colors.greenAccent,
            height: 2.0,
          ),
        ],
      ),
    );
  }

  //TODO: move to seperate service for auth
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }
}
