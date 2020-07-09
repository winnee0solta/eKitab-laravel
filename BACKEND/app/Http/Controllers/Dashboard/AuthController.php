<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\User;
use App\UserVerifiedData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;

class AuthController extends Controller
{
    public function loginView()
    {
        if (Auth::check()) {
            //get type
            switch (Auth::user()->type) {
                case 'admin':
                    return redirect('/dashboard');
                    break;
                default:
                    return redirect('/');
                    break;
            }
        }

        return view('auth.login');
    }

    public function createAdmin($email, $password)
    {

        if (User::where('email', $email)->count() == 0) {

            User::create([
                'email' => $email,
                'password' => bcrypt($password),
                'type' => 'admin'
            ]);
            return Response(array(
                'message' => 'Created'
            ));
        } else {
            return Response(array(
                'message' => 'already exists'
            ));
        }
    }

    /**
     * Login User
     */
    public function loginUser(Request $request)
    {


        $this->validate($request, [
            'email' => 'required',
            'password' => 'required'
        ]);


        $user = User::where('email', $request->email)->first();
        if ($user) {

            if (Hash::check($request->password, $user->password)) {
                // The passwords match...
                //check if rehash needed
                if (Hash::needsRehash($user->password)) {
                    $user->password = Hash::make($request->password);
                    $user->save();
                }

                //Authenticate
                auth()->attempt([
                    'email' => request('email'),
                    'password' => request('password')
                ]);

                //get type
                switch ($user->type) {
                    case 'admin':
                        return redirect('/dashboard');
                        break;
                    default:
                        auth()->logout();
                        return Redirect::back()->withErrors(['Invalid Credentials.']);
                        break;
                }
            } else {
                return Redirect::back()->withErrors(['Invalid Credentials.']);
            }
            return back();
        }



        return redirect('/');
    }
    public function logout()
    {
        auth()->logout();
        return redirect('/login');
    }

    public function verifyEmail(Request $request)
    {

        if (!empty($request->id)) {
            $user =  User::find($request->id);
            if ($user) { 
                //check if already verified
                if (UserVerifiedData::where('user_id', $request->id)->count() == 0) {
                    $verdata = new  UserVerifiedData();
                    $verdata->user_id = $request->id;
                    $verdata->save();
                    return view('verified');
                }
            }
            return redirect('/404');
        }
    }

}
