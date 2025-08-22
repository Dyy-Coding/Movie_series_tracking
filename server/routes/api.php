<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\GenreController;
use App\Http\Controllers\Api\MovieController;
use App\Http\Controllers\Api\RatingController;
use App\Http\Controllers\Api\ReviewController;
use App\Http\Controllers\Api\WatchlistController;
use App\Http\Controllers\Api\Authentication\AuthApiController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| All routes are prefixed with '/api/v1' for versioning.
| Authentication uses Laravel Sanctum for secure token-based access.
| Routes are grouped logically for better organization and maintainability.
|
*/

Route::prefix('v1')->group(function () {
    /*
    |--------------------------------------------------------------------------
    | Authentication Routes
    |--------------------------------------------------------------------------
    */
    Route::prefix('auth')->as('auth.')->group(function () {
        // Public endpoints
        Route::post('/register', [AuthApiController::class, 'register'])->name('register');
        Route::post('/login', [AuthApiController::class, 'login'])->name('login');

        // Protected endpoints - require Sanctum authentication
        Route::middleware('auth:sanctum')->group(function () {
            Route::post('/logout', [AuthApiController::class, 'logout'])->name('logout');
            Route::get('/profile', [AuthApiController::class, 'profile'])->name('profile');
            Route::put('/profile', [AuthApiController::class, 'update'])->name('update');
            Route::delete('/profile', [AuthApiController::class, 'destroy'])->name('destroy');
        });
    });

    /*
    |--------------------------------------------------------------------------
    | Movie Routes
    |--------------------------------------------------------------------------
    */
    Route::apiResource('movies', MovieController::class)->except(['update'])->middleware('auth:sanctum');
    Route::put('movies/{movie}', [MovieController::class, 'update'])->name('movies.update')->middleware(['auth:sanctum', 'role:admin']); // Admin-only

    /*
    |--------------------------------------------------------------------------
    | Genre Routes
    |--------------------------------------------------------------------------
    */
    Route::apiResource('genres', GenreController::class)->except(['store', 'update', 'destroy']);
    Route::middleware(['auth:sanctum', 'role:admin'])->group(function () {
        Route::post('genres', [GenreController::class, 'store'])->name('genres.store');
        Route::put('genres/{genre}', [GenreController::class, 'update'])->name('genres.update');
        Route::delete('genres/{genre}', [GenreController::class, 'destroy'])->name('genres.destroy');
    });

    /*
    |--------------------------------------------------------------------------
    | Rating Routes
    |--------------------------------------------------------------------------
    */
    Route::apiResource('ratings', RatingController::class)
        ->except(['update'])
        ->middleware('auth:sanctum');

    /*
    |--------------------------------------------------------------------------
    | Review Routes
    |--------------------------------------------------------------------------
    */
    Route::apiResource('reviews', ReviewController::class)
        ->except(['update'])
        ->middleware('auth:sanctum');

    /*
    |--------------------------------------------------------------------------
    | Watchlist Routes
    |--------------------------------------------------------------------------
    */
    Route::apiResource('watchlists', WatchlistController::class)
        ->except(['update'])
        ->middleware('auth:sanctum');

    /*
    |--------------------------------------------------------------------------
    | Additional Utility Routes
    |--------------------------------------------------------------------------
    */
    Route::middleware('auth:sanctum')->group(function () {
        Route::get('movies/popular', [MovieController::class, 'popular'])->name('movies.popular'); // Popular movies based on ratings
        Route::get('movies/recommended', [MovieController::class, 'recommended'])->name('movies.recommended'); // Based on user watchlist/genres
        Route::get('watchlists/watched', [WatchlistController::class, 'watched'])->name('watchlists.watched'); // Watched items
    });
});

// Fallback for invalid routes
Route::fallback(function () {
    return response()->json([
        'message' => 'Route not found.',
        'status' => 404,
    ], 404);
});