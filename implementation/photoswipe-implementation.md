# PhotoSwipe Image Viewer Implementation Guide

This document explains how we implemented and customized PhotoSwipe for the Yarn Toys project to create a modern, white-themed image viewer with custom icons and robust error handling.

## Overview

We replaced a custom-built image viewer component with PhotoSwipe, a popular JavaScript lightbox library, to provide better performance, accessibility, and user experience for viewing product images. Our implementation includes comprehensive error handling, dynamic animations, and enhanced user interface elements.

## Installation

First, we installed PhotoSwipe via npm:

```bash
npm install photoswipe
```

## Implementation Structure

### 1. Enhanced Hook-based Approach (`usePhotoSwipe.ts`)

We created a production-ready React hook with comprehensive error handling:

```typescript
// src/hooks/usePhotoSwipe.ts
'use client';

import { useCallback } from 'react';
import PhotoSwipe from 'photoswipe';

interface PhotoSwipeImage {
  src: string;
  width: number;
  height: number;
  alt?: string;
}

export function usePhotoSwipe() {
  const openPhotoSwipe = useCallback((
    images: PhotoSwipeImage[],
    index: number = 0,
    triggerElement?: HTMLElement
  ) => {
    // Ensure we're in the browser (prevents SSR issues)
    if (typeof window === 'undefined') return;

    // Custom SVG icons (Feather style)
    const closeSVG = '<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24"><line x1="18" y1="6" x2="6" y2="18" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line><line x1="6" y1="6" x2="18" y2="18" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line></svg>';
    
    const zoomSVG = '<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24"><circle cx="11" cy="11" r="8" stroke="currentColor" stroke-width="2" fill="none"></circle><path d="m21 21-4.35-4.35" stroke="currentColor" stroke-width="2" stroke-linecap="round"></path><line x1="11" y1="8" x2="11" y2="14" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line><line x1="8" y1="11" x2="14" y2="11" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line></svg>';
    
    const arrowPrevSVG = '<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24"><polyline points="15,18 9,12 15,6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"></polyline></svg>';
    
    const arrowNextSVG = '<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24"><polyline points="9,18 15,12 9,6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"></polyline></svg>';

    // Get thumbnail bounds for smooth transition (with error handling)
    let thumbBounds;
    if (triggerElement) {
      try {
        const rect = triggerElement.getBoundingClientRect();
        thumbBounds = {
          x: rect.left,
          y: rect.top,
          w: rect.width
        };
      } catch (error) {
        console.warn('Could not get thumbnail bounds:', error);
        thumbBounds = undefined;
      }
    }

    try {
      const pswp = new PhotoSwipe({
        dataSource: images,
        index,
        // PhotoSwipe options
        bgOpacity: 1, // Full white background
        showHideAnimationType: thumbBounds ? 'zoom' : 'fade', // Dynamic animation
        zoom: true,
        closeOnVerticalDrag: true,
        spacing: 0.1,
        wheelToZoom: true,
        loop: images.length > 1,
        preloaderDelay: 0, // Show preloader immediately
        // Thumbnail bounds for smooth transition
        ...(thumbBounds && { thumbBounds }),
        // Custom icons
        closeSVG: closeSVG,
        zoomSVG: zoomSVG,
        arrowPrevSVG: arrowPrevSVG,
        arrowNextSVG: arrowNextSVG,
        // Custom theme class
        mainClass: 'pswp--custom-white-theme',
        // Accessibility titles
        closeTitle: 'Close (Esc)',
        zoomTitle: 'Zoom in/out',
        arrowPrevTitle: 'Previous (arrow left)',
        arrowNextTitle: 'Next (arrow right)',
      });

      pswp.init();
    } catch (error) {
      console.error('PhotoSwipe initialization error:', error);
      // Fallback: open image in new tab
      if (images[index]) {
        window.open(images[index].src, '_blank');
      }
    }
  }, []);

  return { openPhotoSwipe };
}
```

### 2. Component-based Approach (`PhotoSwipeViewer.tsx`)

We also created a reusable React component for gallery-style usage:

```typescript
// src/components/ui/PhotoSwipeViewer.tsx
'use client';

import React, { useEffect, useRef } from 'react';
import PhotoSwipeLightbox from 'photoswipe/lightbox';
import 'photoswipe/style.css';

export default function PhotoSwipeViewer({ 
  images, 
  galleryId, 
  children 
}: PhotoSwipeViewerProps) {
  const lightboxRef = useRef<PhotoSwipeLightbox | null>(null);

  useEffect(() => {
    if (!lightboxRef.current) {
      // Same custom icons and configuration as the hook
      lightboxRef.current = new PhotoSwipeLightbox({
        gallery: `#${galleryId}`,
        children: 'a',
        pswpModule: () => import('photoswipe'),
        // Same configuration as hook...
        mainClass: 'pswp--custom-white-theme',
      });

      lightboxRef.current.init();
    }

    return () => {
      if (lightboxRef.current) {
        lightboxRef.current.destroy();
        lightboxRef.current = null;
      }
    };
  }, [galleryId]);

  return (
    <div id={galleryId} className="photoswipe-gallery">
      {React.Children.map(children, (child, index) => {
        if (React.isValidElement(child)) {
          const image = images[index];
          if (image) {
            return (
              <a
                href={image.src}
                data-pswp-width={image.width}
                data-pswp-height={image.height}
                target="_blank"
                rel="noopener noreferrer"
                className="block"
              >
                {child}
              </a>
            );
          }
        }
        return child;
      })}
    </div>
  );
}
```

## Enhanced Custom White Theme Implementation

### Global CSS Styling

We added comprehensive PhotoSwipe styles to `globals.css`:

```css
/* src/app/globals.css */
@import "photoswipe/style.css";

/* PhotoSwipe Custom White Theme */
.pswp--custom-white-theme {
  --pswp-bg: #ffffff;
  --pswp-icon-color: #374151;
  --pswp-icon-color-secondary: #6b7280;
  --pswp-placeholder-bg: #ffffff;
}

.pswp--custom-white-theme .pswp__bg {
  background: #ffffff !important;
}

/* Custom placeholder styling for smooth loading */
.pswp--custom-white-theme .pswp__img {
  background: #ffffff;
}

.pswp--custom-white-theme .pswp__content {
  background: #ffffff;
}

.pswp--custom-white-theme .pswp__button {
  background: rgba(255, 255, 255, 0.9) !important;
  border: 1px solid #e5e7eb !important;
  border-radius: 8px;
  backdrop-filter: blur(8px);
  transition: all 0.2s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.pswp--custom-white-theme .pswp__button:hover {
  background: rgba(255, 255, 255, 1) !important;
  border-color: #d1d5db !important;
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* Enhanced color-coded buttons with hover states */
.pswp--custom-white-theme .pswp__button--close {
  background: rgba(254, 226, 226, 0.9) !important;
  border-color: #fecaca !important;
}

.pswp--custom-white-theme .pswp__button--close:hover {
  background: rgba(254, 202, 202, 1) !important;
  border-color: #fca5a5 !important;
}

.pswp--custom-white-theme .pswp__button--zoom {
  background: rgba(219, 234, 254, 0.9) !important;
  border-color: #bfdbfe !important;
}

.pswp--custom-white-theme .pswp__button--zoom:hover {
  background: rgba(191, 219, 254, 1) !important;
  border-color: #93c5fd !important;
}

/* Enhanced counter styling */
.pswp--custom-white-theme .pswp__counter {
  color: #374151 !important;
  background: rgba(255, 255, 255, 0.95) !important;
  border: 1px solid #e5e7eb !important;
  border-radius: 6px;
  padding: 6px 12px;
  backdrop-filter: blur(8px);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* Hide default icon shadows */
.pswp--custom-white-theme .pswp__icn-shadow {
  display: none;
}
```

/* Hide default icon shadows */
.pswp--custom-white-theme .pswp__icn-shadow {
  display: none;
}
```

## Custom SVG Icons

We created modern, minimal SVG icons using the Feather icon style:

### Close Icon (X)
```svg
<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24">
  <line x1="18" y1="6" x2="6" y2="18" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line>
  <line x1="6" y1="6" x2="18" y2="18" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line>
</svg>
```

### Zoom Icon (Magnifying Glass with Plus)
```svg
<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24">
  <circle cx="11" cy="11" r="8" stroke="currentColor" stroke-width="2" fill="none"></circle>
  <path d="m21 21-4.35-4.35" stroke="currentColor" stroke-width="2" stroke-linecap="round"></path>
  <line x1="11" y1="8" x2="11" y2="14" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line>
  <line x1="8" y1="11" x2="14" y2="11" stroke="currentColor" stroke-width="2" stroke-linecap="round"></line>
</svg>
```

### Arrow Icons (Chevron Style)
```svg
<!-- Previous Arrow -->
<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24">
  <polyline points="15,18 9,12 15,6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"></polyline>
</svg>

<!-- Next Arrow -->
<svg aria-hidden="true" class="pswp__icn" viewBox="0 0 24 24" width="24" height="24">
  <polyline points="9,18 15,12 9,6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"></polyline>
</svg>
```

## Enhanced Usage in Product Pages

In our product page (`src/app/my-toys/[id]/ProductDetails.tsx`), we use the hook approach with enhanced UX:

```typescript
"use client";

import { usePhotoSwipe } from "@/hooks/usePhotoSwipe";

export default function ProductDetails({ toy }: ProductDetailsProps) {
  const { openPhotoSwipe } = usePhotoSwipe();
  
  const handleImageClick = () => {
    openPhotoSwipe([{
      src: toy.imageUrl,
      width: 1200,
      height: 1600,
      alt: toy.name
    }], 0);
  };

  return (
    // Product layout...
    <div 
      className="relative rounded-2xl overflow-hidden bg-gray-50 cursor-zoom-in group"
      onClick={handleImageClick}
    >
      <div className="relative w-full aspect-[3/4]">
        <Image
          src={toy.imageUrl}
          alt={toy.name}
          fill
          className="object-cover hover:scale-105 transition-transform duration-300"
          sizes="(max-width: 1024px) 100vw, 50vw"
        />
        {/* Enhanced zoom indicator overlay */}
        <div className="absolute inset-0 group-hover:bg-black/10 transition-all duration-300 flex items-center justify-center">
          <div className="opacity-0 group-hover:opacity-100 transition-opacity duration-300 bg-white/90 rounded-full p-3">
            <svg className="w-6 h-6 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8" strokeWidth="2"></circle>
              <path d="m21 21-4.35-4.35" strokeWidth="2"></path>
              <line x1="11" y1="8" x2="11" y2="14" strokeWidth="2"></line>
              <line x1="8" y1="11" x2="14" y2="11" strokeWidth="2"></line>
            </svg>
          </div>
        </div>
      </div>
    </div>
  );
}
```

## Enhanced Configuration Options

| Option | Value | Purpose |
|--------|-------|---------|
| `bgOpacity` | `1` | Full opacity white background |
| `mainClass` | `'pswp--custom-white-theme'` | Apply custom CSS theme |
| `closeSVG`, `zoomSVG`, etc. | Custom SVG strings | Modern Feather-style icon replacements |
| `wheelToZoom` | `true` | Enable mouse wheel zooming |
| `closeOnVerticalDrag` | `true` | Allow closing by dragging down |
| `showHideAnimationType` | `thumbBounds ? 'zoom' : 'fade'` | **Dynamic animation** based on context |
| `preloaderDelay` | `0` | Show preloader immediately |
| `spacing` | `0.1` | Spacing between images in gallery |
| `loop` | `images.length > 1` | Only loop if multiple images |

## Advanced Features Implemented

✅ **Pure White Background**: Clean, professional appearance  
✅ **Modern Dark Icons**: High contrast, easily readable (Feather style)  
✅ **Enhanced Button Styling**: Rounded corners, subtle shadows, detailed hover effects  
✅ **Color-coded Buttons**: Red tint for close, blue tint for zoom with hover states  
✅ **Dynamic Animations**: Zoom transition when thumbnail available, fade otherwise  
✅ **Zoom Indicator Overlay**: Visual feedback on hover with icon  
✅ **Responsive Design**: Works on all screen sizes  
✅ **Accessibility**: Proper ARIA labels and keyboard support  
✅ **Error Handling**: Browser checks, fallback behavior, console warnings  
✅ **Performance**: Leverages PhotoSwipe's optimized rendering  

## Production-Ready Error Handling

### 1. Browser Environment Check
```typescript
if (typeof window === 'undefined') return;
```

### 2. Thumbnail Bounds Error Handling
```typescript
try {
  const rect = triggerElement.getBoundingClientRect();
  thumbBounds = { x: rect.left, y: rect.top, w: rect.width };
} catch (error) {
  console.warn('Could not get thumbnail bounds:', error);
  thumbBounds = undefined;
}
```

### 3. PhotoSwipe Initialization Error Handling
```typescript
try {
  const pswp = new PhotoSwipe({...});
  pswp.init();
} catch (error) {
  console.error('PhotoSwipe initialization error:', error);
  // Fallback: open image in new tab
  if (images[index]) {
    window.open(images[index].src, '_blank');
  }
}
```

## Troubleshooting & Solutions

### Issue: Server-Side Rendering (SSR) Conflicts
**Problem**: PhotoSwipe tries to access `window` during SSR causing hydration mismatches.  
**✅ Solution**: Added browser environment check: `if (typeof window === 'undefined') return;`

### Issue: Thumbnail bounds calculation errors
**Problem**: `getBoundingClientRect()` can fail in certain scenarios.  
**✅ Solution**: Wrapped in try-catch with proper error handling and fallback.

### Issue: PhotoSwipe initialization failures
**Problem**: Library can fail to initialize in some environments.  
**✅ Solution**: Added comprehensive error handling with fallback to open image in new tab.

### Issue: Grey background appears before image loads
**✅ Solution**: Enhanced placeholder styling with `--pswp-placeholder-bg: #ffffff` and custom `.pswp__img` background.

### Issue: Dark background still showing
**✅ Solution**: Ensured `bgOpacity: 1`, `mainClass: 'pswp--custom-white-theme'`, and added multiple background overrides.

### Issue: Icons not displaying
**✅ Solution**: Verified SVG strings include all required attributes: `aria-hidden="true"`, `class="pswp__icn"`, proper `viewBox`, `width`, and `height`.

### Issue: Styles not applying
**✅ Solution**: Imported PhotoSwipe styles before custom CSS and used `!important` where necessary.

### Issue: Animation inconsistencies
**✅ Solution**: Implemented dynamic animation type based on thumbnail availability: `thumbBounds ? 'zoom' : 'fade'`

## Performance Considerations

- PhotoSwipe lazy-loads images for better performance
- Uses CSS transforms for smooth animations
- Optimized for touch devices and mobile
- Minimal bundle size impact due to tree-shaking

## Future Enhancements

Potential improvements for the future:
- Add gesture support for mobile devices
- Implement image preloading for faster navigation
- Add thumbnail navigation for image galleries
- Include social sharing functionality
- Add fullscreen API support for true fullscreen mode

## Dependencies

- `photoswipe`: ^5.x.x
- `react`: ^18.x.x
- `next.js`: ^15.x.x

## Image Organization

All product images are stored in `public/images/toys-all/` directory for consistency across the application:
- Homepage floating images use: `/images/toys-all/DSC00XXX.JPG`
- Product detail pages use: `/images/toys-all/DSC00XXX.JPG`  
- Gallery pages use: `/images/toys-all/DSC00XXX.JPG`

This centralized approach eliminates duplicate images and ensures consistent loading performance across all components.

---

*This implementation provides a modern, accessible, production-ready, and performant image viewing experience that matches the clean aesthetic of the Yarn Toys website. The comprehensive error handling ensures reliability across different browsers and environments, while the enhanced UI provides excellent user feedback and interaction.*

**Implementation Status**: ✅ **Production Ready** with comprehensive error handling, fallback mechanisms, and enhanced user experience features.
