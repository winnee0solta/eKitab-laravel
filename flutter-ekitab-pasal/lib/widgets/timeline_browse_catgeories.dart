
import 'package:ekitaab_pasal/index.dart';

class TimelineBrowseCategories extends StatefulWidget {
  final List<BookCategory> categoryList;
  TimelineBrowseCategories({this.categoryList});

  @override
  _TimelineBrowseCategoriesState createState() =>
      _TimelineBrowseCategoriesState();
}

class _TimelineBrowseCategoriesState extends State<TimelineBrowseCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.categoryList.length,
        itemBuilder: (context, index) {
          return TimelineBrowseCategory(
              this.widget.categoryList[index].icon,
              this.widget.categoryList[index].name,
              this.widget.categoryList[index].id);
        },
      ),
    );
  }
}
