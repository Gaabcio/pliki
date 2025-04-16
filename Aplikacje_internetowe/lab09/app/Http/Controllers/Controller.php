<?php

namespace App\Http\Controllers;

abstract class Controller
{
    public function arrayRemoveValue(&$array, $targetValue) {
        foreach ($array as $key => $value){
            if ($value == $targetValue) {
                unset($array[$key]);
            }
        }
    }
}
