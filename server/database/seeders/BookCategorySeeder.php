<?php

namespace Database\Seeders;

use App\Models\BookModel;
use App\Models\Category;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class BookCategorySeeder extends Seeder
{
    public function run(): void
    {
        // Make sure there are books and categories
        $books = BookModel::all();
        $categories = Category::all();

        foreach ($books as $book) {
            // Attach 1-3 random categories to each book
            $selectedCategories = $categories->random(rand(1, 3));

            foreach ($selectedCategories as $category) {
                DB::table('book_category')->insert([
                    'book_id' => $book->id,
                    'category_id' => $category->id,
                    'is_primary' => fake()->boolean(30),
                    'notes' => fake()->optional()->sentence(),
                    'assigned_at' => Carbon::now()->subDays(rand(0, 365)),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
