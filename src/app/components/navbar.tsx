import VehicleSelect from '@/app/components/vehicle-select';
import { SignInButton } from '@/ui/sign-in';
import { SignOutButton } from '@/ui/sign-out';
import { Session } from 'next-auth';

export default function NavBar({ session }: { session: Session | null }) {
  return (
    <nav className="bg-white dark:bg-gray-900 fixed w-full z-20 top-0 start-0 border-b border-gray-200 dark:border-gray-600">
      <div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <a href="#" className="flex items-center space-x-3 rtl:space-x-reverse">
          <span className="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">
            maintlog
          </span>
        </a>
        <div className="flex md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
          <VehicleSelect />
          {session ? <SignOutButton /> : <SignInButton />}
        </div>
      </div>
    </nav>
  );
}
