<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class BookModel extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     */
    protected $table = 'books';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'cover_image',
        'isbn',
        'title',
        'author_id',
        'publication_year',
        'number_of_copies',
        'priority',
    ];

    /**
     * The accessors to append to the model's array form.
     */
    protected $appends = ['image_url'];

    /**
     * Get the full URL for the cover image.
     */
    public function getImageUrlAttribute(): ?string
    {
        return $this->cover_image
            ? url('storage/' . $this->cover_image)
            : null;
    }

    /**
     * Get the author that owns the book.
     */
    public function author(): BelongsTo
    {
        return $this->belongsTo(AuthorModel::class);
    }

    /**
     * The categories that belong to the book.
     */
    public function categories(): BelongsToMany
    {
        return $this->belongsToMany(Category::class, 'book_category')
                    ->withPivot('is_primary', 'notes', 'assigned_at')
                    ->withTimestamps();
    }
}
