/* eslint-disable no-console */

import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main(): Promise<void> {
  const email = 'albinma@gmail.com';
  const user = await prisma.user.upsert({
    where: { email },
    update: {},
    create: {
      email,
      password: 'password',
      name: 'Al',
      vehicles: {
        create: {
          make: 'Toyota',
          model: 'Tacoma',
          year: 2002,
          vin: '5TEWN72N82Z891171',
          engineCode: '5VZ-FE',
          mfrBodyCode: 'VZN170',
          modelNumber: 'VZN170L-CRMDKAB',
          transmissionCode: 'R150F',
          trim: 'Base 4wd 2dr Xtra Cab',
        },
      },
    },
  });

  console.log(user);
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
