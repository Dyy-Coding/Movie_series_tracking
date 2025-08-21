<?php

namespace Database\Seeders;

use App\Models\categories;
use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        // You can either use factory or hardcode categories
        $categories = [
            'Fiction', 'Science', 'History', 'Biography', 'Technology',
            'Children', 'Romance', 'Mystery', 'Horror', 'Self-Help',
        ];

        foreach ($categories as $name) {
            Category::factory()->create([
                'name' => $name
            ]);
        }
    }
}
