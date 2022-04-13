<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\User;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/



    Route::get('/{age}', function ($age) {
        // Uses first & second middleware...
        echo $age;
    //   return [1, 2, 3]; 
    })->where('id', '[0-9]+');

    Route::get('/users/{age?}', function ($age = 17) {

        return $age;
    })->middleware('checkage');


   
