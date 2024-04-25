/*
  Warnings:

  - A unique constraint covering the columns `[vin,owner_id]` on the table `vehicles` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "vehicles" ADD COLUMN     "color_code" VARCHAR(255),
ADD COLUMN     "nickname" VARCHAR(255);

-- CreateIndex
CREATE UNIQUE INDEX "vehicles_vin_owner_id_key" ON "vehicles"("vin", "owner_id");
