<?php

namespace App\Http\Controllers;

//http needs
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

//model needs
use App\Models\TBData;

class GetDataController extends Controller
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
        $results = TBData::orderBy('id', 'DESC')->get();
        return response()->json(['data' => $results]);
    }

    public function getDataByID($id) {
        $results = TBData::find($id);
        return response()->json(['data' => $results]);
    }

    public function createData(Request $request){
        try{
            $tb_data = new TBData();
            $tb_data->name = $request->title;
            $tb_data->description = 'User Admin';
            $tb_data->save();
            return response()->json(['title' => $request->title, "id" => $tb_data->id],201); 
        } catch (\Exception $e) {
            // Dump error log
            error_log('Failed to save data: ' . $e->getMessage());
            // Return internal server error response
            return response()->json([
                'message' => 'Internal Server Error',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function updateData(Request $request, $id){
        try{
            $tb_data = TBData::find($id);
            if($tb_data){
                $tb_data->name = $request->name;
                $tb_data->save();
                return response()->json([
                    "id" => (int) $id,
                    "name" => $request->name
                ],200);
            }else{
                return response()->json([
                    "message" => "Data not found" 
                ],204);
            }
            
            
        } catch (\Exception $e) {
            error_log('Failed to save data: ' . $e->getMessage());
            return response()->json([
                "message" => 'Internal Server Error',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
        
    }

    public function deleteData($id){
        try{
            // $id = $request->id;
            $tb_data = TBData::find($id);
            if($tb_data){
                $tb_data->delete();
                return response()->json([
                    "id" => $id
                ],200);
            }else{
                return response()->json([
                    "message" => "Data not found" 
                ],204);
            }
        } catch (\Exception $e) {
            error_log('Failed to save data: ' . $e->getMessage());
            return response()->json([
                "message" => 'Internal Server Error',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
        
    }
}
