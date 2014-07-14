<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/

Route::get('/', 'HomeController@showHome');
/*
Route::get('login', 'AuthController@showLogin');
Route::post('login', 'AuthController@postLogin');
Route::get('logout', 'AuthController@getLogout');

Route::get('create-user', 'UserController@showCreate');
Route::post('create-user', 'UserController@store');

Route::group(array('before' => 'auth'), function()
{
	//Route::get('/', 'HomeController@showHome');
	Route::get('view-map-list', 'MapsController@showList');
});
*/
Route::get('step-1', 'MapCreationController@index');
Route::post('step-2', 'MapCreationController@searchMap');
Route::post('step-3', 'MapCreationController@storeMap');
Route::get('map/{id}', 'MapCreationController@viewMap');