# Professional Next.js Development Setup Guide

## Overview
This guide documents the step-by-step process to transform a basic Next.js project into a professional-grade development environment with proper tooling, testing, and code quality standards.

## ✅ **Phase 1: Performance & Code Quality (Essential)**

### 1. Performance Optimization
**What**: Optimize React re-renders and expensive operations
**Why**: Better user experience and faster app performance

```tsx
// Before: Re-calculates every render
const isStudio = pathname?.startsWith('/studio');

// After: Only recalculates when pathname changes
const isStudio = useMemo(() => pathname?.startsWith('/studio'), [pathname]);
```

**Commands**:
```bash
# Add useMemo import
import React, { useMemo } from "react";
```

### 2. ESLint & Prettier Setup
**What**: Automated code quality checking and formatting
**Why**: Consistent code style, catch bugs early, professional standards

**Installation**:
```bash
npm install --save-dev eslint prettier eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
```

**Configuration Files**:

`.eslintrc.json`:
```json
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint", "prettier"],
  "rules": {
    "prettier/prettier": "error",
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "warn",
    "react-hooks/exhaustive-deps": "warn",
    "prefer-const": "error",
    "no-var": "error"
  }
}
```

`.prettierrc.json`:
```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": false,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
```

### 3. TypeScript Type Safety
**What**: Proper typing for components and configurations
**Why**: Catch errors at compile time, better IDE support, self-documenting code

**Create** `/src/types/layout.ts`:
```typescript
export interface LayoutProps {
  children: React.ReactNode;
}

export interface StudioConfig {
  basePath: string;
  isStudioRoute: (pathname: string) => boolean;
}

export const STUDIO_CONFIG: StudioConfig = {
  basePath: "/studio",
  isStudioRoute: (pathname: string) => 
    pathname === "/studio" || pathname?.startsWith("/studio/"),
};
```

## ✅ **Phase 2: Testing Infrastructure (Critical)**

### 4. Jest & Testing Library Setup
**What**: Automated testing for components and business logic
**Why**: Prevent regressions, document expected behavior, confidence in changes

**Installation**:
```bash
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event jest jest-environment-jsdom @types/jest
```

**Configuration** `jest.config.mjs`:
```javascript
import nextJest from 'next/jest.js'

const createJestConfig = nextJest({
  dir: './',
})

const config = {
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  testEnvironment: 'jsdom',
  testMatch: [
    '**/__tests__/**/*.(ts|tsx|js)',
    '**/*.(test|spec).(ts|tsx|js)'
  ],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
  collectCoverageFrom: [
    'src/**/*.{ts,tsx}',
    '!src/**/*.d.ts',
    '!src/types/**/*',
  ],
}

export default createJestConfig(config)
```

**Setup** `jest.setup.js`:
```javascript
import '@testing-library/jest-dom';
```

### 5. Example Test Implementation
**Create** `/src/__tests__/layout.test.ts`:
```typescript
import { STUDIO_CONFIG } from '@/types/layout';

describe('Layout Configuration', () => {
  describe('STUDIO_CONFIG', () => {
    it('should correctly identify studio routes', () => {
      expect(STUDIO_CONFIG.isStudioRoute('/studio')).toBe(true);
      expect(STUDIO_CONFIG.isStudioRoute('/studio/products')).toBe(true);
    });

    it('should correctly identify non-studio routes', () => {
      expect(STUDIO_CONFIG.isStudioRoute('/')).toBe(false);
      expect(STUDIO_CONFIG.isStudioRoute('/my-toys')).toBe(false);
    });
  });
});
```

## ✅ **Phase 3: Package Scripts (Workflow)**

### 6. Professional Scripts
**Update** `package.json`:
```json
{
  "scripts": {
    "dev": "next dev --turbopack",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "format": "prettier --write \"src/**/*.{ts,tsx,js,jsx,json,css,md}\"",
    "format:check": "prettier --check \"src/**/*.{ts,tsx,js,jsx,json,css,md}\"",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "type-check": "tsc --noEmit"
  }
}
```

## 🔧 **Daily Development Workflow**

### Before Committing:
```bash
npm run type-check    # Check TypeScript errors
npm run lint          # Check code quality
npm run test          # Run tests
npm run format        # Format code
```

### During Development:
```bash
npm run dev           # Start development server
npm run test:watch    # Watch tests while coding
npm run lint:fix      # Auto-fix linting issues
```

## 📈 **Benefits Achieved**

1. **Code Quality**: Consistent formatting, no style debates
2. **Bug Prevention**: ESLint catches common mistakes
3. **Type Safety**: TypeScript prevents runtime errors
4. **Test Coverage**: Confidence in code changes
5. **Professional Workflow**: Industry-standard development process

## 🚀 **Next Steps (Project-Specific)**

### Phase 4: Error Handling
- Error boundaries for React components
- Graceful fallbacks for failed API calls

### Phase 5: CI/CD Pipeline
- GitHub Actions for automated testing
- Deployment automation

### Phase 6: Production Optimization
- Bundle analysis and optimization
- Performance monitoring

## 📋 **Checklist for New Projects**

- [ ] Install ESLint & Prettier
- [ ] Configure TypeScript strict mode
- [ ] Setup Jest & Testing Library
- [ ] Create type definitions
- [ ] Add package.json scripts
- [ ] Write first tests
- [ ] Setup pre-commit hooks (optional)

---

**Time Investment**: ~2-3 hours setup
**Long-term Savings**: Weeks of debugging and maintenance
**Professional Standard**: ✅ Industry-grade development environment

---

*Copy this guide for future projects to maintain consistent professional standards.*
