<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $categoryId = $this->route('category')->id;

        return [
            'name' => 'required|string|max:200|unique:categories,name,' . $categoryId,
            'description' => 'nullable|string',
        ];
    }
}
