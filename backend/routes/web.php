<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('/test-alamat', function () use ($router) {
    return "lagi coba test alamat";
});

$router->get('/test', function () use ($router) {
    return "test endpoint creation";
});

$router->get('/show-index', 'GetDataController@index');
$router->post('/create-data', 'GetDataController@createData');
$router->get('/get-data-id/{id}', 'GetDataController@getDataByID');
$router->put('/update-data/{id}', 'GetDataController@updateData');
$router->delete('/delete-data/{id}', 'GetDataController@deleteData');
