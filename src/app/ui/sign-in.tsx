'use client';

import { signIn } from 'next-auth/react';

export function SignInButton(): JSX.Element {
  return <button onClick={() => signIn()}>Sign in</button>;
}
