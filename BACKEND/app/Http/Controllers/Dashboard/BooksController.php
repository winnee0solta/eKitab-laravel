<?php

namespace App\Http\Controllers\Dashboard;

use App\Books;
use App\Hiredbooks;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class BooksController extends Controller
{
    public function index()
    {
        $books = Books::all();

        return view(
            'dashboard.books.index',
            compact(
                'books'
            ) 
        );
    }
    public function remove(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
        ]);

        $book = Books::find($request->id);
        if ($book) {
            //empty hired
            Hiredbooks::where('book_id',$book->id)->delete();
            $book->delete();
        }

        return redirect('/dashboard/books');
    }
}
