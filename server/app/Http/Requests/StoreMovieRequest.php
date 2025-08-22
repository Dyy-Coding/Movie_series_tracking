<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreMovieRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; // You can check user permissions here if needed
    }

    public function rules(): array
    {
        return [
            'title'         => 'required|string|max:255',
            'description'   => 'nullable|string',
            'release_date'  => 'nullable|date',
            'poster_image'  => 'nullable|url',
            'backdrop_image'=> 'nullable|url',
            'type'          => 'required|in:movie,series',
            'duration'      => 'nullable|integer|min:0',
            'seasons'       => 'nullable|integer|min:0',
            'episodes'      => 'nullable|integer|min:0',
            'director'      => 'nullable|string|max:255',
            'cast'          => 'nullable|array',
            'tmdb_id'       => 'nullable|string|max:255',
            'genre_ids'     => 'nullable|array',
            'genre_ids.*'   => 'exists:genres,id',
        ];
    }

    public function messages(): array
    {
        return [
            'title.required'   => 'The movie title is required.',
            'title.max'        => 'The movie title must not be longer than 255 characters.',
            'type.required'    => 'The movie type (movie or series) is required.',
            'type.in'          => 'The type must be either movie or series.',
            'poster_image.url' => 'Poster image must be a valid URL.',
            'backdrop_image.url' => 'Backdrop image must be a valid URL.',
            'genre_ids.array'  => 'Genres must be provided as an array of IDs.',
            'genre_ids.*.exists' => 'One or more selected genres are invalid.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(
            response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $validator->errors(),
            ], 422)
        );
    }
}
