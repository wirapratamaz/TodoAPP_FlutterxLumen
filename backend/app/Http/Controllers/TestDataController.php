<?php

namespace App\Http\Controllers;

class TestDataController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function index(){
        $message = "call TestDataController";
        return response()->json(["message" => $message], 200);
    }

    //
}
