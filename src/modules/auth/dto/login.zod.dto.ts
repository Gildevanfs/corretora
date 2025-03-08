import { z } from 'zod';

export const signInSchema = z.object({
  username: z.string().min(3, { message: 'Minimo de três caracteres' }),
  password: z.string().min(8, { message: 'Minimo de oito caracteres' }),
  tt: z.string()
}).required();

export type SignInDto = z.infer<typeof signInSchema>;