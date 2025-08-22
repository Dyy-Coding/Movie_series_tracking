<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreRatingRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth()->check(); // Ensure user is authenticated
    }

    public function rules(): array
    {
        return [
            'movie_id' => 'required|exists:movies,id',
            'rating' => 'required|numeric|between:0,10',
        ];
    }
}