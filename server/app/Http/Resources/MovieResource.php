<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MovieResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'description' => $this->description,
            'release_date' => $this->release_date?->format('Y-m-d'),
            'poster_image' => $this->poster_image,
            'backdrop_image' => $this->backdrop_image,
            'type' => $this->type,
            'duration' => $this->duration,
            'seasons' => $this->seasons,
            'episodes' => $this->episodes,
            'director' => $this->director,
            'cast' => $this->cast,
            'tmdb_id' => $this->tmdb_id,
            'average_rating' => round($this->average_rating, 1),
            'vote_count' => $this->vote_count,
            'genres' => GenreResource::collection($this->genres), // Nested resources for mobile parsing
        ];
    }
}