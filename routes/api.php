<?php

use App\Http\Controllers\RinhaController;
use App\Http\Controllers\TransactionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('clientes/{clientId}/transacoes', function (Request $request, $clientId) {
    $request->validate([
        'valor' => 'required|integer|min:1',
        'tipo' => 'required|string|in:c,d',
        'descricao' => 'required|string|max:10|min:1'
    ]);

    return DB::transaction(function () use ($request, $clientId) {
        $client = DB::table('clients')->lockForUpdate()->find($clientId);

        if (!$client) {
            return response(null, 404);
        }

        if ($request->tipo == 'd' && $client->saldo - $request->valor < 0) {
            return response(null, 422);
        }

        $saldo = $request->tipo == 'c'
            ? $client->saldo + $request->valor
            : $client->saldo - $request->valor;

        DB::table('clients')->lockForUpdate()->where('id', $clientId)->update([
            'saldo' => $saldo
        ]);

        DB::table('transactions')->insert([
            'valor' => $request->valor,
            'tipo' => $request->tipo,
            'descricao' => $request->descricao,
            'realizada_em' => date(\Datetime::ISO8601),
            'client_id' => $clientId
        ]);

        return response()->json([
            "limite" => $client->limite,
            "saldo" => $saldo
        ]);
    });
});

Route::get('clientes/{clientId}/extrato', function (Request $request, $clientId) {
    $client = DB::table('clients')->find($clientId);

    if (!$client) {
        return response(null, 404);
    }

    return response()->json([
        "saldo" => [
            "total" => $client->saldo,
            "data_extrato" => date(\Datetime::ISO8601),
            "limite" => $client->limite,
        ],
        "ultimas_transacoes" => DB::table('transactions')
            ->where('client_id', $clientId)
            ->latest("id")
            ->limit(10)
            ->get(["valor", "tipo", "descricao", "realizada_em"])
    ]);
});
