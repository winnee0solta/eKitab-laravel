<?php

namespace App\Http\Controllers\Mobile;

use App\Categories;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class CategoriesController extends Controller
{
    //send all categories
    public function categories()
    {  
        $response = array(
            'status' => 200,
            'message' => 'OK',
            'categories' => Categories::all()
        );

        return Response($response);
    }
}
