import prisma from '@/initializers/prisma';
import { PrismaAdapter } from '@auth/prisma-adapter';
import NextAuth from 'next-auth';
import Google from 'next-auth/providers/google';

export const { handlers, signIn, signOut, auth } = NextAuth({
  adapter: PrismaAdapter(prisma),
  session: {
    strategy: 'jwt',
  },
  providers: [
    Google,
    // Credentials({
    //   // You can specify which fields should be submitted, by adding keys to the `credentials` object.
    //   // e.g. domain, username, password, 2FA token, etc.
    //   credentials: {
    //     email: {
    //       type: 'email',
    //     },
    //     password: {
    //       type: 'password',
    //     },
    //   },
    //   authorize: async (credentials) => {
    //     try {
    //       const { email, password } = await signInSchema.parseAsync(credentials);

    //       const dbUser = await prisma.user.findUnique({
    //         where: { email },
    //       });

    //       if (!dbUser || dbUser.password !== password) {
    //         // No user found, so this is their first attempt to login
    //         // meaning this is also the place you could do registration
    //         throw new Error('User not found.');
    //       }

    //       // return user object with the their profile data
    //       return { id: dbUser.id.toString(), email, name: dbUser.name };
    //     } catch (error) {
    //       if (error instanceof ZodError) {
    //         // Return `null` to indicate that the credentials are invalid
    //         return null;
    //       } else {
    //         throw error;
    //       }
    //     }
    //   },
    // }),
  ],
});
