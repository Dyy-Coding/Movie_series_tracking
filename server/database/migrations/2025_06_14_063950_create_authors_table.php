<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('authors', function (Blueprint $table) {
            $table->id();
            $table->string("name", 50);
            $table->text("bio"); // use text, not string
            $table->date("dateofbirth");
            $table->string("nationality", 100);
            $table->integer("numberOfWrittenBook");
            $table->string("image")->nullable(); // matches your 'image' field (not 'image_url')
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('authors'); // fix table name here
    }
};

