<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Authentication\AuthApiController;
use App\Http\Controllers\Api\Author\AuthorApiController;
use App\Http\Controllers\Api\Book\BookApiController;
use App\Http\Controllers\Api\Category\BookCategoryController;
use App\Http\Controllers\Api\Category\CategoryController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| All routes are automatically prefixed with '/api'.
| You can enable versioning by uncommenting the 'v1' prefix group.
|
*/

// Optional: API versioning for future-proofing
// Route::prefix('v1')->group(function () {

    /*
    |--------------------------------------------------------------------------
    | Authentication Routes
    |--------------------------------------------------------------------------
    */
    Route::prefix('auth')->group(function () {
        // Public endpoints
        Route::post('/register', [AuthApiController::class, 'register']);
        Route::post('/login', [AuthApiController::class, 'login']);

        // Protected endpoints - require Sanctum token
        Route::middleware('auth:sanctum')->group(function () {
            Route::post('/logout', [AuthApiController::class, 'logout']);
            Route::get('/users', [AuthApiController::class, 'index']);
            Route::get('/profile', [AuthApiController::class, 'profile']);
            Route::put('/update', [AuthApiController::class, 'update']);
            Route::delete('/destroy', [AuthApiController::class, 'destroy']);
        });
    });

    /*
    |--------------------------------------------------------------------------
    | Author, Book, Category Resources
    |--------------------------------------------------------------------------
    | Using apiResource to generate standard RESTful API endpoints.
    */
    Route::apiResource('authors', AuthorApiController::class);
    Route::apiResource('books', BookApiController::class);
    Route::apiResource('categories', CategoryController::class);

    /*
    |--------------------------------------------------------------------------
    | Book-Category Relationship Routes (Nested)
    |--------------------------------------------------------------------------
    | Manage categories assigned to specific books.
    */
    Route::prefix('books/{book}')->whereNumber('book')->group(function () {
        Route::get('categories', [BookCategoryController::class, 'index']);
        Route::post('categories', [BookCategoryController::class, 'store']);
        Route::delete('categories/{category}', [BookCategoryController::class, 'destroy'])
            ->whereNumber('category');
    });

// }); // End versioning group if enabled

