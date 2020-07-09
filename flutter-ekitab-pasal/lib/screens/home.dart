
import 'package:ekitaab_pasal/index.dart';  
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; 
 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;
//    SliderService _sliderService=SliderService();
  var items = [];
  //  ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool isCatLoading = true;
  bool dataAvailable = false;
  double _maxScroll;
  double deviceHeight;
  double deviceWidth;
  AnimationController controller;
  Animation animation;
  Animation<double> opacityAnimation;
  Animation slideAnimation;
  bool visible = false;
  int totalCartItems = 0;
  List cartItems = [];
  bool isHomePageSelected = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      drawer: AppDrawer(),
      body: PageView(
        children: <Widget>[
          Timeline(),
          HiredBooks(),
          AddBookForm(),
          BookStatus(),
          UserProfile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                size: 35.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAuthScreen();
  }
}
