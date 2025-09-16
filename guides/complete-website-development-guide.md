# 🚀 Complete Website Development Guide: From Zero to Production

**A comprehensive step-by-step guide for building professional websites like Yarn Toys**

> **🎯 Goal:** Transform a simple idea into a production-ready, professional website with modern development practices.

---

## 📋 **Table of Contents**

1. [Project Planning & Setup](#-project-planning--setup)
2. [Foundation Development](#-foundation-development)
3. [Core Features Implementation](#-core-features-implementation)
4. [Professional Standards](#-professional-standards)
5. [Content Management](#-content-management)
6. [Testing & Quality Assurance](#-testing--quality-assurance)
7. [Performance Optimization](#-performance-optimization)
8. [Production Deployment](#-production-deployment)
9. [Maintenance & Updates](#-maintenance--updates)
10. [Team Collaboration](#-team-collaboration)

---

## 📅 **Phase 1: Project Planning & Setup (Week 1)**

### **Day 1-2: Project Discovery & Planning**

#### 🎯 **Define Your Project**
```markdown
## Project Requirements Checklist:
- [ ] What is the website's main purpose?
- [ ] Who is the target audience?
- [ ] What are the core features needed?
- [ ] What's the expected timeline?
- [ ] What's the budget/resource constraint?
- [ ] Will you need a content management system?
- [ ] Do you need e-commerce functionality?
- [ ] What devices/browsers need support?
```

#### 📊 **Technology Stack Decision**
**For Yarn Toys-style projects, consider:**

```typescript
// Recommended Modern Stack (2025)
const techStack = {
  framework: "Next.js 15", // React with app router
  styling: "Tailwind CSS", // Utility-first CSS
  contentManagement: "Sanity Studio", // Headless CMS
  database: "Sanity (cloud)", // Or Supabase/PlanetScale
  deployment: "Vercel", // Or Netlify
  typeScript: true, // Always use TypeScript
  testing: "Jest + Testing Library",
  linting: "ESLint + Prettier",
};
```

**Why this stack?**
- ✅ **Next.js:** Performance, SEO, modern React features
- ✅ **Tailwind:** Rapid styling, responsive design
- ✅ **Sanity:** User-friendly content management
- ✅ **TypeScript:** Type safety, better developer experience
- ✅ **Vercel:** Zero-config deployment, excellent Next.js integration

### **Day 3: Initial Setup**

#### 🛠️ **Create Project Foundation**
```bash
# 1. Initialize Next.js project with TypeScript
npx create-next-app@latest my-project --typescript --tailwind --eslint --app

# 2. Navigate to project
cd my-project

# 3. Install additional dependencies
npm install @sanity/client @sanity/image-url lucide-react

# 4. Initialize git repository
git init
git add .
git commit -m "initial: create Next.js project with TypeScript and Tailwind"
```

#### 📁 **Setup Project Structure**
```
my-project/
├── src/
│   ├── app/                    # Next.js 13+ app directory
│   │   ├── globals.css
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   ├── (site)/            # Route groups for main site
│   │   └── studio/            # Sanity Studio route
│   ├── components/
│   │   ├── ui/                # Reusable UI components
│   │   ├── sections/          # Page sections
│   │   ├── layout/            # Layout components
│   │   └── [feature]/         # Feature-specific components
│   ├── lib/                   # Utility functions
│   ├── types/                 # TypeScript type definitions
│   └── hooks/                 # Custom React hooks
├── docs/                      # Project documentation
├── public/                    # Static assets
└── sanity/                    # Sanity configuration
```

#### 🎨 **Setup Basic Styling**
```typescript
// tailwind.config.js - Custom configuration
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        // Define your brand colors
        primary: {
          50: '#fdf2f8',
          500: '#ec4899',
          900: '#831843',
        },
        // Add more custom colors
      },
      fontFamily: {
        // Add custom fonts
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
```

**📌 Milestone 1 Commit:**
```bash
git add .
git commit -m "setup: basic project structure and configuration"
git tag v0.1.0-setup
```

---

## 🏗️ **Phase 2: Foundation Development (Week 2-3)**

### **Week 2: Core Layout & Navigation**

#### 🎯 **Build Layout System**
```tsx
// src/app/layout.tsx - Root layout
export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className="font-sans">
        <MainNavigation />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  )
}
```

#### 📱 **Create Responsive Components**
```tsx
// src/components/layout/MainNavigation.tsx
"use client";

import { useState } from 'react';
import Link from 'next/link';
import { Menu, X } from 'lucide-react';

export default function MainNavigation() {
  const [isOpen, setIsOpen] = useState(false);

  const navItems = [
    { href: '/', label: 'Home' },
    { href: '/about', label: 'About' },
    { href: '/products', label: 'Products' },
    { href: '/contact', label: 'Contact' },
  ];

  return (
    <nav className="bg-white shadow-sm">
      {/* Desktop Navigation */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex items-center">
            <Link href="/" className="text-xl font-bold text-gray-900">
              Your Brand
            </Link>
          </div>
          
          {/* Desktop Menu */}
          <div className="hidden md:flex items-center space-x-8">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className="text-gray-600 hover:text-gray-900 transition-colors"
              >
                {item.label}
              </Link>
            ))}
          </div>

          {/* Mobile menu button */}
          <div className="md:hidden flex items-center">
            <button
              onClick={() => setIsOpen(!isOpen)}
              className="text-gray-600 hover:text-gray-900"
            >
              {isOpen ? <X size={24} /> : <Menu size={24} />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Menu */}
      {isOpen && (
        <div className="md:hidden">
          <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className="block px-3 py-2 text-gray-600 hover:text-gray-900"
                onClick={() => setIsOpen(false)}
              >
                {item.label}
              </Link>
            ))}
          </div>
        </div>
      )}
    </nav>
  );
}
```

#### 🎨 **Design System Components**
```tsx
// src/components/ui/Button.tsx
interface ButtonProps {
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'sm' | 'md' | 'lg';
  children: React.ReactNode;
  onClick?: () => void;
  href?: string;
  className?: string;
}

export default function Button({
  variant = 'primary',
  size = 'md',
  children,
  onClick,
  href,
  className = '',
}: ButtonProps) {
  const baseClasses = 'inline-flex items-center justify-center font-medium rounded-lg transition-colors';
  
  const variants = {
    primary: 'bg-primary-500 text-white hover:bg-primary-600',
    secondary: 'bg-gray-100 text-gray-900 hover:bg-gray-200',
    outline: 'border border-gray-300 text-gray-700 hover:bg-gray-50',
  };

  const sizes = {
    sm: 'px-3 py-2 text-sm',
    md: 'px-4 py-2 text-base',
    lg: 'px-6 py-3 text-lg',
  };

  const classes = `${baseClasses} ${variants[variant]} ${sizes[size]} ${className}`;

  if (href) {
    return (
      <Link href={href} className={classes}>
        {children}
      </Link>
    );
  }

  return (
    <button onClick={onClick} className={classes}>
      {children}
    </button>
  );
}
```

**📌 Milestone 2 Commit:**
```bash
git add .
git commit -m "feat: implement responsive navigation and design system components"
git tag v0.2.0-foundation
```

### **Week 3: Content Pages & Basic Functionality**

#### 📄 **Create Core Pages**
```tsx
// src/app/page.tsx - Homepage
import HeroSection from '@/components/sections/HeroSection';
import FeaturesSection from '@/components/sections/FeaturesSection';
import CTASection from '@/components/sections/CTASection';

export default function HomePage() {
  return (
    <>
      <HeroSection />
      <FeaturesSection />
      <CTASection />
    </>
  );
}
```

#### 🎭 **Build Reusable Sections**
```tsx
// src/components/sections/HeroSection.tsx
export default function HeroSection() {
  return (
    <section className="bg-gradient-to-r from-primary-50 to-primary-100">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
        <div className="text-center">
          <h1 className="text-4xl md:text-6xl font-bold text-gray-900 mb-6">
            Welcome to{' '}
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-primary-500 to-primary-600">
              Your Brand
            </span>
          </h1>
          <p className="text-xl text-gray-600 mb-8 max-w-3xl mx-auto">
            Create amazing experiences with our modern, responsive, and 
            performance-optimized website solution.
          </p>
          <div className="space-x-4">
            <Button href="/products" size="lg">
              Get Started
            </Button>
            <Button variant="outline" href="/about" size="lg">
              Learn More
            </Button>
          </div>
        </div>
      </div>
    </section>
  );
}
```

**📌 Milestone 3 Commit:**
```bash
git add .
git commit -m "feat: add core pages and reusable section components"
git tag v0.3.0-content
```

---

## 🎯 **Phase 3: Core Features Implementation (Week 4-6)**

### **Week 4: Feature Development**

#### 📦 **Product/Content Display**
```tsx
// src/components/ProductCard.tsx
interface Product {
  id: string;
  title: string;
  description: string;
  image: string;
  price?: number;
  slug: string;
}

interface ProductCardProps {
  product: Product;
}

export default function ProductCard({ product }: ProductCardProps) {
  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
      <div className="aspect-w-16 aspect-h-9">
        <Image
          src={product.image}
          alt={product.title}
          fill
          className="object-cover"
        />
      </div>
      <div className="p-6">
        <h3 className="text-xl font-semibold text-gray-900 mb-2">
          {product.title}
        </h3>
        <p className="text-gray-600 mb-4">
          {product.description}
        </p>
        {product.price && (
          <p className="text-2xl font-bold text-primary-500 mb-4">
            ${product.price}
          </p>
        )}
        <Button href={`/products/${product.slug}`} className="w-full">
          View Details
        </Button>
      </div>
    </div>
  );
}
```

#### 🔍 **Search & Filter Functionality**
```tsx
// src/components/SearchFilters.tsx
"use client";

import { useState } from 'react';
import { Search } from 'lucide-react';

interface SearchFiltersProps {
  onSearch: (query: string) => void;
  onFilter: (filters: Record<string, string>) => void;
}

export default function SearchFilters({ onSearch, onFilter }: SearchFiltersProps) {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');

  const categories = [
    { value: 'all', label: 'All Categories' },
    { value: 'toys', label: 'Toys' },
    { value: 'accessories', label: 'Accessories' },
    { value: 'clothing', label: 'Clothing' },
  ];

  const handleSearch = (query: string) => {
    setSearchQuery(query);
    onSearch(query);
  };

  const handleCategoryChange = (category: string) => {
    setSelectedCategory(category);
    onFilter({ category });
  };

  return (
    <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
      <div className="flex flex-col md:flex-row gap-4">
        {/* Search Input */}
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" size={20} />
          <input
            type="text"
            placeholder="Search products..."
            value={searchQuery}
            onChange={(e) => handleSearch(e.target.value)}
            className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
          />
        </div>

        {/* Category Filter */}
        <select
          value={selectedCategory}
          onChange={(e) => handleCategoryChange(e.target.value)}
          className="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
        >
          {categories.map((category) => (
            <option key={category.value} value={category.value}>
              {category.label}
            </option>
          ))}
        </select>
      </div>
    </div>
  );
}
```

**📌 Milestone 4 Commit:**
```bash
git add .
git commit -m "feat: implement product display and search/filter functionality"
git tag v0.4.0-features
```

---

## 🎖️ **Phase 4: Professional Standards (Week 7-8)**

### **Week 7: Code Quality & Development Tools**

#### 🔧 **Setup Professional Tooling**
```bash
# Install development dependencies
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier
npm install --save-dev jest @testing-library/react @testing-library/jest-dom
npm install --save-dev jest-environment-jsdom
```

#### 📝 **Configuration Files**
```json
// .eslintrc.json
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
    "prefer-const": "error"
  },
  "parserOptions": {
    "ecmaVersion": 2021,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true
    }
  }
}
```

```json
// .prettierrc.json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
```

#### 🧪 **Testing Setup**
```javascript
// jest.config.mjs
const config = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  testPathIgnorePatterns: ['<rootDir>/.next/', '<rootDir>/node_modules/'],
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
};

export default config;
```

```javascript
// jest.setup.js
import '@testing-library/jest-dom';
```

#### ✅ **Package.json Scripts**
```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "type-check": "tsc --noEmit"
  }
}
```

#### 🎭 **TypeScript Improvements**
```typescript
// src/types/index.ts
export interface Product {
  id: string;
  title: string;
  description: string;
  image: string;
  price?: number;
  slug: string;
  category: string;
  tags: string[];
  createdAt: string;
  updatedAt: string;
}

export interface User {
  id: string;
  name: string;
  email: string;
  avatar?: string;
}

export interface ApiResponse<T> {
  data: T;
  message: string;
  success: boolean;
}
```

**📌 Milestone 5 Commit:**
```bash
git add .
git commit -m "feat: implement professional development standards and tooling"
git tag v1.0.0-professional
```

---

## 📊 **Phase 5: Content Management (Week 9-10)**

### **Week 9: Sanity Studio Integration**

#### 🏗️ **Setup Sanity**
```bash
# Install Sanity
npm install @sanity/client @sanity/image-url next-sanity

# Create Sanity project
npx create-sanity@latest
```

#### 📋 **Schema Definition**
```typescript
// sanity/schemas/product.ts
export default {
  name: 'product',
  title: 'Product',
  type: 'document',
  icon: () => '🧸',
  fields: [
    {
      name: 'title',
      title: 'Title',
      type: 'string',
      validation: Rule => Rule.required(),
    },
    {
      name: 'slug',
      title: 'Slug',
      type: 'slug',
      options: {
        source: 'title',
        maxLength: 96,
      },
      validation: Rule => Rule.required(),
    },
    {
      name: 'description',
      title: 'Description',
      type: 'text',
      rows: 4,
    },
    {
      name: 'image',
      title: 'Main Image',
      type: 'image',
      options: {
        hotspot: true,
      },
      validation: Rule => Rule.required(),
    },
    {
      name: 'gallery',
      title: 'Image Gallery',
      type: 'array',
      of: [{ type: 'image' }],
    },
    {
      name: 'price',
      title: 'Price',
      type: 'number',
      validation: Rule => Rule.positive(),
    },
    {
      name: 'category',
      title: 'Category',
      type: 'reference',
      to: [{ type: 'category' }],
    },
    {
      name: 'tags',
      title: 'Tags',
      type: 'array',
      of: [{ type: 'string' }],
    },
    {
      name: 'featured',
      title: 'Featured Product',
      type: 'boolean',
      initialValue: false,
    },
  ],
  preview: {
    select: {
      title: 'title',
      media: 'image',
      price: 'price',
    },
    prepare(selection) {
      const { title, media, price } = selection;
      return {
        title,
        subtitle: price ? `$${price}` : 'No price set',
        media,
      };
    },
  },
};
```

#### 🔗 **Data Fetching**
```typescript
// src/lib/sanity.ts
import { createClient } from '@sanity/client';
import imageUrlBuilder from '@sanity/image-url';

export const client = createClient({
  projectId: process.env.NEXT_PUBLIC_SANITY_PROJECT_ID!,
  dataset: process.env.NEXT_PUBLIC_SANITY_DATASET || 'production',
  useCdn: true,
  apiVersion: '2023-12-01',
});

const builder = imageUrlBuilder(client);

export function urlFor(source: any) {
  return builder.image(source);
}

// API functions
export async function getProducts() {
  return client.fetch(`
    *[_type == "product"] | order(createdAt desc) {
      _id,
      title,
      slug,
      description,
      image,
      price,
      category->{title, slug},
      tags,
      featured
    }
  `);
}

export async function getProduct(slug: string) {
  return client.fetch(`
    *[_type == "product" && slug.current == $slug][0] {
      _id,
      title,
      slug,
      description,
      image,
      gallery,
      price,
      category->{title, slug},
      tags,
      featured
    }
  `, { slug });
}
```

**📌 Milestone 6 Commit:**
```bash
git add .
git commit -m "feat: integrate Sanity CMS with schema and data fetching"
git tag v1.1.0-cms
```

---

## 🧪 **Phase 6: Testing & Quality Assurance (Week 11)**

### **Comprehensive Testing Strategy**

#### 🎯 **Component Testing**
```typescript
// src/__tests__/components/Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import Button from '@/components/ui/Button';

describe('Button Component', () => {
  it('renders correctly with default props', () => {
    render(<Button>Click me</Button>);
    const button = screen.getByRole('button', { name: /click me/i });
    expect(button).toBeInTheDocument();
    expect(button).toHaveClass('bg-primary-500');
  });

  it('applies variant classes correctly', () => {
    render(<Button variant="secondary">Secondary</Button>);
    const button = screen.getByRole('button');
    expect(button).toHaveClass('bg-gray-100');
  });

  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    const button = screen.getByRole('button');
    fireEvent.click(button);
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('renders as link when href is provided', () => {
    render(<Button href="/test">Link Button</Button>);
    const link = screen.getByRole('link');
    expect(link).toHaveAttribute('href', '/test');
  });
});
```

#### 📄 **Page Testing**
```typescript
// src/__tests__/pages/HomePage.test.tsx
import { render, screen } from '@testing-library/react';
import HomePage from '@/app/page';

// Mock the sections
jest.mock('@/components/sections/HeroSection', () => {
  return function MockedHeroSection() {
    return <div data-testid="hero-section">Hero Section</div>;
  };
});

describe('HomePage', () => {
  it('renders all main sections', () => {
    render(<HomePage />);
    
    expect(screen.getByTestId('hero-section')).toBeInTheDocument();
    // Add more section tests
  });
});
```

#### 🔧 **Utility Testing**
```typescript
// src/__tests__/lib/utils.test.ts
import { formatPrice, slugify } from '@/lib/utils';

describe('Utility Functions', () => {
  describe('formatPrice', () => {
    it('formats price correctly', () => {
      expect(formatPrice(29.99)).toBe('$29.99');
      expect(formatPrice(0)).toBe('$0.00');
    });
  });

  describe('slugify', () => {
    it('creates valid slugs', () => {
      expect(slugify('Hello World')).toBe('hello-world');
      expect(slugify('Special Characters!')).toBe('special-characters');
    });
  });
});
```

**📌 Milestone 7 Commit:**
```bash
git add .
git commit -m "feat: implement comprehensive testing suite"
git tag v1.2.0-testing
```

---

## ⚡ **Phase 7: Performance Optimization (Week 12)**

### **Performance Best Practices**

#### 🖼️ **Image Optimization**
```tsx
// src/components/OptimizedImage.tsx
import Image from 'next/image';
import { useState } from 'react';

interface OptimizedImageProps {
  src: string;
  alt: string;
  width?: number;
  height?: number;
  fill?: boolean;
  className?: string;
  priority?: boolean;
}

export default function OptimizedImage({
  src,
  alt,
  width,
  height,
  fill,
  className,
  priority = false,
}: OptimizedImageProps) {
  const [isLoading, setIsLoading] = useState(true);

  return (
    <div className={`relative ${className || ''}`}>
      <Image
        src={src}
        alt={alt}
        width={width}
        height={height}
        fill={fill}
        priority={priority}
        className={`transition-opacity duration-300 ${
          isLoading ? 'opacity-0' : 'opacity-100'
        }`}
        onLoadingComplete={() => setIsLoading(false)}
      />
      {isLoading && (
        <div className="absolute inset-0 bg-gray-200 animate-pulse rounded" />
      )}
    </div>
  );
}
```

#### 📱 **Lazy Loading Components**
```tsx
// src/components/LazySection.tsx
import dynamic from 'next/dynamic';
import { Suspense } from 'react';

const HeavyComponent = dynamic(
  () => import('@/components/HeavyComponent'),
  {
    loading: () => <div className="h-64 bg-gray-100 animate-pulse rounded" />,
    ssr: false, // Disable server-side rendering for this component
  }
);

export default function LazySection() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <HeavyComponent />
    </Suspense>
  );
}
```

#### 🔄 **Data Fetching Optimization**
```typescript
// src/hooks/useProducts.ts
import { useState, useEffect } from 'react';
import { getProducts } from '@/lib/sanity';
import type { Product } from '@/types';

export function useProducts() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchProducts() {
      try {
        setLoading(true);
        const data = await getProducts();
        setProducts(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch products');
      } finally {
        setLoading(false);
      }
    }

    fetchProducts();
  }, []);

  return { products, loading, error };
}
```

#### 📊 **Performance Monitoring**
```typescript
// src/lib/analytics.ts
export function trackPageView(url: string) {
  if (typeof window !== 'undefined' && window.gtag) {
    window.gtag('config', process.env.NEXT_PUBLIC_GA_ID, {
      page_path: url,
    });
  }
}

export function trackEvent(action: string, category: string, label?: string) {
  if (typeof window !== 'undefined' && window.gtag) {
    window.gtag('event', action, {
      event_category: category,
      event_label: label,
    });
  }
}
```

**📌 Milestone 8 Commit:**
```bash
git add .
git commit -m "feat: implement performance optimizations and monitoring"
git tag v1.3.0-performance
```

---

## 🚀 **Phase 8: Production Deployment (Week 13)**

### **Pre-Deployment Checklist**

#### ✅ **Final Quality Checks**
```bash
# Run all quality checks
npm run lint           # ESLint check
npm run type-check     # TypeScript check
npm run test           # Jest tests
npm run build          # Production build
npm run format:check   # Prettier check
```

#### 🔒 **Environment Variables**
```bash
# .env.local (development)
NEXT_PUBLIC_SANITY_PROJECT_ID=your_project_id
NEXT_PUBLIC_SANITY_DATASET=production
SANITY_API_TOKEN=your_api_token
NEXT_PUBLIC_GA_ID=your_google_analytics_id
```

#### 🌐 **Vercel Deployment**
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy to Vercel
vercel

# Set environment variables in Vercel dashboard
# Configure custom domain
# Enable analytics
```

#### 📊 **SEO & Meta Tags**
```tsx
// src/app/layout.tsx
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: {
    default: 'Your Brand - Quality Products',
    template: '%s | Your Brand'
  },
  description: 'Discover amazing handmade products with exceptional quality and care.',
  keywords: ['handmade', 'quality', 'products', 'crafts'],
  authors: [{ name: 'Your Name' }],
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: 'https://yourdomain.com',
    siteName: 'Your Brand',
    images: [
      {
        url: '/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'Your Brand',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    site: '@yourbrand',
    creator: '@yourname',
  },
  robots: {
    index: true,
    follow: true,
  },
};
```

**📌 Milestone 9 Commit:**
```bash
git add .
git commit -m "feat: prepare for production deployment with SEO and optimization"
git tag v2.0.0-production
```

---

## 🔄 **Phase 9: Maintenance & Updates (Ongoing)**

### **Regular Maintenance Tasks**

#### 📅 **Weekly Tasks**
- [ ] Update dependencies (`npm update`)
- [ ] Review analytics and performance metrics
- [ ] Check for broken links or images
- [ ] Monitor error logs
- [ ] Backup content from Sanity

#### 📅 **Monthly Tasks**
- [ ] Security audit (`npm audit`)
- [ ] Performance testing with Lighthouse
- [ ] Content review and updates
- [ ] SEO analysis and improvements
- [ ] User feedback review

#### 📅 **Quarterly Tasks**
- [ ] Major dependency updates
- [ ] Feature planning and roadmap review
- [ ] A/B testing for key pages
- [ ] Accessibility audit
- [ ] Competitive analysis

### **Monitoring & Alerts**
```typescript
// src/lib/monitoring.ts
export function setupErrorTracking() {
  if (process.env.NODE_ENV === 'production') {
    window.addEventListener('error', (event) => {
      console.error('Global error:', event.error);
      // Send to your error tracking service
      trackEvent('error', 'javascript', event.error.message);
    });

    window.addEventListener('unhandledrejection', (event) => {
      console.error('Unhandled promise rejection:', event.reason);
      // Send to your error tracking service
      trackEvent('error', 'promise', event.reason);
    });
  }
}
```

---

## 👥 **Phase 10: Team Collaboration**

### **Documentation Standards**

#### 📚 **Component Documentation**
```tsx
/**
 * ProductCard Component
 * 
 * Displays product information in a card format with image, title, description, and price.
 * Supports click-through to product detail page.
 * 
 * @param product - Product object containing all product information
 * @param variant - Card display variant: 'default' | 'compact' | 'featured'
 * @param showPrice - Whether to display the price (default: true)
 * 
 * @example
 * ```tsx
 * <ProductCard 
 *   product={product} 
 *   variant="featured" 
 *   showPrice={true} 
 * />
 * ```
 */
interface ProductCardProps {
  product: Product;
  variant?: 'default' | 'compact' | 'featured';
  showPrice?: boolean;
}
```

#### 🔄 **Git Workflow**
```bash
# Feature branch workflow
git checkout -b feature/new-component
git add .
git commit -m "feat: add new component with tests and documentation"
git push origin feature/new-component
# Create pull request
```

#### 📋 **Pull Request Template**
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added for new functionality
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
```

---

## 🎯 **Success Metrics & KPIs**

### **Technical Metrics**
- ⚡ **Performance:** Lighthouse score > 90
- 🔍 **SEO:** Google PageSpeed Insights > 90
- 🛡️ **Security:** No vulnerabilities in npm audit
- 📊 **Code Quality:** ESLint score 0 errors/warnings
- 🧪 **Testing:** Code coverage > 80%

### **Business Metrics**
- 📈 **Traffic:** Monthly unique visitors
- 🎯 **Conversion:** Contact form submissions
- 📱 **Engagement:** Average session duration
- 🔄 **Retention:** Returning visitor percentage
- 📞 **Support:** Reduced support tickets

### **User Experience Metrics**
- ⚡ **Loading:** Core Web Vitals in green
- 📱 **Mobile:** Mobile-friendly score > 95
- ♿ **Accessibility:** WCAG 2.1 AA compliance
- 🔧 **Usability:** User task completion rate

---

## 📚 **Additional Resources**

### **Learning Resources**
- [Next.js Documentation](https://nextjs.org/docs)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [Sanity Documentation](https://www.sanity.io/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

### **Tools & Services**
- [Vercel](https://vercel.com) - Deployment and hosting
- [Sanity](https://sanity.io) - Headless CMS
- [Lighthouse](https://developers.google.com/web/tools/lighthouse) - Performance testing
- [Jest](https://jestjs.io) - Testing framework
- [ESLint](https://eslint.org) - Code linting

### **Communities**
- [Next.js GitHub Discussions](https://github.com/vercel/next.js/discussions)
- [React Community](https://reactjs.org/community/support.html)
- [Sanity Community](https://www.sanity.io/community)

---

## 🏁 **Conclusion**

This comprehensive guide provides a roadmap for building professional, modern websites from conception to production. The key principles are:

1. **Start with solid foundations** - Project planning and setup
2. **Build incrementally** - Add features progressively
3. **Maintain quality standards** - Linting, testing, and documentation
4. **Optimize for performance** - Images, loading, and SEO
5. **Plan for maintenance** - Monitoring, updates, and scaling

Remember: **Perfect is the enemy of good.** Start with the MVP, iterate based on feedback, and continuously improve your development process.

---

**Happy building! 🚀**

> **Next Steps:** Choose your next project and follow this guide step by step. Each phase builds upon the previous one, ensuring you create a robust, maintainable, and professional website.
