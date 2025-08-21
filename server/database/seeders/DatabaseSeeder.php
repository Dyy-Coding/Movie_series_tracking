<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Seed 10 random users
        \App\Models\User::factory(10)->create();

        // Seed a specific test user
        \App\Models\User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
        ]);
        \App\Models\Category::factory(10)->create(); // or call seeder below
        // Call additional seeders
        $this->call([
            AuthorSeeder::class,
            BookSeeder::class,
            CategorySeeder::class,
            BookCategorySeeder::class,
        ]);

    

  

  


    }
}
