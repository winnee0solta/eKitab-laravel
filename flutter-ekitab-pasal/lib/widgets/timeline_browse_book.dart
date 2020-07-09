import 'package:ekitaab_pasal/index.dart';

class TimelineBrowseBook extends StatefulWidget {
  final Book book;

  TimelineBrowseBook(this.book);
  @override
  _TimelineBrowseBookState createState() => _TimelineBrowseBookState();
}

class _TimelineBrowseBookState extends State<TimelineBrowseBook> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: 190,
      height: 240,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookSingle(bookId: widget.book.id)));
        },
        child: Card(
          child: Column(
            children: <Widget>[
              Text('${this.widget.book.book}'),
              Image.network(
                  ApiHelper.domain + "/images/books/" + widget.book.image,
                  width: 190,
                  height: 160),
              Column(
                children: <Widget>[
                  //Text('${this.widget.bookName}'),
                  Text('Rent/Month: रू ${this.widget.book.price}'),
                  Text('Author: ${this.widget.book.author}'),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
