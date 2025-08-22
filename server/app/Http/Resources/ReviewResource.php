<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ReviewResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'user_id' => $this->user_id,
            'movie_id' => $this->movie_id,
            'title' => $this->title,
            'review' => $this->review,
            'likes' => $this->likes,
            'created_at' => $this->created_at->toIso8601String(),
        ];
    }
}