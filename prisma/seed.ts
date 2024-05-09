/* eslint-disable no-console */

import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main(): Promise<void> {
  const email = 'albinma@gmail.com';
  const provider = 'auth0';
  const providerAccountId = 'google-oauth2|112804275404666187040';
  const user = await prisma.user.upsert({
    where: { email },
    update: {},
    create: {
      email: email,
      name: 'Albin Ma',
      image:
        'https://lh3.googleusercontent.com/a/ACg8ocK7g0cHIvN6VSiZuksDfYhL_K3ObuJbJwKfIzmhjSKs_0ZgaJkh8A=s96-c',
    },
  });

  const account = await prisma.account.upsert({
    where: { provider_providerAccountId: { provider, providerAccountId } },
    update: {},
    create: {
      type: 'oidc',
      provider,
      providerAccountId,
      userId: user.id,
    },
  });

  const vin = '5TEWN72N82Z891171';
  const vehicle = await prisma.vehicle.upsert({
    where: { vin_ownerId: { vin, ownerId: user.id } },
    update: {},
    create: {
      ownerId: user.id,
      vin,
      make: 'Toyota',
      model: 'Tacoma',
      year: 2002,
      nickname: 'Taco',
      colorCode: '3P1',
      engineCode: '5VZ-FE',
      mfrBodyCode: 'VZN170',
      modelNumber: 'VZN170L-CRMDKAB',
      transmissionCode: 'R150F',
      trim: 'Base 4wd 2dr Xtra Cab',
    },
  });

  console.log({ user, account, vehicle });
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
