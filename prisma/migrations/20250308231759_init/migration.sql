-- CreateTable
CREATE TABLE "tb_companies" (
    "id" SERIAL NOT NULL,
    "des_name_cpn" TEXT NOT NULL,
    "is_active_cpn" BOOLEAN NOT NULL DEFAULT true,
    "hra_created_at_cpn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hra_updated_at_cpn" TIMESTAMP(3),

    CONSTRAINT "tb_companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_stocks" (
    "id" SERIAL NOT NULL,
    "des_stock_name_stk" TEXT NOT NULL,
    "id_company_stk" INTEGER NOT NULL,
    "num_quantity_stk" INTEGER NOT NULL,
    "vlr_initial_price_stk" DECIMAL(65,30) NOT NULL,
    "is_available_stk" BOOLEAN NOT NULL DEFAULT true,
    "hra_created_at_stk" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hra_updated_at_stk" TIMESTAMP(3),

    CONSTRAINT "tb_stocks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_users" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "des_email_usr" TEXT NOT NULL,
    "vlr_balance_usr" DECIMAL(65,30) NOT NULL DEFAULT 0.00,
    "is_active_usr" BOOLEAN NOT NULL DEFAULT true,
    "hra_created_at_usr" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hra_updated_at_usr" TIMESTAMP(3),

    CONSTRAINT "tb_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_sell_offers" (
    "id" SERIAL NOT NULL,
    "id_user_slf" INTEGER NOT NULL,
    "id_stock_slf" INTEGER NOT NULL,
    "vlr_price_slf" DECIMAL(65,30) NOT NULL,
    "num_quantity_slf" INTEGER NOT NULL,
    "hra_created_at_slf" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hra_updated_at_slf" TIMESTAMP(3),

    CONSTRAINT "tb_sell_offers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_buy_offers" (
    "id" SERIAL NOT NULL,
    "id_user_bfs" INTEGER NOT NULL,
    "id_stock_bfs" INTEGER NOT NULL,
    "vlr_price_bfs" DECIMAL(65,30) NOT NULL,
    "num_quantity_bfs" INTEGER NOT NULL,
    "hra_created_at_bfs" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hra_updated_at_bfs" TIMESTAMP(3),

    CONSTRAINT "tb_buy_offers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_transactions" (
    "id" SERIAL NOT NULL,
    "id_sell_offers_tsc" INTEGER NOT NULL,
    "id_buy_offers_tsc" INTEGER NOT NULL,
    "id_stock_tsc" INTEGER NOT NULL,
    "vlr_price_tsc" DECIMAL(65,30) NOT NULL,
    "num_quantity_tsc" INTEGER NOT NULL,
    "hra_created_at_tsc" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "hra_updated_at_tsc" TIMESTAMP(3),

    CONSTRAINT "tb_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tb_users_des_email_usr_key" ON "tb_users"("des_email_usr");

-- AddForeignKey
ALTER TABLE "tb_stocks" ADD CONSTRAINT "tb_stocks_id_company_stk_fkey" FOREIGN KEY ("id_company_stk") REFERENCES "tb_companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_sell_offers" ADD CONSTRAINT "tb_sell_offers_id_user_slf_fkey" FOREIGN KEY ("id_user_slf") REFERENCES "tb_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_sell_offers" ADD CONSTRAINT "tb_sell_offers_id_stock_slf_fkey" FOREIGN KEY ("id_stock_slf") REFERENCES "tb_stocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_buy_offers" ADD CONSTRAINT "tb_buy_offers_id_user_bfs_fkey" FOREIGN KEY ("id_user_bfs") REFERENCES "tb_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_buy_offers" ADD CONSTRAINT "tb_buy_offers_id_stock_bfs_fkey" FOREIGN KEY ("id_stock_bfs") REFERENCES "tb_stocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_transactions" ADD CONSTRAINT "tb_transactions_id_sell_offers_tsc_fkey" FOREIGN KEY ("id_sell_offers_tsc") REFERENCES "tb_sell_offers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_transactions" ADD CONSTRAINT "tb_transactions_id_buy_offers_tsc_fkey" FOREIGN KEY ("id_buy_offers_tsc") REFERENCES "tb_buy_offers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_transactions" ADD CONSTRAINT "tb_transactions_id_stock_tsc_fkey" FOREIGN KEY ("id_stock_tsc") REFERENCES "tb_stocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;
