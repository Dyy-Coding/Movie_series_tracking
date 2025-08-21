<?php

namespace App\Http\Controllers\Api\Category;

use App\Http\Controllers\Controller;
use App\Http\Requests\AssignCategoryToBookRequest;
use App\Models\BookModel;
use App\Models\Category;
use Illuminate\Http\JsonResponse;

class BookCategoryController extends Controller
{
    /**
     * Display categories assigned to the given book.
     */
    public function index(BookModel $book): JsonResponse
    {
        $categories = $book->categories()->get();

        return response()->json($categories);
    }

    /**
     * Assign a category to the given book.
     */
    public function store(AssignCategoryToBookRequest $request, BookModel $book): JsonResponse
    {
        $data = $request->validated();

        $book->categories()->syncWithoutDetaching([
            $data['category_id'] => [
                'is_primary' => $data['is_primary'] ?? false,
                'notes' => $data['notes'] ?? null,
                'assigned_at' => $data['assigned_at'] ?? null,
            ],
        ]);

        return response()->json(['message' => 'Category assigned successfully'], 201);
    }

    /**
     * Remove a category from the given book.
     */
    public function destroy(BookModel $book, Category $category): JsonResponse
    {
        $book->categories()->detach($category->id);

        return response()->json(['message' => 'Category removed successfully'], 200);
    }
}
