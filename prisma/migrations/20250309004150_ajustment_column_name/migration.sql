/*
  Warnings:

  - You are about to drop the column `name` on the `tb_users` table. All the data in the column will be lost.
  - Added the required column `des_name_usr` to the `tb_users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "tb_users" DROP COLUMN "name",
ADD COLUMN     "des_name_usr" TEXT NOT NULL;
