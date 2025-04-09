<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Trip;
use App\Models\Country;
use Illuminate\Support\Facades\Gate;

class TripController extends Controller
{
    public function index()
    {
        $trips = Trip::all();
        return view('trips.index', [
            'trips' => $trips,
            'randomTrips' => $trips->random(4),
        ]);
    }

    public function show($id)
    {
        return view('trips.show', [
            'trip' => Trip::findOrFail($id)
        ]);
    }

    public function edit($id)
    {
        $trip = Trip::findOrFail($id);
        return view('trips.edit', [
            'trip' => $trip,
            'countries' => Country::all()
        ]);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|unique:trips,name,'.$id,
            'continent' => 'required|string',
            'period' => 'required|integer|min:0',
            'price' => 'required|numeric|min:0',
            'img' => 'required|string',
            'country_id' => 'required|integer|exists:countries,id',
        ]);

        $trip = Trip::findOrFail($id);
        $input = $request->all();
        $trip->update($input);
        return redirect()->route('trips.index');
    }
}
