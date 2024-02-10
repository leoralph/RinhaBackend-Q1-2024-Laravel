<?php

namespace App\Http\Controllers;

use App\Models\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RinhaController extends Controller
{
    public function storeTransaction(Request $request, $clientId)
    {

        $request->validate([
            'valor' => 'required|int|gt:0',
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
                'realizada_em' => now()->toIso8601String(),
                'client_id' => $clientId
            ]);

            return response()->json([
                "limite" => $client->limite,
                "saldo" => $saldo
            ]);
        });
    }

    public function getStatement(Request $request, $clientId)
    {
        $client = DB::table('clients')->find($clientId);

        if (!$client) {
            return response(null, 404);
        }

        return response()->json([
            "saldo" => [
                "total" => $client->saldo,
                "data_extrato" => now()->toIso8601String(),
                "limite" => $client->limite,
            ],
            "ultimas_transacoes" => DB::table('transactions')
                ->where('client_id', $clientId)
                ->latest("id")
                ->limit(10)
                ->get(["valor", "tipo", "descricao", "realizada_em"])
        ]);
    }
}
