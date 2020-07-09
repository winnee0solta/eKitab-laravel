<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Books extends Model
{
    protected $fillable = [
        'user_id',
        'image',
        'book',
        'price',
        'author',
        'detail',
        'category_id',
        'category',
    ];
}
