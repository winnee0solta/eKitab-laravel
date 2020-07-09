<?php

namespace App\Http\Controllers\Mobile;

use App\Books;
use App\Hiredbooks;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Http\Request;

class HiredBookController extends Controller
{
    public function mybooks(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            //all books in his cart
            $books = array();

            foreach (Hiredbooks::where('hirer_id', $user->id)->where('approved', false)->get() as $hiredbook) {

                $book = Books::find($hiredbook->book_id);
                if ($book) {


                    array_push($books, array(
                        'hiredbook_id' => $hiredbook->id,
                        'book_id' => $book->id,
                        'user_id' => $book->user_id,
                        'image' => $book->image,
                        'book' => $book->book,
                        'price' => $book->price,
                        'author' => $book->author,
                        'detail' => $book->detail,
                        'category_id' => $book->category_id,
                        'category' => $book->category,
                        'created_at' => $book->created_at->format('Y-m-d'),
                    ));
                } else {
                    $hiredbook->delete();
                }
            }


            return Response(array(
                'status' => 200,
                'message' => 'OK',
                'books' => $books
            ));
        } else {
            $response = array(
                'status' => 404,
                'message' => 'User doesnt exist.',
            );
            return Response($response);
        }


        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
    public function cartRemoveBook(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'hiredbook_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            Hiredbooks::where('id', $request->hiredbook_id)->delete();


            return Response(array(
                'status' => 200,
                'message' => 'OK',
            ));
        } else {
            $response = array(
                'status' => 404,
                'message' => 'User doesnt exist.',
            );
            return Response($response);
        }


        $response = array(
            'status' => 404,
            'message' => 'Some error occured.',
        );
        return Response($response);
    }
}
