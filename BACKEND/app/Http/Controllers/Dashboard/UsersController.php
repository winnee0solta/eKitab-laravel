<?php

namespace App\Http\Controllers\Dashboard;

use App\Books;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Http\Request;

class UsersController extends Controller
{
    public function index()
    {
        $users = User::orderBy('created_at', 'desc')->get();

        return view('dashboard.users.index', compact(
            'users'
        ));
    }

    public function remove(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
        ]);

        $user = User::find($request->id);
        if ($user) {

            Books::where('user_id',$user->id)->delete(); 
            $user->delete();
        }

        return redirect('/dashboard/users');
    }

}
