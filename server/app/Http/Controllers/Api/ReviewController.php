<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreReviewRequest;
use App\Http\Resources\ReviewResource;
use App\Models\Review;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    public function index(Request $request)
    {
        $reviews = Review::with(['user', 'movie'])->paginate(20);
        return ReviewResource::collection($reviews);
    }

    public function store(StoreReviewRequest $request)
    {
        $review = Review::updateOrCreate(
            ['user_id' => auth()->id(), 'movie_id' => $request->movie_id],
            ['title' => $request->title, 'review' => $request->review]
        );
        return new ReviewResource($review);
    }

    public function show(Review $review)
    {
        $review->load(['user', 'movie']);
        return new ReviewResource($review);
    }

    public function destroy(Review $review)
    {
        $this->authorize('delete', $review);
        $review->delete();
        return response()->json(null, 204);
    }
}