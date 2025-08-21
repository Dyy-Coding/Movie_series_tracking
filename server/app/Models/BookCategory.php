<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BookCategory extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'book_category';

    /**
     * Indicates if the IDs are auto-incrementing.
     *
     * @var bool
     */
    public $incrementing = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int,string>
     */
    protected $fillable = [
        'book_id',
        'category_id',
        'is_primary',
        'notes',
        'assigned_at',
    ];

    /**
     * Indicates if the model should be timestamped.
     * Set to true if your pivot table has created_at and updated_at.
     *
     * @var bool
     */
    public $timestamps = true;

    /**
     * Get the book associated with this pivot.
     *
     * @return BelongsTo
     */
    public function book(): BelongsTo
    {
        return $this->belongsTo(BookModel::class);
    }

    /**
     * Get the category associated with this pivot.
     *
     * @return BelongsTo
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }
}
