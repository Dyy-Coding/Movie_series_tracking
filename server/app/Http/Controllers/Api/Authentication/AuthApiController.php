<?php

namespace App\Http\Controllers\Api\Authentication;

use App\Http\Controllers\Controller;
use App\Http\Requests\Authenication\LoginPostStore;
use App\Http\Requests\Authenication\RegisterPostStore;
use App\Http\Resources\UsersResources;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use App\Models\User;
use Throwable;

class AuthApiController extends Controller
{
    /**
     * 🔎 Get a paginated list of users.
     */
    public function index(): JsonResponse
    {
        try {
            $users = User::latest()->paginate(5);
            return $this->successResponse('Users fetched successfully.', UsersResources::collection($users));
        } catch (Throwable $e) {
            return $this->errorResponse('Failed to fetch users.', $e);
        }
    }

    /**
     * 📝 Register a new user.
     */
    public function register(RegisterPostStore $request): JsonResponse
    {
        try {
            $data = $request->validated();

            $user = User::create([
                'name'     => $data['name'],
                'email'    => $data['email'],
                'password' => Hash::make($data['password']),
                'image'    => $data['image'] ?? null,
                'email_verified_at' => now(), // Optional: Automatically verify
            ]);

            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = time() . '_' . $file->getClientOriginalName();
                $path = $file->storeAs('public/images', $filename);
                $imagePath = '/storage/images/' . $filename;
            } elseif (filter_var($request->input('image'), FILTER_VALIDATE_URL)) {
                $imagePath = $request->input('image'); // just save URL directly
            } else {
                $imagePath = null;
            }


            $token = $user->createToken('api-token')->plainTextToken;

            return $this->successResponse('User registered successfully.', [
                'token' => $token,
                'user'  => new UsersResources($user),
            ], 201);
        } catch (Throwable $e) {
            return $this->errorResponse('Registration failed.', $e);
        }
    }

    /**
     * 🔐 Login user and issue token.
     */
    public function login(LoginPostStore $request): JsonResponse
    {
        $data = $request->validated();

        $user = User::where('email', $data['email'])->first();

        if (! $user || ! Hash::check($data['password'], $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('api-token')->plainTextToken;

        return $this->successResponse('Login successful.', [
            'token' => $token,
            'user'  => new UsersResources($user),
        ]);
    }

    /**
     * 🚪 Logout the current authenticated user.
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return $this->successResponse('Successfully logged out.');
    }

    /**
     * 🙍‍♂️ Get authenticated user's profile.
     */
    public function profile(Request $request): JsonResponse
    {
        return $this->successResponse('User profile fetched successfully.', new UsersResources($request->user()));
    }

    /**
     * ✏️ Update authenticated user's profile.
     */
    public function update(Request $request): JsonResponse
    {
        $user = $request->user();

        $validated = $request->validate([
            'name'  => ['nullable', 'string', 'max:255'],
            'email' => ['nullable', 'email', 'unique:users,email,' . $user->id],
        ]);

        $user->fill($validated)->save();

        return $this->successResponse('Profile updated successfully.', new UsersResources($user));
    }

    /**
     * 🗑️ Delete the authenticated user's account.
     */
    public function destroy(Request $request): JsonResponse
    {
        $user = $request->user();

        if (! $user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found or unauthorized.',
            ], 401);
        }

        $user->tokens()->delete();
        $user->delete();

        return $this->successResponse('User account deleted successfully.');
    }

    /*
    |--------------------------------------------------------------------------
    | ✅ Helper methods for API standardization
    |--------------------------------------------------------------------------
    */

    /**
     * Format a success JSON response.
     */
    private function successResponse(string $message, mixed $data = null, int $code = 200): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => $message,
            'data'    => $data,
        ], $code);
    }

    /**
     * Format an error JSON response and log the exception.
     */
    private function errorResponse(string $message, Throwable $e, int $code = 500): JsonResponse
    {
        Log::error("{$message}: " . $e->getMessage(), [
            'exception' => $e,
        ]);

        return response()->json([
            'success' => false,
            'message' => $message,
            'error'   => $e->getMessage(),
        ], $code);
    }
}
