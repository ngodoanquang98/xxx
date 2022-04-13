<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class User extends Controller
{
    public function show(Request $request)
    {
        $uri = $request->validate;
       // dd($uri);
       if ($request->missing('name')) {
        //
        echo "ko cos";
       }
       else{
           echo "xxxxxxx";
       }
       $pathToFile="file:///C:/Users/qnd/Desktop/ANS/js-quang/ajax.html";
       return $uri;
    }
    public function store(Request $request, $id)
    {
        $name = $request->input('name');
       // dd($name);
        return $id;
    }
    
}
