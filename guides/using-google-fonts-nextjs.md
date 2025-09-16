# Using Google Fonts in Next.js 13+ with Font Optimization

This guide explains the recommended way to use Google Fonts in modern Next.js projects (13+), leveraging the built-in font optimization API for best performance, reliability, and maintainability.

## Why Use Next.js Font Optimization?
- **Performance:** Fonts are self-hosted and served with optimal caching and preloading.
- **No FOUT/FOIT:** Next.js handles font loading to minimize flashes of unstyled text.
- **Consistent API:** Fonts are imported and applied using variables/classes, not global CSS or `<link>` tags.
- **Tree-shaking:** Only the font weights and subsets you use are included in the build.

## Step-by-Step Setup

### 1. Create a `fonts.ts` File
In your app directory (e.g. `src/app/fonts.ts`), import and configure your Google Fonts:

```ts
import { Nunito_Sans, Nanum_Pen_Script } from "next/font/google";

export const nunitoSans = Nunito_Sans({
  weight: ["400", "700"],
  subsets: ["latin"],
  variable: "--font-nunito-sans",
  display: "swap",
});

export const nanumPenScript = Nanum_Pen_Script({
  weight: "400",
  subsets: ["latin"],
  variable: "--font-nanum-pen-script",
  display: "swap",
});
```

- The `variable` option lets you use the font as a CSS variable (recommended for Tailwind and global styles).
- The `className` property can be used to apply the font to specific elements.

### 2. Apply Fonts Globally in `layout.tsx`
Import your font objects and add their variables to the `<body>` className:

```tsx
import { nunitoSans, nanumPenScript } from "./fonts";

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={`${nunitoSans.variable} ${nanumPenScript.variable} antialiased`}>
        {children}
      </body>
    </html>
  );
}
```

### 3. Set the Default Font in `globals.css`
Use the CSS variable for your default font:

```css
body {
  font-family: var(--font-nunito-sans), system-ui, sans-serif;
}
```

### 4. Use Fonts on Specific Components
For headers or special text, use the `className` property:

```tsx
import { nanumPenScript } from "@/app/fonts";

<h2 className={nanumPenScript.className}>Section Title</h2>
```

Or combine with Tailwind classes:

```tsx
<h2 className={`text-3xl font-bold ${nanumPenScript.className}`}>Section Title</h2>
```

## What to Avoid
- **Do not** use `<link rel="stylesheet" ... />` for Google Fonts in your HTML or components.
- **Do not** use `@import` for Google Fonts in your CSS.
- **Do not** use global font-family overrides for Google Fonts in CSS.

## Benefits
- Fonts are loaded only once, with optimal caching.
- No layout shift or flash of unstyled text.
- Easy to change or add fonts in one place (`fonts.ts`).
- Works perfectly with Tailwind and CSS variables.

---

**Reference:** [Next.js Font Optimization Docs](https://nextjs.org/docs/app/building-your-application/optimizing/fonts)
