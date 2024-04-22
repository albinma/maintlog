-- CreateTable
CREATE TABLE "vehicles" (
    "id" SERIAL NOT NULL,
    "vin" VARCHAR(255) NOT NULL,
    "year" INTEGER NOT NULL,
    "make" VARCHAR(255) NOT NULL,
    "model" VARCHAR(255) NOT NULL,
    "trim" VARCHAR(255),
    "mfr_body_code" VARCHAR(255),
    "engine_code" VARCHAR(255),
    "transmission_code" VARCHAR(255),
    "model_number" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VehiclePart" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "product_link" VARCHAR(255),
    "part_number" VARCHAR(255),
    "manufacturer" VARCHAR(255),
    "manufacturer_part_number" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VehiclePart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "maintenance_logs" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "mileage" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "maintenance_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "maintenance_types" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "recurring" BOOLEAN NOT NULL DEFAULT false,
    "mileage" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "maintenance_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "maintenance_log_types" (
    "maintenance_log_id" INTEGER NOT NULL,
    "maintenance_type_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "maintenance_log_types_pkey" PRIMARY KEY ("maintenance_log_id","maintenance_type_id")
);

-- CreateTable
CREATE TABLE "maintenance_log_vehicle_parts" (
    "maintenance_log_id" INTEGER NOT NULL,
    "vehicle_part_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "maintenance_log_vehicle_parts_pkey" PRIMARY KEY ("maintenance_log_id","vehicle_part_id")
);

-- AddForeignKey
ALTER TABLE "VehiclePart" ADD CONSTRAINT "VehiclePart_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

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
