<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>GenZ Vibe - Add Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
        }

        .card:hover {
            transform: scale(1.02);
            transition: all 0.3s ease-in-out;
        }

        .btn-warning {
            border-radius: 25px;
            font-weight: bold;
        }

        .video-overlay {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            background-color: rgba(0, 0, 0, 0.4);
            z-index: 0;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">GenZ Vibe</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="/">Home</a>
                </li>
               
                <li class="nav-item">
                    <a class="nav-link" href="/about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Form Section -->
<div class="min-h-screen bg-gradient-to-b from-white to-slate-100 py-10 px-4">
    <div class="max-w-2xl mx-auto bg-white rounded-xl shadow-xl p-8">

        <h2 class="text-2xl font-bold text-indigo-700 mb-6 text-center">
            ➕ Add New Book
        </h2>

        @if ($errors->any())
            <div class="alert alert-danger rounded-xl px-4 py-2 mb-4">
                <ul class="mb-0 list-disc pl-5 text-sm text-red-700">
                    @foreach ($errors->all() as $error)
                        <li>⚠️ {{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form action="/store" method="POST" class="space-y-5">
            @csrf

            <div>
                <label class="form-label fw-semibold">Author ID (UUID)</label>
                <input type="text" name="author_id" class="form-control rounded-pill"
                       value="{{ old('author_id') }}" required>
            </div>

            <div>
                <label class="form-label fw-semibold">Book Title</label>
                <input type="text" name="title" class="form-control rounded-pill"
                       value="{{ old('title') }}" required>
            </div>

            <div>
                <label class="form-label fw-semibold">ISBN</label>
                <input type="text" name="isbn" class="form-control rounded-pill"
                       value="{{ old('isbn') }}" required>
            </div>

            <div>
                <label class="form-label fw-semibold">Publication Year</label>
                <input type="number" name="publication_year" class="form-control rounded-pill"
                       value="{{ old('publication_year') }}" required>
            </div>

            <div>
                <label class="form-label fw-semibold">Genre</label>
                <input type="text" name="genre" class="form-control rounded-pill"
                       value="{{ old('genre') }}" required>
            </div>

            <div>
                <label class="form-label fw-semibold">Available Copies</label>
                <input type="number" name="available_copies" class="form-control rounded-pill"
                       value="{{ old('available_copies') }}" required>
            </div>

            <div class="flex justify-between items-center pt-4">
                <a href="/" class="btn btn-outline-secondary rounded-pill">
                    ⬅️ Cancel
                </a>
                <button type="submit" class="btn btn-primary rounded-pill px-4">
                    💾 Save Book
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="text-center text-white bg-dark py-3 mt-5">
    <p class="mb-0">© {{ date('Y') }} GenZ Vibe. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
