<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreRatingRequest;
use App\Http\Resources\RatingResource;
use App\Models\Rating;
use Illuminate\Http\Request;

class RatingController extends Controller
{
    public function index(Request $request)
    {
        $ratings = Rating::with(['user', 'movie'])->paginate(20);
        return RatingResource::collection($ratings);
    }

    public function store(StoreRatingRequest $request)
    {
        $rating = Rating::updateOrCreate(
            ['user_id' => auth()->id(), 'movie_id' => $request->movie_id],
            ['rating' => $request->rating]
        );
        return new RatingResource($rating);
    }

    public function show(Rating $rating)
    {
        $rating->load(['user', 'movie']);
        return new RatingResource($rating);
    }

    public function destroy(Rating $rating)
    {
        $this->authorize('delete', $rating);
        $rating->delete();
        return response()->json(null, 204);
    }
}