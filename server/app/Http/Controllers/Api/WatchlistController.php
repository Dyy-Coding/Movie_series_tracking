<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreWatchlistRequest;
use App\Http\Resources\WatchlistResource;
use App\Models\Watchlist;
use Illuminate\Http\Request;

class WatchlistController extends Controller
{
    public function index(Request $request)
    {
        $watchlists = Watchlist::where('user_id', auth()->id())
            ->with('movie')
            ->paginate(20);
        return WatchlistResource::collection($watchlists);
    }

    public function store(StoreWatchlistRequest $request)
    {
        $watchlist = Watchlist::updateOrCreate(
            ['user_id' => auth()->id(), 'movie_id' => $request->movie_id],
            [
                'watched' => $request->watched ?? false,
                'progress' => $request->progress ?? 0,
                'priority' => $request->priority ?? 'medium',
            ]
        );
        return new WatchlistResource($watchlist);
    }

    public function show(Watchlist $watchlist)
    {
        $this->authorize('view', $watchlist);
        $watchlist->load('movie');
        return new WatchlistResource($watchlist);
    }

    public function destroy(Watchlist $watchlist)
    {
        $this->authorize('delete', $watchlist);
        $watchlist->delete();
        return response()->json(null, 204);
    }
}