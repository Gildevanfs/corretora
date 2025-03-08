/*
  Warnings:

  - You are about to drop the `BuyOffer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Company` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SellOffer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Stock` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Transaction` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "BuyOffer" DROP CONSTRAINT "BuyOffer_stockId_fkey";

-- DropForeignKey
ALTER TABLE "BuyOffer" DROP CONSTRAINT "BuyOffer_userId_fkey";

-- DropForeignKey
ALTER TABLE "SellOffer" DROP CONSTRAINT "SellOffer_stockId_fkey";

-- DropForeignKey
ALTER TABLE "SellOffer" DROP CONSTRAINT "SellOffer_userId_fkey";

-- DropForeignKey
ALTER TABLE "Stock" DROP CONSTRAINT "Stock_companyId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_buyOfferId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_sellOfferId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_stockId_fkey";

-- DropTable
DROP TABLE "BuyOffer";

-- DropTable
DROP TABLE "Company";

-- DropTable
DROP TABLE "SellOffer";

-- DropTable
DROP TABLE "Stock";

-- DropTable
DROP TABLE "Transaction";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "tb_companies" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tb_companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_stocks" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "companyId" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "initialPrice" DECIMAL(65,30) NOT NULL,
    "isAvailable" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tb_stocks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_users_usr" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "balance" DECIMAL(65,30) NOT NULL DEFAULT 0.00,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tb_users_usr_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_sell_offers" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "stockId" INTEGER NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tb_sell_offers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_buy_offers_bfs" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "stockId" INTEGER NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tb_buy_offers_bfs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_transactions" (
    "id" SERIAL NOT NULL,
    "sellOfferId" INTEGER NOT NULL,
    "buyOfferId" INTEGER NOT NULL,
    "stockId" INTEGER NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tb_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tb_users_usr_email_key" ON "tb_users_usr"("email");

-- AddForeignKey
ALTER TABLE "tb_stocks" ADD CONSTRAINT "tb_stocks_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "tb_companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_sell_offers" ADD CONSTRAINT "tb_sell_offers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "tb_users_usr"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_sell_offers" ADD CONSTRAINT "tb_sell_offers_stockId_fkey" FOREIGN KEY ("stockId") REFERENCES "tb_stocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_buy_offers_bfs" ADD CONSTRAINT "tb_buy_offers_bfs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "tb_users_usr"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_buy_offers_bfs" ADD CONSTRAINT "tb_buy_offers_bfs_stockId_fkey" FOREIGN KEY ("stockId") REFERENCES "tb_stocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_transactions" ADD CONSTRAINT "tb_transactions_sellOfferId_fkey" FOREIGN KEY ("sellOfferId") REFERENCES "tb_sell_offers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_transactions" ADD CONSTRAINT "tb_transactions_buyOfferId_fkey" FOREIGN KEY ("buyOfferId") REFERENCES "tb_buy_offers_bfs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_transactions" ADD CONSTRAINT "tb_transactions_stockId_fkey" FOREIGN KEY ("stockId") REFERENCES "tb_stocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;
