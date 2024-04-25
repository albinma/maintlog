/*
  Warnings:

  - The primary key for the `VehiclePart` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `maintenance_log_types` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `maintenance_log_vehicle_parts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `maintenance_logs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `maintenance_types` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `vehicles` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Made the column `vehicle_id` on table `VehiclePart` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "VehiclePart" DROP CONSTRAINT "VehiclePart_vehicle_id_fkey";

-- DropForeignKey
ALTER TABLE "maintenance_log_types" DROP CONSTRAINT "maintenance_log_types_maintenance_log_id_fkey";

-- DropForeignKey
ALTER TABLE "maintenance_log_types" DROP CONSTRAINT "maintenance_log_types_maintenance_type_id_fkey";

-- DropForeignKey
ALTER TABLE "maintenance_log_vehicle_parts" DROP CONSTRAINT "maintenance_log_vehicle_parts_maintenance_log_id_fkey";

-- DropForeignKey
ALTER TABLE "maintenance_log_vehicle_parts" DROP CONSTRAINT "maintenance_log_vehicle_parts_vehicle_part_id_fkey";

-- DropForeignKey
ALTER TABLE "maintenance_logs" DROP CONSTRAINT "maintenance_logs_vehicle_id_fkey";

-- DropForeignKey
ALTER TABLE "vehicles" DROP CONSTRAINT "vehicles_owner_id_fkey";

-- AlterTable
ALTER TABLE "VehiclePart" DROP CONSTRAINT "VehiclePart_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "vehicle_id" SET NOT NULL,
ALTER COLUMN "vehicle_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "VehiclePart_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "VehiclePart_id_seq";

-- AlterTable
ALTER TABLE "maintenance_log_types" DROP CONSTRAINT "maintenance_log_types_pkey",
ALTER COLUMN "maintenance_log_id" SET DATA TYPE TEXT,
ALTER COLUMN "maintenance_type_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "maintenance_log_types_pkey" PRIMARY KEY ("maintenance_log_id", "maintenance_type_id");

-- AlterTable
ALTER TABLE "maintenance_log_vehicle_parts" DROP CONSTRAINT "maintenance_log_vehicle_parts_pkey",
ALTER COLUMN "maintenance_log_id" SET DATA TYPE TEXT,
ALTER COLUMN "vehicle_part_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "maintenance_log_vehicle_parts_pkey" PRIMARY KEY ("maintenance_log_id", "vehicle_part_id");

-- AlterTable
ALTER TABLE "maintenance_logs" DROP CONSTRAINT "maintenance_logs_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "vehicle_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "maintenance_logs_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "maintenance_logs_id_seq";

-- AlterTable
ALTER TABLE "maintenance_types" DROP CONSTRAINT "maintenance_types_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "maintenance_types_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "maintenance_types_id_seq";

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
ADD COLUMN     "emailVerified" TIMESTAMP(3),
ADD COLUMN     "image" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "password" DROP NOT NULL,
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "users_id_seq";

-- AlterTable
ALTER TABLE "vehicles" DROP CONSTRAINT "vehicles_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "owner_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "vehicles_id_seq";

-- CreateTable
CREATE TABLE "Account" (
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "provider_account_id" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("provider","provider_account_id")
);

-- CreateTable
CREATE TABLE "Session" (
    "sessionToken" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("identifier","token")
);

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicles" ADD CONSTRAINT "vehicles_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehiclePart" ADD CONSTRAINT "VehiclePart_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "maintenance_logs" ADD CONSTRAINT "maintenance_logs_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "maintenance_log_types" ADD CONSTRAINT "maintenance_log_types_maintenance_log_id_fkey" FOREIGN KEY ("maintenance_log_id") REFERENCES "maintenance_logs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "maintenance_log_types" ADD CONSTRAINT "maintenance_log_types_maintenance_type_id_fkey" FOREIGN KEY ("maintenance_type_id") REFERENCES "maintenance_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "maintenance_log_vehicle_parts" ADD CONSTRAINT "maintenance_log_vehicle_parts_maintenance_log_id_fkey" FOREIGN KEY ("maintenance_log_id") REFERENCES "maintenance_logs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "maintenance_log_vehicle_parts" ADD CONSTRAINT "maintenance_log_vehicle_parts_vehicle_part_id_fkey" FOREIGN KEY ("vehicle_part_id") REFERENCES "VehiclePart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
