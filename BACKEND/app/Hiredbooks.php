<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Hiredbooks extends Model
{
   protected $fillable = [
        'book_id',
        'renter_id',
        'hirer_id',
        'approved', 
    ];
} 