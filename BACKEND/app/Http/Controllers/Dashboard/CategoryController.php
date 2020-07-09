<?php

namespace App\Http\Controllers\Dashboard;

use App\Categories;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Categories::orderBy('created_at', 'desc')->get();

        return view('dashboard.categories.index', compact(
            'categories'
        ));
    }
    public function add(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
        ]);

        if ($request->hasFile('image')) {

            $category = new Categories();
            $category->name = $request->name;
            $category->image = '-';
            $category->save();

            $file = $request->file('image');
            $file->move('images/categories', $category->id . '_category_img_.' . $file->getClientOriginalExtension());
            $category->image = $category->id . '_category_img_.' . $file->getClientOriginalExtension();
            $category->save();
        }

        return redirect('/dashboard/categories');
    }
    public function edit(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
            'name' => 'required',
        ]);

        $category = Categories::find($request->id);
        if ($category) {

            $category->name = $request->name;
            $category->save();

            if ($request->hasFile('image')) {

                $file = $request->file('image');
                $file->move('images/categories', $category->id . '_category_img_.' . $file->getClientOriginalExtension());
                $category->image = $category->id . '_category_img_.' . $file->getClientOriginalExtension();
                $category->save();
            }
        }

        return redirect('/dashboard/categories');
    }
    public function remove(Request $request)
    {
        $this->validate($request, [
            'id' => 'required',
        ]);

        $category = Categories::find($request->id);
        if ($category) {

            $category->delete();
        }

        return redirect('/dashboard/categories');
    }
}
