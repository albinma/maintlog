import { SignInButton } from '@/app/ui/sign-in';
import { SignOutButton } from '@/app/ui/sign-out';
import { auth } from '@/auth';

export default async function Boop() {
  const session = await auth();
  return session ? <SignOutButton /> : <SignInButton />;
}
