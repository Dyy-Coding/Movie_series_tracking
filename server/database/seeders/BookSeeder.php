<?php

namespace Database\Seeders;

use App\Models\BookModel;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BookSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        BookModel::factory()->count(10)->create();
    }
}
