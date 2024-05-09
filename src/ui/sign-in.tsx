'use client';

import { signIn } from 'next-auth/react';
import { Button } from 'react-aria-components';

export function SignInButton() {
  return <Button onPress={() => signIn()}>Sign in</Button>;
}
