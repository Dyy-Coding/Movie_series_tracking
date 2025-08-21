<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\web\Authentication\AuthWebController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| These routes handle user authentication and dashboard access.
| All routes are grouped under the "web" middleware.
|
*/

// 🟢 Public Authentication Routes
Route::middleware('guest')->group(function () {
    Route::get('/login', [AuthWebController::class, 'showLoginForm'])->name('login');
    Route::post('/login', [AuthWebController::class, 'login']);

    Route::get('/register', [AuthWebController::class, 'showRegisterForm'])->name('register');
    Route::post('/register', [AuthWebController::class, 'register']);
});

// 🔒 Protected Routes (requires user to be logged in)
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard'); // Replace with controller if needed
    })->name('dashboard');

    Route::post('/logout', [AuthWebController::class, 'logout'])->name('logout');
});

// 🌐 Home Route (optional)
Route::get('/', function () {
    return redirect()->route('login');
});
