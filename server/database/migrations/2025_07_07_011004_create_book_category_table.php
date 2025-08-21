<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('book_category', function (Blueprint $table) {
            // Foreign key to books.id
            $table->foreignId('book_id')
                  ->constrained('books')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');

            // Foreign key to categories.id
            $table->foreignId('category_id')
                  ->constrained('categories')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');

            // Optional additional columns
            $table->boolean('is_primary')->default(false);
            $table->text('notes')->nullable();
            $table->timestamp('assigned_at')->nullable();

            $table->timestamps();

            // Composite primary key to avoid duplicates
            $table->primary(['book_id', 'category_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('book_category');
    }
};
