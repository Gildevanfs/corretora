import { PipeTransform, Injectable, ArgumentMetadata, BadRequestException } from '@nestjs/common';
import { ZodSchema, ZodError, ZodIssue } from 'zod';

@Injectable()
export class ZodValidationPipe implements PipeTransform {
  constructor(private schema: ZodSchema<any>) {}

  transform(value: any, metadata: ArgumentMetadata) {
    const result = this.schema.safeParse(value);

    if (!result.success) {
      throw new BadRequestException(this.formatErrors(result.error));
    }

    return result.data;
  }

  private formatErrors(error: ZodError): { message: string, errors: Array<any> } {
    const formattedErrors = error.errors.map((err: ZodIssue) => {
      // Para erros de tipo (e.g., invalid_type)
      if (err.code === 'invalid_type') {
        return {
          code: err.code,
          expected: err.expected,
          received: err.received !== undefined ? typeof err.received : 'undefined',
          path: err.path,
          message: err.message,
        };
      }

      return {
        code: err.code,
        path: err.path,
        message: err.message,
      };
    });

    return {
      message: 'Validation failed',
      errors: formattedErrors,
    };
  }
}
