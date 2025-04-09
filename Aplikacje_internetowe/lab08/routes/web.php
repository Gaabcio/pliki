<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\TripController;
use App\Http\Controllers\CountryController;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

Route::get('/', function () {
    return view('welcome');
});

Route::controller(TripController::class)->group(function () {
    Route::get('/trips', 'index')->name('trips.index');
    Route::get('/trips/{id}', 'show')->name('trips.show');
    Route::get('/trips/{id}/edit', 'edit')->name('trips.edit');
    Route::put('/trips/{id}', 'update')->name('trips.update');
});

Route::resource('countries', CountryController::class);

Route::controller(AuthController::class)->group(function () {
    Route::get('/auth/login', 'login')->name('login');
    Route::post('/auth/login', 'authenticate')->name('login.authenticate');
    Route::get('/auth/logout', 'logout')->name('logout');
});
