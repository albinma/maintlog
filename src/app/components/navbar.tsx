import VehicleSelect from '@/app/components/vehicle-select';
import prisma from '@/initializers/prisma';
import { SignInButton } from '@/ui/sign-in';
import { SignOutButton } from '@/ui/sign-out';
import { Session } from 'next-auth';

export default async function NavBar({ session }: { session: Session | null }) {
  const userId = session?.user?.id;
  const vehicleNames: string[] = [];

  if (userId) {
    const vehicles = await prisma.vehicle.findMany({
      where: {
        ownerId: userId,
      },
    });

    vehicleNames.push(
      ...vehicles.map(
        (vehicle) => vehicle.nickname ?? `${vehicle.year} ${vehicle.make} ${vehicle.model}`,
      ),
    );
  }

  return (
    <nav className="bg-white fixed w-full z-20 top-0 start-0 border border-black">
      <div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <a href="#" className="flex items-center space-x-3 rtl:space-x-reverse">
          <span className="self-center text-2xl font-semibold whitespace-nowrap">maintlog</span>
        </a>
        <div className="flex md:order-2 space-x-3">
          <div className="flex">
            <VehicleSelect vehicleNames={vehicleNames} />
          </div>
          <div className="flex">{session ? <SignOutButton /> : <SignInButton />}</div>
        </div>
      </div>
    </nav>
  );
}
