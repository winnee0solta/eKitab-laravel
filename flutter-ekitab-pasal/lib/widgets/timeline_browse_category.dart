 import 'package:ekitaab_pasal/index.dart';

class TimelineBrowseCategory extends StatefulWidget {
  final int categoryId;
  final String categoryIcon;
  final String categoryName;
  TimelineBrowseCategory(this.categoryIcon, this.categoryName, this.categoryId);
  @override
  _TimelineBrowseCategoryState createState() => _TimelineBrowseCategoryState();
}

class _TimelineBrowseCategoryState extends State<TimelineBrowseCategory> {
  _getImagePath(imagename) {
    return ApiHelper.categoryimageurl + imagename;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 190,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BooksByCategoryScreen(
                      categoryName: widget.categoryName,
                      categoryId: widget.categoryId)));
        },
        child: Card(
          child: Column(
            children: <Widget>[
              Image.network(_getImagePath(widget.categoryIcon),
                  width: 190, height: 160),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.categoryName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
