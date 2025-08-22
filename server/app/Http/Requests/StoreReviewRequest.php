<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreReviewRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth()->check();
    }

    public function rules(): array
    {
        return [
            'movie_id' => 'required|exists:movies,id',
            'title' => 'nullable|string|max:255',
            'review' => 'nullable|string|max:5000',
        ];
    }
}