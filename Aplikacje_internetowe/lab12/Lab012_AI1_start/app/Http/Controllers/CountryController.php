<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class CountryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $countries = DB::table('countries')->get();

        $countriesCollection = [];
        foreach ($countries as $country) {
            $countriesCollection[] = [
                'id' => $country->id,
                'code' => $country->code,
                'currency' => $country->currency,
                'area' => $country->area,
                'language' => $country->language,
            ];
        }

        return $countriesCollection; // 200
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $inputs = [
            'name' => $request->input('name'),
            'code' => $request->input('code'),
            'currency' => $request->input('currency'),
            'area' => $request->input('area'),
            'language' => $request->input('language')
        ];

        $rules = [
            'name' => 'required|string|unique:countries,name,|max:50',
            'code' => 'required|string|unique:countries,code,|max:3',
            'currency' => 'required|string|max:30',
            'area' => 'required|integer|min:0',
            'language' => 'required|string|max:50',
        ];

        $validator = Validator::make($inputs, $rules);
        if($validator->fails()) {
            return response($validator->errors(), 422); //lub 400
        }

        $id = DB::table('countries')->insertGetId($inputs);

        $country = DB::table('countries')->find($id);

        $country_resource = [
            'id' => $country->id,
            'code' => $country->code,
            'currency' => $country->currency,
            'area' => $country->area,
            'language' => $country->language,
        ];

        return response()->json($country_resource, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $country = DB::table('countries')->find($id);
        if ($country == null) {
            return response(null, 404);
        }

        $countryResource = [
            'id' => $country->id,
            'code' => $country->code,
            'currency' => $country->currency,
            'area' => $country->area,
            'language' => $country->language,
        ];

        return $countryResource; // 200
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $country = DB::table('countries')->find($id);
        if ($country == null) {
            return response(null, 404);
        }

        $inputs = [
            'name' => $request->input('name'),
            'code' => $request->input('code'),
            'currency' => $request->input('currency'),
            'area' => $request->input('area'),
            'language' => $request->input('language')
        ];

        $rules = [
            'name' => 'required|string|unique:countries,name,'.$id.'|max:50',
            'code' => 'required|string|unique:countries,code,'.$id.'|max:3',
            'currency' => 'required|string|max:30',
            'area' => 'required|integer|min:0',
            'language' => 'required|string|max:50',
        ];

        $validator = Validator::make($inputs, $rules);
        if($validator->fails()) {
            return response($validator->errors(), 422); //lub 400
        }

        DB::table('countries')->where('id', $id)->update($inputs);

        $country = DB::table('countries')->find($id);

        $countryResource = [
            'id' => $country->id,
            'code' => $country->code,
            'currency' => $country->currency,
            'area' => $country->area,
            'language' => $country->language,
        ];

        return $countryResource; // 200
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $country = DB::table('countries')->find($id);
        if ($country == null) {
            return response(null, 404);
        }

        DB::table('countries')->delete($id);

        return response()->json(null, 204);
    }
}
