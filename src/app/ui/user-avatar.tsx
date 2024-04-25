import { auth } from '@/app/auth';
import Image from 'next/image';

export default async function UserAvatar(): Promise<JSX.Element | null> {
  const session = await auth();

  if (!session || !session.user) {
    return null;
  }

  return (
    <div>
      <Image src={session.user.image ?? ''} alt="User Avatar" />
    </div>
  );
}
