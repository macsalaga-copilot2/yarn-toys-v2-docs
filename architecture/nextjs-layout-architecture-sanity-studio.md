# Next.js Layout Architecture for Sanity Studio Integration

## Overview
This document explains how we solved the layout conflict issue when integrating Sanity Studio into a Next.js application. The problem was that the main site's navigation and footer were appearing in the Sanity Studio interface, making it unusable.

## Problem Description
- **Initial Issue**: Sanity Studio at `/studio` was showing the main site's navigation bar and footer
- **Impact**: Navigation bar was covering the Studio interface, making it impossible to use properly
- **Root Cause**: All routes were inheriting the same layout with MainNav and Footer components

## Solution: Conditional Rendering with Path Detection

### Final Working Architecture
We implemented a single root layout with conditional rendering based on the current pathname:

```
src/app/
├── layout.tsx           # Root layout with conditional nav/footer
├── (site)/             # Route group for main website pages
│   ├── page.tsx        # Homepage
│   ├── my-toys/        # Products pages
│   ├── about/          # About page
│   ├── contact/        # Contact page
│   └── ...             # Other site pages
└── studio/             # Sanity Studio
    ├── layout.tsx      # Clean studio layout
    └── [[...tool]]/    # Studio routes
```

### Root Layout Implementation (`/src/app/layout.tsx`)
**Purpose**: Single layout that conditionally shows navigation and footer

```tsx
"use client";
import React from "react";
import { nunitoSans, nanumPenScript } from "./fonts";
import "./globals.css";
import MainNav from "@/components/layout/MainNav";
import Footer from "@/components/layout/Footer";
import { usePathname } from "next/navigation";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const pathname = usePathname();
  const isStudio = pathname?.startsWith('/studio');

  return (
    <html lang="en">
      <head>
        <title>Yarn Toys - Handmade Crochet Toys with Love</title>
        <meta name="description" content="Handmade crochet toys created with love as a hobby. Each soft, cuddly toy is personally crafted using baby-safe materials. Made in Sweden." />
      </head>
      <body
        className={`${nunitoSans.variable} ${nanumPenScript.variable} antialiased`}
      >
        {!isStudio && <MainNav className="bg-transparent fixed left-0 top-0 w-full z-50" />}
        {children}
        {!isStudio && <Footer />}
      </body>
    </html>
  );
}
```

**Key Points**:
- Uses `"use client"` directive for client-side pathname detection
- Detects Studio routes with `pathname?.startsWith('/studio')`
- Conditionally renders MainNav and Footer only for non-studio pages
- Includes manual meta tags since client components can't export metadata
- Single source of truth for all layout logic

### Studio Layout (`/src/app/studio/layout.tsx`)
**Purpose**: Provides clean layout for Sanity Studio

```tsx
"use client";

import { ReactNode } from "react";

interface StudioLayoutProps {
  children: ReactNode;
}

export default function StudioLayout({ children }: StudioLayoutProps) {
  return <>{children}</>;
}
```

**Key Points**:
- Minimal layout that only returns children
- Uses "use client" directive for client-side rendering
- No navigation or footer interference
- Completely isolated from main site styling

## Implementation Steps

### Step 1: Create Route Group Structure
```bash
# Create (site) route group for organization
mkdir src/app/\(site\)

# Move all main site pages to (site) group for organization
mv src/app/page.tsx src/app/\(site\)/page.tsx
mv src/app/my-toys src/app/\(site\)/my-toys
mv src/app/about src/app/\(site\)/about
mv src/app/contact src/app/\(site\)/contact
mv src/app/faq src/app/\(site\)/faq
# ... move all other site pages
```

### Step 2: Implement Conditional Layout
Create single root layout with path-based conditional rendering:
- Add `"use client"` directive for pathname access
- Import `usePathname` from `next/navigation`
- Detect studio routes with `pathname?.startsWith('/studio')`
- Conditionally render nav/footer with `{!isStudio && <MainNav />}`

### Step 3: Create Studio Layout
Create `studio/layout.tsx` with:
- Client directive
- Minimal fragment wrapper
- No additional components

### Step 4: Test Both Environments
Verify:
- Main site shows navigation and footer
- Studio has clean interface
- No layout conflicts or component interference

## Conditional Rendering Benefits

### Why This Approach Works
1. **Single Source of Truth**: One layout file handles all logic
2. **Dynamic Detection**: Automatically detects studio vs. site routes
3. **Clean Separation**: Studio gets no nav/footer, site gets full experience
4. **URL Structure Unchanged**: All routes work as expected
5. **Simple Maintenance**: Easy to modify layout logic in one place

### Path Detection Logic
```tsx
const pathname = usePathname();
const isStudio = pathname?.startsWith('/studio');

// Conditional rendering
{!isStudio && <MainNav />}
{children}
{!isStudio && <Footer />}
```

### Complete Isolation
- Studio has no access to MainNav/Footer when `isStudio` is true
- Site pages get full navigation experience when `isStudio` is false
- No CSS conflicts or component interference
- Clean, predictable behavior

## Troubleshooting Common Issues

### Issue 1: "The default export is not a React Component in '/layout'"
**Problem**: Layout file has syntax errors or missing React imports
**Solution**: 
- Ensure React is imported: `import React from "react";`
- Add `"use client"` directive when using hooks like `usePathname`
- Verify proper default export syntax
- Clear Next.js cache: `rm -rf .next` and restart dev server

### Issue 2: Navigation Still Appears in Studio
**Problem**: Conditional rendering logic not working
**Solution**: 
- Verify `usePathname()` import from `next/navigation`
- Check conditional logic: `{!isStudio && <MainNav />}`
- Ensure pathname detection: `pathname?.startsWith('/studio')`
- Add console.log to debug pathname values

### Issue 3: Hydration Mismatches
**Problem**: Server/client rendering differences
**Solution**: 
- Use `"use client"` directive for pathname-dependent layouts
- Ensure consistent structure between server and client
- Avoid conditional HTML structure changes

### Issue 4: Metadata Not Working with Client Components
**Problem**: Client components can't export metadata
**Solution**: 
- Move metadata to manual `<head>` tags in client components
- Or use a separate metadata API approach
- Consider server components for static metadata

## Best Practices

### 1. Layout Architecture
- **Root Layout**: Single source of truth with conditional logic
- **Studio Layout**: Minimal, clean wrapper
- **Page Components**: Content only, no layout concerns

### 2. Path Detection
```tsx
// Robust pathname detection
const pathname = usePathname();
const isStudio = pathname?.startsWith('/studio');

// Safe conditional rendering
{!isStudio && <MainNav />}
```

### 3. Component Organization
```
src/
├── components/
│   ├── layout/          # Layout components
│   │   ├── MainNav.tsx
│   │   └── Footer.tsx
│   └── ui/              # UI components
└── app/
    ├── layout.tsx       # Conditional root layout
    ├── (site)/          # Main site pages
    └── studio/          # Clean studio
        └── layout.tsx   # Studio layout
```

### 4. Debugging Tips
- Add console.log to track pathname values
- Use React DevTools to inspect component tree
- Test both routes after layout changes
- Clear browser cache for persistent issues

## Testing Checklist

### ✅ Layout Verification
- [ ] Main site shows navigation and footer
- [ ] Studio has no navigation or footer
- [ ] All URLs work as expected
- [ ] No hydration errors in console

### ✅ Functionality Testing
- [ ] Studio is fully functional
- [ ] Can create/edit documents in Studio
- [ ] Site navigation works properly
- [ ] Footer links are clickable

### ✅ Responsive Testing
- [ ] Mobile navigation works on site
- [ ] Studio is responsive
- [ ] No layout conflicts on different screen sizes

## Future Considerations

### Adding New Sections
To add a new isolated section (e.g., admin panel):
1. Create new route group: `(admin)`
2. Add specific layout for that section
3. Move relevant pages to the group

### Styling Isolation
- Use CSS modules for component-specific styles
- Keep global styles minimal in root layout
- Consider CSS-in-JS for complete isolation

### Performance Optimization
- Route groups enable code splitting by section
- Consider lazy loading for large sections
- Monitor bundle sizes per route group

## Related Documentation
- [Next.js App Router Documentation](https://nextjs.org/docs/app)
- [Sanity Studio Setup Summary](./sanity-setup-summary.md)
- [Project Summary](./project-summary.md)

---

**Created**: August 3, 2025  
**Last Updated**: August 3, 2025  
**Status**: Production Ready ✅
