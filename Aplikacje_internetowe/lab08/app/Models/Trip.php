<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Trip extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'continent', 'period', 'description', 'price', 'img', 'country_id'];

    protected $attributes = [
        'period' => 7,
    ];

    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class);
    }
}
