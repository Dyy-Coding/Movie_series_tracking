<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('author_id'); // MUST MATCH authors.id
            $table->string("cover_image")->nullable();
            $table->string("isbn", 20)->unique();
            $table->string("title", 150);
            $table->string("genre");
            $table->year("publication_year");
            $table->integer("number_of_copies")->default(0);
            $table->string("category", 100);
            $table->enum("priority", ["Low", "Medium", "High"])->default("Medium"); // 👈 Added priority
            $table->timestamps();

            $table->foreign('author_id')
                ->references('id')
                ->on('authors')
                ->onDelete('cascade');
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
