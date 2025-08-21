<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AssignCategoryToBookRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'category_id' => 'required|exists:categories,id',
            'is_primary' => 'sometimes|boolean',
            'notes' => 'nullable|string',
            'assigned_at' => 'nullable|date',
        ];
    }
}
