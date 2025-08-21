<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\AuthorModel;

/**
 * @extends Factory<\App\Models\BookModel>
 */
class BookModelFactory extends Factory
{
    public function definition(): array
    {
        $title = $this->faker->sentence(3);
        $genres = ['Fantasy', 'Science Fiction', 'Mystery', 'Romance', 'Horror', 'Biography', 'History', 'Thriller'];
        $categories = ['Fiction', 'Non-Fiction', 'Children', 'Education', 'Classic', 'Comics'];
        $priorities = ['Low', 'Medium', 'High'];

        return [
            'author_id'         => AuthorModel::factory(),
            'cover_image'       => 'https://127.0.0.1:8000/api/?name=' . urlencode($title) . '&background=random&size=256',
            'isbn'              => $this->faker->unique()->isbn13(),
            'title'             => $title,
            'genre'             => $this->faker->randomElement($genres),
            'publication_year'  => $this->faker->year(),
            'number_of_copies'  => $this->faker->numberBetween(0, 30),
            'category'          => $this->faker->randomElement($categories),
            'priority'          => $this->faker->randomElement($priorities),
        ];
    }
}
