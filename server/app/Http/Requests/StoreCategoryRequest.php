<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; // Adjust with auth if needed
    }

    public function rules(): array
    {
        return [
            'name' => 'required|string|max:200|unique:categories,name',
            'description' => 'nullable|string',
        ];
    }
}
