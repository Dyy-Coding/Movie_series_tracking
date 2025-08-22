<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreWatchlistRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth()->check();
    }

    public function rules(): array
    {
        return [
            'movie_id' => 'required|exists:movies,id',
            'watched' => 'boolean',
            'progress' => 'integer|min:0',
            'priority' => 'in:low,medium,high',
        ];
    }
}