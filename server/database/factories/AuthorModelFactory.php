<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\AuthorModel>
 */
class AuthorModelFactory extends Factory
{
    public function definition(): array
    {
        $name = $this->faker->name();

        return [
            'name'               => $name,
            'bio'                => $this->faker->text(300),
            'dateofbirth'        => $this->faker->date('Y-m-d', '2000-01-01'), // realistic DOB
            'nationality'        => $this->faker->country(),
            'numberOfWrittenBook'=> $this->faker->numberBetween(0, 50),
            'image'              => 'http://127.0.0.1:8000/api/?name=' . urlencode($name) . '&background=random&size=256',
        ];
    }
}
