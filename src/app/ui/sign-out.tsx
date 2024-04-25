'use client';

import { signOut } from 'next-auth/react';

export function SignOutButton(): JSX.Element {
  return <button onClick={() => signOut()}>Signout</button>;
}
