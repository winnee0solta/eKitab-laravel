<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/', function () {
    return redirect('/login');
});
Route::get('/login', 'Dashboard\AuthController@loginView')->name('login');
Route::post('/login', 'Dashboard\AuthController@loginUser');
Route::get('/logout', 'Dashboard\AuthController@logout')->middleware(['auth']);

Route::get('/verify-email', 'Dashboard\AuthController@verifyEmail');




Route::middleware(['auth',])->group(function () {

    Route::get('/dashboard', function () {
        return redirect('/dashboard/books');
    });

    // BOOKS 
    Route::get('/dashboard/books', 'Dashboard\BooksController@index');
    Route::post('/dashboard/books/remove', 'Dashboard\BooksController@remove');

    //CATEGORIES
    Route::get('/dashboard/categories', 'Dashboard\CategoryController@index');
    Route::post('/dashboard/categories/add', 'Dashboard\CategoryController@add');
    Route::post('/dashboard/categories/edit', 'Dashboard\CategoryController@edit');
    Route::post('/dashboard/categories/remove', 'Dashboard\CategoryController@remove');


    //USERS
    Route::get('/dashboard/users', 'Dashboard\UsersController@index');
    Route::post('/dashboard/users/remove', 'Dashboard\UsersController@remove');
});
