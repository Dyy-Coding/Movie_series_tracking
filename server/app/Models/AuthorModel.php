<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class AuthorModel extends Model
{
    use HasFactory;

    // Define the table name explicitly
    protected $table = 'authors';

    // Specify the fillable columns for mass assignment

    protected $fillable = [
        'name',
        'dateofbirth',
        'nationality',
        'numberOfWrittenBook',
        'image'
    ];

    protected $appends = ['image_url'];

    public function getImageUrlAttribute()
        {
            return $this->image
                ? url($this->image)
                : null;
        }


    // Relationship: Author has many books
    public function books(): HasMany
    {
        return $this->hasMany(BookModel::class, 'author_id');
    }
}
