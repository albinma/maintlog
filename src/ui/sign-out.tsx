'use client';

import { signOut } from 'next-auth/react';
import { Button } from 'react-aria-components';

export function SignOutButton() {
  return (
    <Button className="border border-black p-2" onPress={() => signOut()}>
      Signout
    </Button>
  );
}
