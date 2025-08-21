<?php

namespace Database\Seeders;

use App\Models\AuthorModel;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AuthorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        AuthorModel::factory()->count(10)->create();
    }
}
