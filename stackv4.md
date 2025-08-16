# Project Development Rules & Standards 2025

## 🎯 Core Principles

### MANDATORY: Every code decision must follow this hierarchy
1. **DRY** (Don't Repeat Yourself) - Abstractions over duplication
2. **KISS** (Keep It Simple, Stupid) - Simplicity over complexity
3. **YAGNI** (You Aren't Gonna Need It) - Current needs over future speculation
4. **SOLID** - Design principles for maintainable code

## 📁 Project Structure (Clean Architecture + DDD)

```
project/
├── src/
│   ├── modules/           # Bounded Contexts / Features
│   │   ├── user/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── value-objects/
│   │   │   │   ├── repositories/
│   │   │   │   ├── services/
│   │   │   │   └── events/
│   │   │   ├── application/
│   │   │   │   ├── use-cases/
│   │   │   │   ├── dtos/
│   │   │   │   └── mappers/
│   │   │   ├── infrastructure/
│   │   │   │   ├── repositories/
│   │   │   │   ├── http/
│   │   │   │   └── database/
│   │   │   └── presentation/
│   │   │       ├── controllers/
│   │   │       ├── views/
│   │   │       └── validators/
│   │   └── [other-modules]/
│   ├── shared/            # Cross-cutting concerns
│   │   ├── kernel/        # Core abstractions
│   │   ├── errors/
│   │   ├── utils/
│   │   └── types/
│   └── config/
├── tests/
├── docs/
│   ├── adr/              # Architecture Decision Records
│   └── api/
└── scripts/
```

## 🛠️ Technology Stack Rules

### Core Versions (Latest Stable)
```yaml
runtime:
  node: "22.14.0"      # LTS
  typescript: "5.7.3"  # Strict mode ALWAYS

frontend:
  vite: "^6.0.0"
  react: "^19.0.0"
  mantine: "^7.17.0"
  tanstack-query: "^5.65.0"
  zod: "^3.24.0"

backend:
  fastapi: "^0.116.0"
  python: "3.13"
  pydantic: "^2.10.0"

database:
  postgresql: "17"
  redis: "8"

infrastructure:
  docker: "^27.0.0"
  traefik: "^3.3.0"
```

## 📝 Coding Standards

### Naming Conventions (MANDATORY)

#### TypeScript/JavaScript
```typescript
// PascalCase: Classes, Interfaces, Types, Enums
class UserService {}
interface IUserRepository {}
type UserRole = 'admin' | 'user';
enum Status { ACTIVE, INACTIVE }

// camelCase: Variables, Functions, Methods
const userName = 'John';
function calculateTotal() {}
getUserById(id: string) {}

// UPPER_SNAKE_CASE: Constants, Environment Variables
const MAX_RETRY_ATTEMPTS = 3;
const API_BASE_URL = process.env.API_BASE_URL;

// kebab-case: File names, URLs, CSS classes
// user-service.ts
// /api/user-profile
// .button-primary

// snake_case: Database fields
// created_at, updated_at, user_id
```

#### Python (Backend)
```python
# PascalCase: Classes
class UserService:
    pass

# snake_case: Functions, Variables, Methods
def calculate_total():
    pass

user_name = "John"

# UPPER_SNAKE_CASE: Constants
MAX_RETRY_ATTEMPTS = 3

# snake_case: File names
# user_service.py
```

#### Domain-Driven Design Naming
```typescript
// Events: Past tense, PascalCase
class UserCreatedEvent {}
class OrderShippedEvent {}
class PaymentProcessedEvent {}

// Commands: Imperative, PascalCase
class CreateUserCommand {}
class ShipOrderCommand {}
class ProcessPaymentCommand {}

// Queries: Question format, PascalCase
class GetUserByIdQuery {}
class FindActiveOrdersQuery {}
class CanUserAccessResourceQuery {}

// Value Objects: Descriptive, PascalCase
class EmailAddress {}
class Money {}
class DateRange {}

// Aggregates: Singular, PascalCase
class User {}     // NOT Users
class Order {}    // NOT Orders

// Repositories: Interface with 'I' prefix
interface IUserRepository {}
interface IOrderRepository {}

// Domain Services: Action + Service
class PasswordHashingService {}
class EmailValidationService {}
```

#### API Endpoints Naming
```typescript
// RESTful conventions: kebab-case, plural for collections
GET    /api/v1/users              // List all users
GET    /api/v1/users/:id          // Get specific user
POST   /api/v1/users              // Create user
PUT    /api/v1/users/:id          // Update entire user
PATCH  /api/v1/users/:id          // Partial update
DELETE /api/v1/users/:id          // Delete user

// Nested resources
GET    /api/v1/users/:id/orders   // User's orders
POST   /api/v1/users/:id/avatar   // Upload avatar

// Actions (when REST doesn't fit)
POST   /api/v1/users/:id/activate
POST   /api/v1/orders/:id/cancel
POST   /api/v1/auth/refresh-token
```

#### Database Conventions
```sql
-- Tables: snake_case, plural
CREATE TABLE users (...);
CREATE TABLE order_items (...);

-- Columns: snake_case
id, created_at, updated_at, is_active, total_amount

-- Indexes: idx_tablename_columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_user_id_created_at ON orders(user_id, created_at);

-- Foreign Keys: fk_sourcetable_targettable
ALTER TABLE orders 
  ADD CONSTRAINT fk_orders_users 
  FOREIGN KEY (user_id) REFERENCES users(id);
```

#### Error Codes and Messages
```typescript
// Error codes: UPPER_SNAKE_CASE
const ErrorCodes = {
  USER_NOT_FOUND: 'USER_NOT_FOUND',
  INVALID_CREDENTIALS: 'INVALID_CREDENTIALS',
  INSUFFICIENT_PERMISSIONS: 'INSUFFICIENT_PERMISSIONS',
  VALIDATION_FAILED: 'VALIDATION_FAILED'
} as const;

// Error classes: PascalCase ending with 'Error'
class ValidationError extends Error {}
class NotFoundError extends Error {}
class UnauthorizedError extends Error {}
```

### TypeScript Configuration
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "esModuleInterop": true,
    "skipLibCheck": false,
    "forceConsistentCasingInFileNames": true
  }
}
```

### Biome Configuration (Replaces ESLint + Prettier)
```json
{
  "linter": {
    "enabled": true,
    "rules": {
      "complexity": {
        "noExcessiveCognitiveComplexity": { "maxComplexity": 10 },
        "noVoid": "error",
        "useSimplifiedLogicExpression": "error"
      },
      "correctness": {
        "noUnusedVariables": "error",
        "useExhaustiveDependencies": "error"
      },
      "style": {
        "useConst": "error",
        "useTemplate": "error",
        "noNegationElse": "error"
      }
    }
  },
  "formatter": {
    "indentStyle": "space",
    "indentWidth": 2,
    "lineWidth": 100
  }
}
```

## 🏗️ Architecture Rules

### 1. Domain Layer (Core Business Logic)
```typescript
// ALWAYS: Pure TypeScript, NO framework dependencies
// domain/entities/user.entity.ts
export class User {
  private constructor(
    private readonly id: UserId,
    private email: Email,
    private name: Name
  ) {}

  // Factory method with validation
  static create(props: CreateUserProps): Either<DomainError, User> {
    // Business rules here
  }

  // Domain methods express business operations
  changeEmail(newEmail: Email): Either<DomainError, void> {
    // Business validation
  }
}

// domain/value-objects/email.vo.ts
export class Email {
  private constructor(private readonly value: string) {}
  
  static create(value: string): Either<ValidationError, Email> {
    const schema = z.string().email();
    const result = schema.safeParse(value);
    
    if (!result.success) {
      return left(new ValidationError(result.error));
    }
    
    return right(new Email(result.data));
  }
}
```

### 2. Application Layer (Use Cases)
```typescript
// RULE: One use case = One business operation
// application/use-cases/create-user.use-case.ts
export class CreateUserUseCase {
  constructor(
    private userRepository: UserRepository,
    private emailService: EmailService,
    private eventBus: EventBus
  ) {}

  async execute(dto: CreateUserDto): Promise<Result<UserResponseDto>> {
    // 1. Validate input with Zod
    const validation = CreateUserSchema.safeParse(dto);
    if (!validation.success) {
      return Result.fail(validation.error);
    }

    // 2. Create domain entity
    const userOrError = User.create(validation.data);
    if (userOrError.isLeft()) {
      return Result.fail(userOrError.value);
    }

    // 3. Persist
    await this.userRepository.save(userOrError.value);

    // 4. Side effects
    await this.eventBus.publish(new UserCreatedEvent(userOrError.value));

    // 5. Return DTO
    return Result.ok(UserMapper.toDto(userOrError.value));
  }
}
```

### 3. Infrastructure Layer
```typescript
// RULE: Implementations of domain interfaces
// infrastructure/repositories/user.repository.impl.ts
export class PostgresUserRepository implements UserRepository {
  constructor(private db: DatabaseConnection) {}

  async save(user: User): Promise<void> {
    const data = UserMapper.toPersistence(user);
    await this.db.query(
      'INSERT INTO users (id, email, name) VALUES ($1, $2, $3)',
      [data.id, data.email, data.name]
    );
  }

  async findById(id: UserId): Promise<User | null> {
    const result = await this.db.query(
      'SELECT * FROM users WHERE id = $1',
      [id.value]
    );
    
    return result.rows[0] 
      ? UserMapper.toDomain(result.rows[0])
      : null;
  }
}
```

### 4. Presentation Layer
```typescript
// RULE: Thin controllers, delegate to use cases
// presentation/controllers/user.controller.ts
export class UserController {
  constructor(
    private createUser: CreateUserUseCase,
    private getUser: GetUserUseCase
  ) {}

  @Post('/users')
  @UseValidation(CreateUserSchema)
  async create(@Body() dto: CreateUserDto): Promise<ApiResponse> {
    const result = await this.createUser.execute(dto);
    
    if (result.isFailure) {
      throw new BadRequestException(result.error);
    }
    
    return {
      success: true,
      data: result.value
    };
  }
}
```

## 🔧 Development Workflow Rules

### Git Commit Convention
```bash
# Format: <type>(<scope>): <subject>
# Types: feat, fix, docs, style, refactor, test, chore
# Example:
feat(user): add email verification
fix(auth): resolve JWT expiration issue
docs(api): update swagger documentation
```

### Pre-commit Hooks (Husky + lint-staged)
```json
{
  "lint-staged": {
    "*.{ts,tsx}": [
      "biome check --apply",
      "biome format --write"
    ],
    "*.{json,md}": [
      "biome format --write"
    ]
  }
}
```

### Testing Requirements
```typescript
// RULE: Minimum 80% coverage
// RULE: Test pyramid: Unit > Integration > E2E

// Unit test example
describe('User Entity', () => {
  it('should create a valid user', () => {
    const result = User.create({
      email: 'test@example.com',
      name: 'John Doe'
    });
    
    expect(result.isRight()).toBe(true);
  });

  it('should reject invalid email', () => {
    const result = User.create({
      email: 'invalid',
      name: 'John Doe'
    });
    
    expect(result.isLeft()).toBe(true);
    expect(result.value).toBeInstanceOf(ValidationError);
  });
});
```

## 📊 Data Management Rules

### Zod Validation Schemas
```typescript
// ALWAYS: Define schemas for ALL external data
const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(100),
  age: z.number().int().positive().optional(),
  role: z.enum(['admin', 'user']).default('user')
});

// Type inference from schema
type CreateUserDto = z.infer<typeof CreateUserSchema>;

// Runtime validation
const validate = (data: unknown): CreateUserDto => {
  return CreateUserSchema.parse(data); // Throws on error
};
```

### TanStack Query Patterns
```typescript
// RULE: Centralize query keys
export const userKeys = {
  all: ['users'] as const,
  lists: () => [...userKeys.all, 'list'] as const,
  list: (filters: string) => [...userKeys.lists(), { filters }] as const,
  details: () => [...userKeys.all, 'detail'] as const,
  detail: (id: string) => [...userKeys.details(), id] as const,
};

// RULE: Custom hooks for data fetching
export const useUser = (id: string) => {
  return useQuery({
    queryKey: userKeys.detail(id),
    queryFn: () => userService.getById(id),
    staleTime: 5 * 60 * 1000, // 5 minutes
    gcTime: 10 * 60 * 1000,   // 10 minutes
  });
};

// RULE: Optimistic updates
export const useUpdateUser = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: userService.update,
    onMutate: async (newUser) => {
      await queryClient.cancelQueries({ 
        queryKey: userKeys.detail(newUser.id) 
      });
      
      const previousUser = queryClient.getQueryData(
        userKeys.detail(newUser.id)
      );
      
      queryClient.setQueryData(
        userKeys.detail(newUser.id), 
        newUser
      );
      
      return { previousUser };
    },
    onError: (err, newUser, context) => {
      queryClient.setQueryData(
        userKeys.detail(newUser.id),
        context?.previousUser
      );
    },
    onSettled: (data, error, variables) => {
      queryClient.invalidateQueries({ 
        queryKey: userKeys.detail(variables.id) 
      });
    },
  });
};
```

## 🏛️ Architecture Decision Records (ADR)

### ADR Template
```markdown
# ADR-001: [Decision Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Context
What is the issue that we're seeing that is motivating this decision?

## Decision
What is the change that we're proposing and/or doing?

## Consequences
What becomes easier or more difficult to do because of this change?

## Alternatives Considered
- Option A: Description
- Option B: Description

## References
- Link to relevant documentation
```

### Required ADRs for New Projects
1. **ADR-001**: Technology Stack Selection
2. **ADR-002**: Authentication Strategy
3. **ADR-003**: Database Architecture
4. **ADR-004**: API Design Pattern
5. **ADR-005**: State Management Approach

## 🚀 Performance Rules

### Frontend Performance
- **Bundle Size**: < 200KB initial load
- **Code Splitting**: Route-based mandatory
- **Images**: WebP/AVIF with lazy loading
- **Fonts**: Variable fonts with font-display: swap

### Backend Performance
- **Response Time**: P95 < 200ms
- **Database Queries**: < 50ms
- **Connection Pooling**: Min 10, Max 100
- **Caching**: Redis with 5-minute TTL

### React Optimization
```typescript
// RULE: Use React Compiler (React 19)
// RULE: Minimize re-renders
const ExpensiveComponent = memo(({ data }: Props) => {
  // Use useMemo for expensive computations
  const processed = useMemo(() => 
    expensiveOperation(data), 
    [data]
  );
  
  // Use useCallback for stable references
  const handleClick = useCallback((id: string) => {
    // handler logic
  }, []);
  
  return <div>{/* render */}</div>;
});
```

## 🔒 Security Rules

### Input Validation
- **ALWAYS** validate with Zod at boundaries
- **NEVER** trust client data
- **SANITIZE** all user inputs
- **ESCAPE** HTML content

### Authentication & Authorization
```typescript
// RULE: Use middleware for auth checks
const requireAuth = (roles?: Role[]) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
      throw new UnauthorizedException();
    }
    
    const user = verifyToken(token);
    
    if (roles && !roles.includes(user.role)) {
      throw new ForbiddenException();
    }
    
    req.user = user;
    next();
  };
};

// Usage
router.get('/admin', requireAuth(['admin']), adminController.index);
```

## 📦 Docker Rules

### Multi-stage Builds
```dockerfile
# Build stage
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Runtime stage
FROM gcr.io/distroless/nodejs22:nonroot
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
USER nonroot
EXPOSE 3000
CMD ["dist/index.js"]
```

### Docker Compose Configuration
```yaml
version: '3.9'

services:
  app:
    build:
      context: .
      target: production
    environment:
      NODE_ENV: production
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    healthcheck:
      test: ["CMD", "node", "healthcheck.js"]
      interval: 30s
      timeout: 10s
      retries: 3
```

## ✅ Code Review Checklist

### Before Submitting PR
- [ ] Code follows DDD/Clean Architecture
- [ ] All tests passing (min 80% coverage)
- [ ] No console.log statements
- [ ] Error handling implemented
- [ ] Loading states handled
- [ ] Accessibility checked (WCAG 2.1 AA)
- [ ] Performance impact assessed
- [ ] Security implications reviewed
- [ ] Documentation updated
- [ ] ADR created if architectural change

### Review Points
1. **Business Logic**: In domain layer only?
2. **Dependencies**: Pointing inward only?
3. **Side Effects**: Isolated in infrastructure?
4. **Validation**: Using Zod schemas?
5. **State Management**: Using TanStack Query?
6. **Error Handling**: Comprehensive?
7. **Testing**: Unit + Integration coverage?
8. **Performance**: No N+1 queries?
9. **Security**: Input validated?
10. **Documentation**: Self-explanatory code?

## 🚫 NEVER DO THIS

1. **NEVER** put business logic in controllers
2. **NEVER** import infrastructure in domain
3. **NEVER** use `any` type in TypeScript
4. **NEVER** ignore TypeScript errors
5. **NEVER** commit secrets to repository
6. **NEVER** use synchronous operations for I/O
7. **NEVER** mutate state directly
8. **NEVER** skip error handling
9. **NEVER** use magic numbers/strings
10. **NEVER** deploy without health checks

## 📋 Development Workflow

### 1. Feature Development
```bash
# 1. Create feature branch
git checkout -b feat/user-authentication

# 2. Implement following Clean Architecture
# 3. Write tests (TDD preferred)
# 4. Run quality checks
npm run type-check
npm run lint
npm run test
npm run test:e2e

# 5. Commit with conventional commits
git commit -m "feat(auth): implement JWT authentication"

# 6. Create PR with template
```

### 2. PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] ADR created (if needed)
- [ ] No breaking changes
- [ ] Follows coding standards

## Screenshots (if applicable)
```

## 🎯 Definition of Done

A feature is DONE when:
1. ✅ Code follows Clean Architecture
2. ✅ All tests pass (unit, integration, e2e)
3. ✅ Code coverage > 80%
4. ✅ Documentation updated
5. ✅ Code reviewed and approved
6. ✅ No security vulnerabilities
7. ✅ Performance benchmarks met
8. ✅ Deployed to staging
9. ✅ Monitoring configured
10. ✅ Feature flag created (if needed)

---

**Remember**: These rules are NOT suggestions. They are MANDATORY standards that ensure code quality, maintainability, and scalability.
