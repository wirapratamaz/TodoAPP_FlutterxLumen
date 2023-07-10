<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TBData extends Model
{
    use SoftDeletes;
    protected $table = 'tb_data';
    protected $primaryKey = 'id';
}
