<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Create Initial Admin Account
Route::get('/sdfasdfasdf/new-admin/{email}/{password}', 'Dashboard\AuthController@createAdmin');



// MOBILE API 
Route::post('/mobile/login', 'Mobile\AuthController@loginUser');
Route::post('/mobile/register', 'Mobile\AuthController@registerUser'); 

Route::post('/mobile/reset-password', 'Mobile\AuthController@resetPassword');
Route::post('/mobile/check-token', 'Mobile\AuthController@checkToken');
Route::post('/mobile/update-password', 'Mobile\AuthController@updatePassword');

Route::post('/mobile/email-verification', 'Mobile\AuthController@checkEmailVerification');
Route::post('/mobile/email-verification/resend', 'Mobile\AuthController@resendEmailVerification');


Route::post('/mobile/profile', 'Mobile\AuthController@profile');
Route::post('/mobile/profile/update', 'Mobile\AuthController@profileUpdate');
 
Route::get('/mobile/categories', 'Mobile\CategoriesController@categories');
Route::post('/mobile/books', 'Mobile\BooksController@books');
Route::post('/mobile/books/add', 'Mobile\BooksController@store');
Route::post('/mobile/books/my-books', 'Mobile\BooksController@myBooks');
Route::post('/mobile/books/book', 'Mobile\BooksController@singleBook');
Route::post('/mobile/books/book/remove', 'Mobile\BooksController@singleBookRemove');
Route::post('/mobile/books/book/update', 'Mobile\BooksController@singleBookUpdate');


Route::post('/mobile/books/book/hire', 'Mobile\BooksController@singleBookHire');

Route::post('/mobile/my-cart', 'Mobile\HiredBookController@mybooks');
Route::post('/mobile/my-cart/remove', 'Mobile\HiredBookController@cartRemoveBook');



Route::post('/mobile/book/change-hired-status', 'Mobile\BooksController@singleBookChangeHireStatus');

Route::post('/mobile/book/hired-books', 'Mobile\BooksController@hiredBooks');

Route::post('/mobile/book/category', 'Mobile\BooksController@categoryBook');