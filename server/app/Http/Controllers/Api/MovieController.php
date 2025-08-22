<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreMovieRequest;
use App\Http\Requests\UpdateMovieRequest;
use App\Http\Resources\MovieResource;
use App\Models\Movie;
use Illuminate\Http\Request;

class MovieController extends Controller
{
    protected function successResponse($data = null, $message = 'Success', $code = 200)
    {
        return response()->json([
            'success' => true,
            'message' => $message,
            'data'    => $data,
        ], $code);
    }

    protected function errorResponse($message = 'Error', $errors = null, $code = 400)
    {
        return response()->json([
            'success' => false,
            'message' => $message,
            'errors'  => $errors,
        ], $code);
    }

    public function index(Request $request)
    {
        $movies = Movie::with('genres')->paginate(20);
        return $this->successResponse(
            MovieResource::collection($movies),
            'Movies retrieved successfully'
        );
    }

    public function store(StoreMovieRequest $request)
    {
        $movie = Movie::create($request->validated());

        if ($request->has('genre_ids')) {
            $movie->genres()->attach($request->genre_ids);
        }

        return $this->successResponse(
            new MovieResource($movie->load('genres')),
            'Movie created successfully',
            201
        );
    }

    public function show(Movie $movie)
    {
        $movie->load('genres', 'ratings', 'reviews');
        return $this->successResponse(
            new MovieResource($movie),
            'Movie retrieved successfully'
        );
    }

    public function update(UpdateMovieRequest $request, Movie $movie)
    {
        $movie->update($request->validated());

        if ($request->has('genre_ids')) {
            $movie->genres()->sync($request->genre_ids);
        }

        return $this->successResponse(
            new MovieResource($movie->load('genres')),
            'Movie updated successfully'
        );
    }

    public function destroy(Movie $movie)
    {
        $movie->delete();
        return $this->successResponse(null, 'Movie deleted successfully', 204);
    }
}
