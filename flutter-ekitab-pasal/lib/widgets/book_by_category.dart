 
import 'package:ekitaab_pasal/index.dart';
class BookByCategory extends StatefulWidget {
  final Book book;
  BookByCategory(this.book);
  @override
  _BookByCategoryState createState() => _BookByCategoryState();
}

class _BookByCategoryState extends State<BookByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 190,
      child: InkWell(
        onTap: ()
        {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetail(this.widget.book)));
        },
          child: Card(
          child: Column(
            children: <Widget>[
              Text(this.widget.book.book),
              Image.network(ApiHelper.domain+"/images/books/"+ widget.book.image,width:190,height:120,),
              Column(children: <Widget>[
                Text  ('Rent/Month: रू ${this.widget.book.price}'),
                Text('Author: ${this.widget.book.author}'),
              ],) 

        ],),),
      ),
      
    );
  }
}