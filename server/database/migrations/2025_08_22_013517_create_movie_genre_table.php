<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('movies', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->date('release_date')->nullable();
            $table->string('poster_image')->nullable();
            $table->string('backdrop_image')->nullable();
            $table->enum('type', ['movie', 'series'])->default('movie');
            $table->integer('duration')->nullable();
            $table->integer('seasons')->nullable();
            $table->integer('episodes')->nullable();
            $table->string('director')->nullable();
            $table->json('cast')->nullable();
            $table->string('tmdb_id')->nullable();
            $table->float('average_rating')->default(0);
            $table->integer('vote_count')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('movies');
    }
};