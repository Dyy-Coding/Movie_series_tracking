<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>GenZ Vibe</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
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

        .hero-video {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            top: 0;
            left: 0;
            z-index: -1;
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


<!-- Contact Section -->
<section id="contact" class="py-5 bg-light">
    <div class="container text-center">
        <h2 class="mb-4">📬 Get in Touch</h2>
        <p class="lead">Got a suggestion, idea, or just want to say hi? We'd love to hear from you!</p>
        <a href="mailto:hello@genzvibe.com" class="btn btn-dark">Email Us</a>
    </div>
</section>

<!-- Footer -->
<footer class="text-center text-white bg-dark py-4">
    <div class="container">
        <p class="mb-0">© <?php echo date("Y"); ?> GenZ Vibe. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
