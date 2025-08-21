
# Library App - Laravel + SQL

This is a full-stack Library Management System built entirely with **Laravel** for both the **front-end and back-end**, using **SQL (MySQL or compatible)** for database management.

## 🛠 Tech Stack

* **Framework:** Laravel (Back-end & Front-end with Blade)
* **Database:** SQL (e.g., MySQL)
* **ORM:** Eloquent
* **Routing:** Laravel API & Web routes

## 📦 Features

* Manage Books, Authors, Categories, Members
* Track Borrowing and Returning of Books
* Eloquent relationships for data integrity
* RESTful API structure (optional Vue.js integration ready)

## 📁 Project Structure Overview

```
app/
├── Models/          # Eloquent models with relationships
├── Http/
│   ├── Controllers/ # Resource controllers for CRUD
│   └── Requests/    # Form requests (optional validation)
resources/
├── views/           # Blade views (front-end UI)
routes/
├── web.php          # Web interface routes
├── api.php          # REST API routes
database/
├── migrations/      # Schema for SQL
```

## ⚙️ Setup Instructions

1. Clone the repository:

```
git clone https://github.com/your-username/library-app.git
cd library-app
```

2. Install dependencies:

```
composer install
```

3. Set up your `<span>.env</span>` file with SQL configuration:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=library_db
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

4. Run migrations:

```
php artisan migrate
```

5. Start the development server:

```
php artisan serve
```

## 🧩 Database Relationships

All relationships between models (Book, Author, Category, Member, BorrowRecord) are defined using Laravel's Eloquent ORM. Please refer to the `<span>Library App Relationships</span>` document for detailed code examples.

## 🔐 Authentication (Optional)

You can integrate Laravel Breeze or Sanctum if you need user authentication.

## 📌 To-Do / Future Features

* Book reservation system
* Fine management
* Notifications (email/SMS)

## 📄 License

This project is open-source and available under the MIT License.
