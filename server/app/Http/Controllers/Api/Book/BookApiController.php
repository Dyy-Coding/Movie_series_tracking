<?php

namespace App\Http\Controllers\Api\Book;

use App\Http\Controllers\Controller;
use App\Http\Requests\BookRequest\BookPostStore;
use App\Http\Resources\BookResource;
use App\Models\BookModel;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Throwable;

class BookApiController extends Controller
{
    /**
     * Display a paginated listing of books with their authors.
     */
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->get('per_page', 5);

        try {
            $books = BookModel::with('author')
                ->orderBy('created_at', 'desc')
                ->paginate($perPage);

            return $this->successResponse(
                BookResource::collection($books),
                'Books retrieved successfully.',
                200,
                [
                    'current_page' => $books->currentPage(),
                    'last_page'    => $books->lastPage(),
                    'per_page'     => $books->perPage(),
                    'total'        => $books->total(),
                ]
            );
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to retrieve books.', $e);
        }
    }

    /**
     * Store a newly created book in storage.
     */
    public function store(BookPostStore $request): JsonResponse
    {
        try {
            $book = BookModel::create($request->validated());

            return $this->successResponse(new BookResource($book), 'Book created successfully.', 201);
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to create book.', $e);
        }
    }

    /**
     * Display the specified book with author details.
     */
    public function show(int $id): JsonResponse
    {
        try {
            $book = BookModel::with('author')->findOrFail($id);

            return $this->successResponse(new BookResource($book), 'Book found.');
        } catch (Throwable $e) {
            return $this->errorResponse('Book not found.', $e, 404);
        }
    }

    /**
     * Update the specified book in storage.
     */
    public function update(BookPostStore $request, int $id): JsonResponse
    {
        try {
            $book = BookModel::findOrFail($id);
            $book->update($request->validated());

            return $this->successResponse(new BookResource($book), 'Book updated successfully.');
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to update book.', $e);
        }
    }

    /**
     * Remove the specified book from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        try {
            $book = BookModel::findOrFail($id);
            $book->delete();

            return $this->successResponse(null, 'Book deleted successfully.');
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to delete book.', $e);
        }
    }

    /**
     * Standardized success JSON response.
     *
     * @param mixed $data
     * @param string $message
     * @param int $status
     * @param array $meta
     * @return JsonResponse
     */
    private function successResponse($data, string $message, int $status = 200, array $meta = []): JsonResponse
    {
        $response = [
            'success' => true,
            'message' => $message,
            'data'    => $data,
        ];

        if (!empty($meta)) {
            $response['meta'] = $meta;
        }

        return response()->json($response, $status);
    }

    /**
     * Standardized error JSON response with logging.
     *
     * @param string $message
     * @param Throwable $exception
     * @param int $status
     * @return JsonResponse
     */
    private function errorResponse(string $message, Throwable $exception, int $status = 500): JsonResponse
    {
        Log::error($message . ' - ' . $exception->getMessage());

        return response()->json([
            'success' => false,
            'message' => $message,
            'error'   => config('app.debug') ? $exception->getMessage() : 'An error occurred',
        ], $status);
    }
}
