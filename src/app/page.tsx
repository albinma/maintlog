import NavBar from '@/app/components/navbar';
import { auth } from '@/auth';

export default async function Home(): Promise<JSX.Element> {
  const session = await auth();

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <NavBar session={session} />
    </main>
  );
}
