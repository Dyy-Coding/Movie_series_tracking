<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BookResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'               => $this->id,
            'cover_image'      => $this->cover_image,
            'image_url'        => $this->image_url,  // from accessor
            'isbn'             => $this->isbn,
            'title'            => $this->title,
            'author'           => new AuthorResource($this->whenLoaded('author')),
            'publication_year' => $this->publication_year,
            'number_of_copies' => $this->number_of_copies,
            'category'         => $this->category,
            'priority'         => $this->priority,
            'created_at'       => $this->created_at?->toDateTimeString(),
            'updated_at'       => $this->updated_at?->toDateTimeString(),
        ];
    }
}
