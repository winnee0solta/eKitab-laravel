<?php

namespace App\Http\Controllers\Mobile;

use App\Books;
use App\Categories;
use App\Hiredbooks;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Http\Request;

class BooksController extends Controller
{

    //store 
    public function books(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $books = array();

            foreach (Books::get() as $book) {


                $category = Categories::find($book->category_id);
                if (empty($category)) {
                    $book->category_id = 0;
                    $book->category = "others";
                }

                //check if book belongs to user
                if ($book->user_id != $user->id) {

                    //check if hired 
                    if (Hiredbooks::where('book_id', $book->id)->count() == 0) {
                        array_push($books, array(
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
                    }
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
    public function store(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'book' => 'required',
            'price' => 'required',
            'author' => 'required',
            'detail' => 'required',
            'category_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            //check if category exists

            $category = Categories::find($request->category_id);
            if (empty($category)) {
                $response = array(
                    'status' => 404,
                    'message' => 'Category doesnt exist.',
                );
                return Response($response);
            }



            if ($request->hasFile('image')) {

                $file = $request->file('image');
                $unique_id = uniqid();
                $filename =  $unique_id . '_' . strval($user->id) . '_img.' . $file->getClientOriginalExtension();
                $file->move('images/books', $filename);

                $book = new Books();
                $book->user_id = $user->id;
                $book->image =  $filename;
                $book->book = $request->book;
                $book->price = $request->price;
                $book->author = $request->author;
                $book->detail = $request->detail;
                $book->category_id = $category->id;
                $book->category = $category->name;
                $book->save();

                return Response(array(
                    'status' => 200,
                    'message' => 'OK',
                ));
            } else {
                return Response(array(
                    'status' => 404,
                    'message' => 'Image is required.',
                ));
            }
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
    public function myBooks(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {


            $books = array();
            foreach (Books::where('user_id', $user->id)->get() as $book) {

                //check if category exists
                $category = Categories::find($book->category_id);
                if (empty($category)) {
                    $book->category_id = 0;
                    $book->category = "others";
                }

                array_push($books, array(
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
    public function singleBook(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'book_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $book = Books::find($request->book_id);

            if ($book) {
                //check if category exists
                $category = Categories::find($book->category_id);
                if (empty($category)) {
                    $book->category_id = 0;
                    $book->category = "others";
                }

                $isowner = false;
                $ishired = false;
                $ishirer = false;
                $requestapprove = false;

                $hirer_email = '-';
                $hirer_name = '-';
                $hirer_phone = '-';
                $hirer_address = '-';

                if ($book->user_id == $user->id) {
                    $isowner = true;
                }

                //check if book is hired
                $hiredbook =  Hiredbooks::where('book_id', $book->id)->first();
                if ($hiredbook) {
                    $ishired = true;

                    if ($hiredbook->approved) {
                        $requestapprove = true;
                    } else {
                        $requestapprove = false;
                    }
                    //check if current user is hirer
                    if ($hiredbook->hirer_id == $user->id) {
                        $ishirer = true;
                    }

                    //get hirer info 
                    $hirerUser = User::find($hiredbook->hirer_id);
                    if ($hirerUser) {
                        $hirer_email = $hirerUser->email;
                        $hirer_name = $hirerUser->name;
                        $hirer_phone = $hirerUser->phone;
                        $hirer_address = $hirerUser->address;
                    }
                }

                //renter info 

                $renteruser = User::find($book->user_id);
                //check if renter exists
                if (!$renteruser) {
                    $book->delete();
                    $response = array(
                        'status' => 404,
                        'message' => 'Some error occured.',
                    );
                    return Response($response);
                }

                return Response(array(
                    'status' => 200,
                    'message' => 'OK',
                    'book' => array(
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
                    ),
                    'book_status' => array(
                        'isowner' => $isowner,
                        'ishired' => $ishired,
                        'ishirer' => $ishirer,
                        'requestapprove' => $requestapprove,
                    ),
                    'renter_info' => array(
                        'email' => $renteruser->email,
                        'name' => $renteruser->name,
                        'phone'  => $renteruser->phone,
                        'address' => $renteruser->address,
                    ),
                    'hirer_info' => array(
                        'email' => $hirer_email,
                        'name' => $hirer_name,
                        'phone'  => $hirer_phone,
                        'address' => $hirer_address,
                    ),
                ));
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Book doesnt exist.',
                );
                return Response($response);
            }
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
    public function singleBookRemove(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'book_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $book = Books::find($request->book_id);
            if ($book) {

                if ($book->user_id == $user->id) {
                    $book->delete();
                    //TODO remove image
                }

                return Response(array(
                    'status' => 200,
                    'message' => 'OK',
                ));
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Book doesnt exist.',
                );
                return Response($response);
            }
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
    //singleBookUpdate
    public function singleBookUpdate(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'book_id' => 'required',
            'book' => 'required',
            'price' => 'required',
            'author' => 'required',
            'detail' => 'required',
            'category_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $book = Books::where('id', $request->book_id)->where('user_id', $request->user_id)->first();
            if ($book) {

                //check if category exists

                $category = Categories::find($request->category_id);
                if (empty($category)) {
                    $response = array(
                        'status' => 404,
                        'message' => 'Category doesnt exist.',
                    );
                    return Response($response);
                }

                if ($request->hasFile('image')) {
                    //TODO remove old image
                    $file = $request->file('image');
                    $unique_id = uniqid();
                    $filename =  $unique_id . '_' . strval($user->id) . '_img.' . $file->getClientOriginalExtension();
                    $file->move('images/books', $filename);
                    $book->image =  $filename;
                }

                $book->book = $request->book;
                $book->price = $request->price;
                $book->author = $request->author;
                $book->detail = $request->detail;
                $book->category_id = $category->id;
                $book->category = $category->name;
                $book->save();

                return Response(array(
                    'status' => 200,
                    'message' => 'OK',
                ));
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Book doesnt exist.',
                );
                return Response($response);
            }
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
    public function singleBookHire(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'book_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $book = Books::where('id', $request->book_id)->first();
            if ($book) {



                //check if already hired
                if (Hiredbooks::where('book_id', $book->id)->count() == 0) {

                    Hiredbooks::create([
                        'book_id' => $book->id,
                        'renter_id' => $book->user_id,
                        'hirer_id' => $user->id,
                    ]);

                    return Response(array(
                        'status' => 200,
                        'message' => 'OK',
                    ));
                } else {
                    $response = array(
                        'status' => 404,
                        'message' => 'Book already hired.',
                    );
                    return Response($response);
                }
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Book doesnt exist.',
                );
                return Response($response);
            }
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
    public function singleBookChangeHireStatus(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'book_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $book = Books::where('id', $request->book_id)->where('user_id', $user->id)->first();
            if ($book) {

                $hiredbook = Hiredbooks::where('book_id', $book->id)->first();

                if ($hiredbook) {

                    if ($hiredbook->approved) {
                        $hiredbook->delete();
                        return Response(array(
                            'status' => 200,
                            'message' => 'OK',
                        ));
                    } else {
                        $hiredbook->approved = true;
                        $hiredbook->save();
                        return Response(array(
                            'status' => 200,
                            'message' => 'OK',
                        ));
                    }
                } else {
                    $response = array(
                        'status' => 404,
                        'message' => 'Book doesnt exist.',
                    );
                    return Response($response);
                }
            } else {
                $response = array(
                    'status' => 404,
                    'message' => 'Book doesnt exist.',
                );
                return Response($response);
            }
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
    public function hiredBooks(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $books = array();

            foreach (Hiredbooks::where('hirer_id', $user->id)->where('approved', true)->get() as $hiredbook) {

                $book = Books::find($hiredbook->book_id);
                if ($book) {


                    //check if category exists
                    $category = Categories::find($book->category_id);
                    if (empty($category)) {
                        $book->category_id = 0;
                        $book->category = "others";
                    }

                    array_push($books, array(
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
    public function categoryBook(Request $request)
    {
        //validate
        $request->validate([
            'user_id' => 'required',
            'category_id' => 'required',
        ]);
        $user = User::find($request->user_id);
        if ($user) {

            $books = array();

            $raw_books = Books::where('category_id', $request->category_id)
                ->join('hiredbooks', 'hiredbooks.book_id', '=', 'books.id')
                ->select('books.*', 'hiredbooks.renter_id', 'hiredbooks.approved')
                ->get() ;

            foreach ($raw_books  as $book) {


                if($book->renter_id == $user->id){
                    continue;
                }

                if($book->approved){
                    continue;
                }


                array_push($books, array(
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
}
