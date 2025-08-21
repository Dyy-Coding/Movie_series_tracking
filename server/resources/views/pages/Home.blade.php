<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>GenZ Vibe - Book Library</title>
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
    <!-- Tailwind CSS CDN (optional for additional styling) -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
        }

        /* Subtle hover effect on cards */
        .card:hover {
            transform: scale(1.02);
            transition: all 0.3s ease-in-out;
        }

        /* Rounded pill-style buttons with emphasis */
        .btn-warning {
            border-radius: 25px;
            font-weight: bold;
        }

        /* Optional overlay styling */
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

<!-- Navbar: Provides main site navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <!-- Brand -->
        <a class="navbar-brand fw-bold" href="#">GenZ Vibe</a>

        <!-- Hamburger menu toggle for small screens -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Home link, marked active -->
                <li class="nav-item">
                    <a class="nav-link active" href="/">Home</a>
                </li>
                <!-- About page -->
                <li class="nav-item">
                    <a class="nav-link" href="/about">About</a>
                </li>
                <!-- Contact page -->
                <li class="nav-item">
                    <a class="nav-link" href="/contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Book Section -->
<section class="min-h-screen bg-gradient-to-b from-white to-slate-100 py-5">
    <div class="container py-5">

        <!-- Header and Add Book Button -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="text-3xl font-bold text-indigo-700">📚 Book Library</h1>
            <!-- Link to the form for adding a new book -->
            <a href="/create" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
                ➕ Add Book
            </a>
        </div>

        <!-- Flash message for success notifications -->
        @if (session('success'))
            <div class="alert alert-success rounded-pill px-4 shadow">
                {{ session('success') }}
            </div>
        @endif

        <!-- Responsive table container -->
        <div class="overflow-x-auto bg-white rounded-xl shadow">
            <!-- Table to display books -->
            <table class="table table-hover text-center align-middle">
                <thead class="bg-indigo-100 text-indigo-700">
                    <tr>
                        <th>Title</th>
                        <th>Genre</th>
                        <th>Year</th>
                        <th>ISBN</th>
                        <th>Copies</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through all books and display them -->
                    @foreach ($books as $book)
                        <tr>
                            <td class="fw-semibold">{{ $book->title }}</td>
                            <td>{{ $book->genre }}</td>
                            <td>{{ $book->publication_year }}</td>
                            <td>{{ $book->isbn }}</td>
                            <td>{{ $book->available_copies }}</td>
                            <td>
                                <!-- Edit button linking to edit form -->
                                <a href="/edit/{{ $book->id }}" class="btn btn-sm btn-outline-primary">Edit</a>

                                <!-- Delete form to safely send DELETE request -->
                                <form action="/delete/{{ $book->id }}" method="POST" class="d-inline"
                                    onsubmit="return confirm('Are you sure?');">
                                    @csrf <!-- CSRF protection token -->
                                    @method('DELETE') <!-- Spoof DELETE HTTP method -->
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

    </div>
</section>

<!-- Footer -->
<footer class="text-center text-white bg-dark py-3 mt-5">
    <p class="mb-0">© {{ date('Y') }} GenZ Vibe. All rights reserved.</p>
</footer>

<!-- Bootstrap JS Bundle (includes Popper for dropdowns, modals, etc.) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
