<?php

use App\Models\Client;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Client::upsert([
            ["id" => 1, "limite" => 100000, "saldo_inicial" => 0],
            ["id" => 2, "limite" => 80000, "saldo_inicial" => 0],
            ["id" => 3, "limite" => 1000000, "saldo_inicial" => 0],
            ["id" => 4, "limite" => 10000000, "saldo_inicial" => 0],
            ["id" => 5, "limite" => 500000, "saldo_inicial" => 0],
        ], ['id']);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
