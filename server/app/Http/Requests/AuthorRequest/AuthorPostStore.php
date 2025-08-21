<?php

namespace App\Http\Requests\AuthorRequest;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Contracts\Validation\Validator;

class AuthorPostStore extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $validator->errors(),
            ], 422)
        );
    }

    public function rules(): array
    {
        return [
            'name'               => ['required', 'string', 'max:50'],
            'bio'                => ['nullable', 'string', 'max:1000'],
            'dateofbirth'        => ['required', 'date', 'before:today'],
            'nationality'        => ['required', 'string', 'max:100'],
            'numberOfWrittenBook'=> ['required', 'integer', 'min:0'],
            'image'              => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp,gif', 'max:2048'],
        ];
    }

    public function messages(): array
    {
        return [
            'name.required'                 => 'Author name is required.',
            'name.string'                   => 'Author name must be a string.',
            'name.max'                      => 'Author name must not exceed 50 characters.',
            'bio.string'                    => 'Bio must be a string.',
            'bio.max'                       => 'Bio must not exceed 1000 characters.',
            'dateofbirth.required'          => 'Date of birth is required.',
            'dateofbirth.date'              => 'Date of birth must be a valid date.',
            'dateofbirth.before'            => 'Date of birth must be before today.',
            'nationality.required'          => 'Nationality is required.',
            'nationality.string'            => 'Nationality must be a string.',
            'nationality.max'               => 'Nationality must not exceed 100 characters.',
            'numberOfWrittenBook.required'  => 'Number of written books is required.',
            'numberOfWrittenBook.integer'   => 'Number of written books must be a number.',
            'numberOfWrittenBook.min'       => 'Number of written books cannot be negative.',
            'image.image'                   => 'The file must be an image.',
            'image.mimes'                   => 'Allowed image types: jpeg, png, jpg, webp, gif.',
            'image.max'                     => 'Image size must not exceed 2MB.',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'name'               => is_string($this->name) ? trim($this->name) : null,
            'bio'                => is_string($this->bio) ? trim($this->bio) : null,
            'nationality'        => is_string($this->nationality) ? trim($this->nationality) : null,
            'numberOfWrittenBook'=> is_numeric($this->numberOfWrittenBook) ? (int) $this->numberOfWrittenBook : null,
            // dateofbirth can be trusted as is or cast in Model
        ]);
    }
}
