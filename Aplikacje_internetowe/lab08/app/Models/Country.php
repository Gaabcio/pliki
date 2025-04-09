<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Country extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'code', 'currency', 'area', 'language'];

    public $timestamps = false;

    public function trips(): HasMany
    {
        return $this->hasMany(Trip::class);
    }
}
