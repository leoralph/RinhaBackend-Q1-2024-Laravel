
Warning: require(/home/ralph/code/Testes/RinhaBackend-Q1-2024/vendor/autoload.php): Failed to open stream: No such file or directory in /home/ralph/code/Testes/RinhaBackend-Q1-2024/artisan on line 18

Fatal error: Uncaught Error: Failed opening required '/home/ralph/code/Testes/RinhaBackend-Q1-2024/vendor/autoload.php' (include_path='.:/home/ralph/.asdf/installs/php/8.2.12/lib/php') in /home/ralph/code/Testes/RinhaBackend-Q1-2024/artisan:18
Stack trace:
#0 {main}
  thrown in /home/ralph/code/Testes/RinhaBackend-Q1-2024/artisan on line 18

                                          
  The "--pretend" option does not exist.  
                                          


                                          
  The "--pretend" option does not exist.  
                                          


                                                                                                                        
                                               APPLICATION IN PRODUCTION.                                               
                                                                                                                        
[?25l
[90m ┌[39m [36mAre you sure you want to run this command?[39m [90m──────────────────┐[39m
[90m │[39m [2m○ Yes /[22m [32m●[39m No                                                 [90m│[39m
[90m └──────────────────────────────────────────────────────────────┘[39m

[999D[5A[1B[J[31m ┌[39m Are you sure you want to run this command? [31m──────────────────┐[39m
[31m │[39m [2m○ [9mYes[29m / ● [9mNo[29m[22m                                                 [31m│[39m
[31m └──────────────────────────────────────────────────────────────┘[39m
[31m  ⚠ Cancelled.[39m

[?25h
   INFO  Running migrations.  

  2014_10_12_000000_create_users_table ...............................................................................  
  ⇂ create table "users" ("id" bigserial not null primary key, "name" varchar(255) not null, "email" varchar(255) not null, "email_verified_at" timestamp(0) without time zone null, "password" varchar(255) not null, "remember_token" varchar(100) null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null)  
  ⇂ alter table "users" add constraint "users_email_unique" unique ("email")  
  2014_10_12_100000_create_password_reset_tokens_table ...............................................................  
  ⇂ create table "password_reset_tokens" ("email" varchar(255) not null, "token" varchar(255) not null, "created_at" timestamp(0) without time zone null)  
  ⇂ alter table "password_reset_tokens" add primary key ("email")  
  2019_08_19_000000_create_failed_jobs_table .........................................................................  
  ⇂ create table "failed_jobs" ("id" bigserial not null primary key, "uuid" varchar(255) not null, "connection" text not null, "queue" text not null, "payload" text not null, "exception" text not null, "failed_at" timestamp(0) without time zone not null default CURRENT_TIMESTAMP)  
  ⇂ alter table "failed_jobs" add constraint "failed_jobs_uuid_unique" unique ("uuid")  
  2019_12_14_000001_create_personal_access_tokens_table ..............................................................  
  ⇂ create table "personal_access_tokens" ("id" bigserial not null primary key, "tokenable_type" varchar(255) not null, "tokenable_id" bigint not null, "name" varchar(255) not null, "token" varchar(64) not null, "abilities" text null, "last_used_at" timestamp(0) without time zone null, "expires_at" timestamp(0) without time zone null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null)  
  ⇂ create index "personal_access_tokens_tokenable_type_tokenable_id_index" on "personal_access_tokens" ("tokenable_type", "tokenable_id")  
  ⇂ alter table "personal_access_tokens" add constraint "personal_access_tokens_token_unique" unique ("token")  
  2024_02_05_040323_create_clients_table .............................................................................  
  ⇂ create table "clients" ("id" bigserial not null primary key, "limite" integer not null, "saldo_inicial" bigint not null default '0', "saldo" bigint not null default '0')  
  2024_02_05_040341_create_transactions_table ........................................................................  
  ⇂ create table "transactions" ("id" bigserial not null primary key, "client_id" bigint not null, "valor" bigint not null, "tipo" varchar(1) not null, "descricao" varchar(10) not null, "realizada_em" varchar(255) not null)  
  ⇂ alter table "transactions" add constraint "transactions_client_id_foreign" foreign key ("client_id") references "clients" ("id")  
  ⇂ create index "transactions_client_id_id_index" on "transactions" ("client_id", "id")  
  2024_02_05_041511_insert_base_clients ..............................................................................  
  ⇂ insert into "clients" ("id", "limite", "saldo_inicial") values (1, 100000, 0), (2, 80000, 0), (3, 1000000, 0), (4, 10000000, 0), (5, 500000, 0) on conflict ("id") do update set "id" = "excluded"."id", "limite" = "excluded"."limite", "saldo_inicial" = "excluded"."saldo_inicial"  

