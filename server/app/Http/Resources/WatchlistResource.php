<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class WatchlistResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'user_id' => $this->user_id,
            'movie_id' => $this->movie_id,
            'watched' => $this->watched,
            'progress' => $this->progress,
            'priority' => $this->priority,
            'created_at' => $this->created_at->toIso8601String(),
            'movie' => new MovieResource($this->whenLoaded('movie')),
        ];
    }
}