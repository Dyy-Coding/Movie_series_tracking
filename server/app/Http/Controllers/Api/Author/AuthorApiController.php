<?php

namespace App\Http\Controllers\Api\Author;

use App\Http\Controllers\Controller;
use App\Http\Requests\AuthorRequest\AuthorPostStore;
use App\Http\Resources\AuthorResource;
use App\Models\AuthorModel;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Throwable;

class AuthorApiController extends Controller
{
    /**
     * Display a paginated listing of authors with their books.
     */
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->get('per_page', 5);

        try {
            $authors = AuthorModel::with(['books' => fn($query) => $query->orderBy('id', 'desc')])
                ->orderBy('created_at', 'desc')
                ->paginate($perPage);

            return $this->successResponse(
                AuthorResource::collection($authors),
                'Authors fetched successfully.',
                200,
                [
                    'current_page' => $authors->currentPage(),
                    'last_page'    => $authors->lastPage(),
                    'per_page'     => $authors->perPage(),
                    'total'        => $authors->total(),
                ]
            );
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to fetch authors.', $e);
        }
    }

    /**
     * Store a newly created author in storage.
     */
    public function store(AuthorPostStore $request): JsonResponse
    {
        try {
            $author = AuthorModel::create($request->validated());

            return $this->successResponse(new AuthorResource($author), 'Author created successfully.', 201);
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to create author.', $e);
        }
    }

    /**
     * Display the specified author with books.
     */
    public function show(int $id): JsonResponse
    {
        try {
            $author = AuthorModel::with('books')->findOrFail($id);

            return $this->successResponse(new AuthorResource($author), 'Author retrieved successfully.');
        } catch (Throwable $e) {
            return $this->errorResponse('Author not found.', $e, 404);
        }
    }

    /**
     * Update the specified author in storage.
     */
    public function update(AuthorPostStore $request, int $id): JsonResponse
    {
        try {
            $author = AuthorModel::findOrFail($id);
            $author->update($request->validated());

            return $this->successResponse(new AuthorResource($author), 'Author updated successfully.');
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to update author.', $e);
        }
    }

    /**
     * Remove the specified author from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        try {
            $author = AuthorModel::findOrFail($id);

            try {
                $author->delete();
            } catch (QueryException $qe) {
                if ($qe->getCode() === '23000') { // Foreign key constraint violation
                    return response()->json([
                        'success' => false,
                        'message' => 'Cannot delete author due to existing related records. Remove related data first.',
                    ], 409);
                }
                throw $qe;
            }

            return $this->successResponse(null, 'Author deleted successfully.');
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to delete author.', $e);
        }
    }

    /**
     * Standardized success JSON response.
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
