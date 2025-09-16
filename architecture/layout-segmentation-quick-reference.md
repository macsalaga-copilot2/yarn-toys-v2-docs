# Layout Segmentation Quick Reference

## Problem Solved
✅ **Sanity Studio navbar interference** - Main site's navigation was covering Studio interface

## Solution: Conditional Rendering with Path Detection

### File Structure
```
src/app/
├── layout.tsx              # Root: conditional nav/footer based on path
├── (site)/                 # Route group for main website pages
│   ├── page.tsx            # Homepage
│   ├── my-toys/            # All site pages moved here
│   ├── about/
│   ├── contact/
│   └── ...
└── studio/
    ├── layout.tsx          # Studio: clean, no nav/footer
    └── [[...tool]]/
```

### Key Implementation

**Root Layout** (`/app/layout.tsx`)
```tsx
"use client";
import React from "react";
import { usePathname } from "next/navigation";
import MainNav from "@/components/layout/MainNav";
import Footer from "@/components/layout/Footer";

export default function RootLayout({ children }) {
  const pathname = usePathname();
  const isStudio = pathname?.startsWith('/studio');

  return (
    <html lang="en">
      <head>
        <title>Yarn Toys - Handmade Crochet Toys with Love</title>
        <meta name="description" content="..." />
      </head>
      <body className={fonts}>
        {!isStudio && <MainNav />}
        {children}
        {!isStudio && <Footer />}
      </body>
    </html>
  );
}
```

**Studio Layout** (`/app/studio/layout.tsx`)
```tsx
"use client";
import { ReactNode } from "react";

export default function StudioLayout({ children }: { children: ReactNode }) {
  return <>{children}</>;
}
```

## Commands Used
```bash
# Move all site pages to (site) route group for organization
mv src/app/page.tsx src/app/\(site\)/page.tsx
mv src/app/my-toys src/app/\(site\)/my-toys
mv src/app/about src/app/\(site\)/about
# ... etc for all pages

# Clear Next.js cache when encountering layout errors
rm -rf .next
```

## Key Features
- ✅ **Path Detection**: `pathname?.startsWith('/studio')` identifies studio routes
- ✅ **Conditional Rendering**: `{!isStudio && <MainNav />}` shows nav only for site
- ✅ **Single Source**: One layout file handles all logic
- ✅ **Client-Side**: Uses `"use client"` for pathname access

## Result
- ✅ Studio: Clean interface, no navbar interference
- ✅ Main site: Full navigation and footer
- ✅ URLs unchanged: `/my-toys`, `/studio` work as before
- ✅ Single layout: All logic in one conditional file
- ✅ Automatic detection: No manual route configuration needed

## When to Use This Pattern
- Embedding third-party admin interfaces (Sanity, Strapi, etc.)
- Creating different layout sections (public/admin/dashboard)
- Need path-based conditional rendering
- Want single source of truth for layout logic
- Any time you need layout segmentation without URL changes

## Troubleshooting
**Error: "The default export is not a React Component in '/layout'"**
- Add `import React from "react";`
- Add `"use client";` directive
- Clear cache: `rm -rf .next`
- Restart dev server

**Navigation still shows in Studio:**
- Check pathname detection logic
- Verify `!isStudio` condition
- Add console.log to debug pathname

---
**Quick Fix for Similar Issues**: Use conditional rendering with pathname detection in single root layout.
