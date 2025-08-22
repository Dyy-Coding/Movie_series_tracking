<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Movie extends Model
{
    use HasFactory;

    protected $fillable = [
        'title', 'description', 'release_date', 'poster_image', 'backdrop_image',
        'type', 'duration', 'seasons', 'episodes', 'director', 'cast',
        'tmdb_id', 'average_rating', 'vote_count'
    ];

    protected $casts = [
        'cast' => 'array',
        'release_date' => 'date',
    ];

    public function genres()
    {
        return $this->belongsToMany(Genre::class, 'movie_genre');
    }

    public function ratings()
    {
        return $this->hasMany(Rating::class);
    }

    public function reviews()
    {
        return $this->hasMany(Review::class);
    }

    public function watchlists()
    {
        return $this->hasMany(Watchlist::class);
    }

    // Method to update average rating after new rating
    public function updateAverageRating()
    {
        $this->average_rating = $this->ratings()->average('rating') ?? 0;
        $this->vote_count = $this->ratings()->count();
        $this->save();
    }
}