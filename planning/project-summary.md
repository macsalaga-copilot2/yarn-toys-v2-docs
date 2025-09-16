# Yarn Toys Project Summary & Reference Guide

**Project:** Handmade Crochet Toys E-commerce Website  
**Timeline:** 2024-2025  
## 🚀 Current Development Status & Next Steps

### **Phase 2.5: Pre-Production Polish (v1.5)**
- ✅ **Breadcrumbs Navigation** - Complete navigation system implemented
- 🔄 **Loading States** - Professional loading UX in progress  
- 🔄 **Mobile Optimization** - Touch targets and responsive refinements
- 🔄 **Accessibility** - ARIA labels, keyboard navigation, WCAG compliance

### **Immediate Next Steps**
For detailed step-by-step implementation plan with time estimates and success criteria:
**📋 See `docs/development-action-plan.md`**

**Timeline to Production**: 2-3 weeks (v1.5 → v1.6 → v2.0)
- **v1.5 completion**: 3-4 days (UX polish)
- **v1.6-production-ready**: 5-7 days (SEO, security, error pages)
- **v2.0-deployment**: 3-5 days (Vercel deployment, monitoring, QA)  
**Repository:** yarn-toys (multiple branches for development phases)  
**Current Version:** v1.5-ux-enhancements  
**Stable Version:** v1.4-complete-catalog-90-products

## 🎯 Project Overview

A modern, responsive e-commerce website for handmade crochet toys created as a hobby business. The site features a clean aesthetic, professional product photography showcase, and seamless user experience focused on Swedish market (Swish payments, PostNord shipping).

**Latest Achievement:** Complete production system with all 90 handcrafted toys imported, comprehensive UI polish, and enhanced navigation system with breadcrumbs.

### **Key Features Delivered:**
- ✅ Modern responsive design with mobile-first approach
- ✅ **Complete Product Catalog** - All 90 handcrafted toys online (upgraded from 76)
- ✅ **Professional Image Quality** - Sony a6300 studio photography preserved through Sanity CDN
- ✅ **Individual Product Pages** - SEO-friendly URLs for each toy with breadcrumb navigation
- ✅ Professional image viewer with PhotoSwipe integration
- ✅ **Systematic Batch Import** - 5-batch processing methodology (20+20+20+20+10)
- ✅ Multi-language support (English/Polish elements)
- ✅ Mobile navigation with hamburger menu
- ✅ **Sanity CMS Integration** - Professional content management with 270 images
- ✅ **Enhanced Navigation** - Breadcrumb system for improved UX
- ✅ Contact and ordering system
- ✅ SEO-optimized structure
- ✅ Accessibility features
- ✅ Advanced TypeScript system with type safety
- ✅ Error boundaries with recovery mechanisms
- ✅ Multi-environment configuration system
- ✅ Comprehensive testing infrastructure (67 tests)
- ✅ **UI Polish** - Hero section fixes, navigation clarity improvements

## 🛠️ Technology Stack

### **Core Framework:**
- **Next.js 15+** - React framework with App Router
- **TypeScript** - Advanced type system with custom utilities
- **Tailwind CSS** - Utility-first CSS framework
- **React 18+** - Component library with advanced hooks

### **Development & Quality:**
- **ESLint + Prettier** - Code quality and formatting
- **Jest + Testing Library** - Comprehensive testing (67 tests)
- **Advanced TypeScript Types** - Utility types, branded types, type guards
- **Environment Management** - Multi-environment configuration
- **Error Boundaries** - Production-ready error handling

### **UI Components:**
- **shadcn/ui** - High-quality, accessible component library
- **Radix UI** - Headless UI primitives (underlying shadcn/ui)
- **Lucide React** - Modern icon library

### **Specialized Libraries:**
- **PhotoSwipe v5** - Professional image lightbox/viewer
- **Next.js Image** - Optimized image loading and performance

### **Development Tools:**
- **ESLint** - Code linting and formatting
- **PostCSS** - CSS processing
- **Git** - Version control

## 📁 Project Structure

```
yarn-toys-v2/
├── src/
│   ├── app/                    # Next.js App Router pages
│   │   ├── layout.tsx         # Root layout with navigation
│   │   ├── page.tsx           # Homepage
│   │   ├── globals.css        # Global styles & PhotoSwipe theme
│   │   ├── about/             # About page
│   │   ├── my-toys/           # Product gallery
│   │   │   ├── page.tsx       # All toys grid view
│   │   │   └── [id]/          # Dynamic product pages
│   │   │       ├── page.tsx   # Main product page (ACTIVE)
│   │   │       └── ProductDetails.tsx # Product component
│   │   └── informacja-prawna/ # Legal information
│   ├── components/            # Reusable components
│   │   ├── ui/                # shadcn/ui components
│   │   ├── layout/            # Navigation, footer
│   │   ├── hero/              # Hero sections
│   │   ├── sections/          # Page sections
│   │   └── product/           # Product-related components
│   ├── hooks/                 # Custom React hooks
│   │   └── usePhotoSwipe.ts   # PhotoSwipe integration
│   ├── lib/                   # Utilities
│   │   └── utils.ts           # Helper functions
│   └── types/                 # TypeScript definitions
├── public/                    # Static assets
│   ├── images/
│   │   └── toys-all/          # Product photography
│   └── ...
├── docs/                      # Project documentation
└── package.json              # Dependencies and scripts
```

## 🎨 Design System & Styling

### **Design Philosophy:**
- **Clean & Minimal** - White backgrounds, lots of breathing room
- **Warm & Friendly** - Soft colors, rounded corners, friendly typography
- **Professional** - High-quality imagery, consistent spacing
- **Mobile-First** - Responsive design prioritizing mobile experience

### **Color Palette:**
```css
/* Primary Brand Colors */
--pink-gradient: linear-gradient(135deg, #fa83c9 0%, #0996cf 100%)
--blue-primary: #0996cf
--pink-primary: #fa83c9

/* UI Colors */
--white: #ffffff
--gray-50: #f9fafb
--gray-100: #f3f4f6
--gray-700: #374151
--gray-900: #111827

/* Status Colors */
--green-100: #dcfce7 (available)
--green-700: #15803d
--red-100: #fee2e2 (sold out)
--red-700: #b91c1c
```

### **Typography:**
- **Primary Font:** Nunito Sans (clean, friendly, readable)
- **Accent Font:** Nanum Pen Script (handwritten feel for special elements)

### **Animation System:**
```css
/* Hero floating animations */
.animate-float-1 through .animate-float-4
.animate-float-slow / .animate-float-fast

/* Hover effects */
- Scale transforms (1.02, 1.05)
- Smooth transitions (300ms duration)
- Shadow depth changes
```

## 🧭 Navigation & User Experience

### **Navigation Structure:**
```
/ (Homepage)
├── /about (About the creator)
├── /my-toys (Product gallery)
│   └── /my-toys/[id] (Individual products)
├── /informacja-prawna (Legal info)
├── #contact (Contact section)
└── #faq (FAQ section)
```

### **Navigation Components:**
1. **MainNav.tsx** - Desktop navigation with logo centering
2. **MobileMenu** - Slide-out hamburger menu (Sheet component)
3. **Footer.tsx** - Site links and branding

### **UX Features:**
- **Scroll behavior** - Auto-hide/show navigation on scroll
- **Visual feedback** - Hover states, loading indicators
- **Breadcrumbs** - "Back to All Toys" navigation
- **Product status** - Clear available/sold indicators

## 📸 Image & Media Strategy

### **Image Organization:**
- **Centralized location:** `/public/images/toys-all/`
- **Naming convention:** `DSC00XXX.JPG` (camera format)
- **Optimization:** Next.js Image component with proper sizing
- **Responsive images:** Multiple breakpoint support

### **PhotoSwipe Integration:**
- **Custom white theme** - Professional, clean appearance
- **Custom icons** - Feather-style SVG icons
- **Error handling** - Fallback to new tab if PhotoSwipe fails
- **Dynamic animations** - Zoom or fade based on context
- **Mobile optimized** - Touch gestures, responsive design

### **Image Performance:**
```typescript
// Optimized image loading
<Image
  src={toy.imageUrl}
  alt={toy.name}
  fill
  className="object-cover"
  sizes="(max-width: 1024px) 100vw, 50vw"
  priority // For above-fold images
/>
```

## 🔧 Key Technical Implementations

### **1. Dynamic Routing (Next.js 15+ Compatible)**
```typescript
// Fixed async params issue
interface ProductPageProps {
  params: Promise<{ id: string }>;
}

export default async function ProductPage({ params }: ProductPageProps) {
  const { id } = await params; // Required in Next.js 15+
  // ...
}
```

### **2. PhotoSwipe Hook with Error Handling**
```typescript
// Production-ready implementation with:
- Browser environment checks
- Try-catch error handling
- Fallback behavior
- Dynamic animations
- Custom white theme
```

### **3. Mobile Navigation (Sheet Component)**
```typescript
// shadcn/ui Sheet with custom styling
- Slide-in animation from left
- Gradient background
- Custom close behavior
- Logo integration
```

### **4. Responsive Grid System**
```css
/* Product gallery layout */
.grid {
  grid-template-columns: repeat(2, 1fr); /* Mobile */
  @media (lg) {
    grid-template-columns: repeat(4, 1fr); /* Desktop */
  }
  gap: 4px;
  row-gap: 32px;
}
```

## 🐛 Common Issues & Solutions

### **Next.js 15+ Issues:**
1. **Async Params Problem**
   - **Issue:** `params.id` usage throws errors
   - **Solution:** `const { id } = await params;`

2. **Hydration Mismatches**
   - **Issue:** Server/client HTML differences
   - **Solution:** `"use client"` directive, `typeof window` checks

### **PhotoSwipe Issues:**
1. **SSR Conflicts**
   - **Solution:** Browser environment checks
2. **Black Overlay Bug**
   - **Solution:** Removed problematic CSS `!important` rules
3. **Animation Glitches**
   - **Solution:** Dynamic animation selection

### **CSS Conflicts:**
1. **Tailwind Overrides**
   - **Solution:** Use modern syntax (`bg-black/10` vs `bg-black bg-opacity-10`)
2. **Component Styling**
   - **Solution:** CSS layers and specificity management

## 📦 Dependencies & Package Management

### **Core Dependencies:**
```json
{
  "next": "^15.x.x",
  "react": "^18.x.x",
  "typescript": "^5.x.x",
  "tailwindcss": "^3.x.x",
  "photoswipe": "^5.4.4",
  "@radix-ui/react-dialog": "^1.x.x",
  "lucide-react": "^0.x.x"
}
```

### **Development Dependencies:**
```json
{
  "eslint": "^8.x.x",
  "@types/node": "^20.x.x",
  "@types/react": "^18.x.x",
  "postcss": "^8.x.x",
  "autoprefixer": "^10.x.x"
}
```

## 🚀 Performance Optimizations

### **Image Optimization:**
- Next.js Image component with automatic WebP conversion
- Responsive images with proper `sizes` attribute
- Lazy loading for below-fold content
- Priority loading for hero images

### **Code Splitting:**
- Dynamic imports for PhotoSwipe
- Component-level code splitting
- Optimized bundle sizes

### **SEO Optimizations:**
- Proper meta tags and Open Graph
- Semantic HTML structure
- Alt text for all images
- Clean URL structure

## 📝 Content Strategy

### **Product Information Structure:**
```typescript
interface Toy {
  id: string;
  name: string;
  imageUrl: string;
  description: string; // Brief description
  price: string; // "XXX SEK"
  available: boolean;
  detailedDescription: string; // Full product story
  features: string[]; // Bullet points
  dimensions: string;
  care: string; // Care instructions
}
```

### **Content Guidelines:**
- **Product names:** Simple, descriptive (e.g., "Purple Bear")
- **Descriptions:** Warm, personal tone
- **Features:** Bullet points highlighting materials and benefits
- **Pricing:** Clear SEK pricing for Swedish market

## 🌐 Localization Considerations

### **Language Elements:**
- **Primary:** English (international appeal)
- **Secondary:** Polish elements (`/informacja-prawna`)
- **Market:** Swedish (SEK pricing, Swish payments, PostNord)

### **Cultural Considerations:**
- Swedish payment methods (Swish)
- Nordic design aesthetics
- EU compliance ready

## 📱 Mobile Experience

### **Mobile-First Approach:**
- Touch-friendly interface design
- Hamburger navigation with full-screen menu
- Optimized image sizes for mobile
- Fast loading on mobile networks

### **Mobile Navigation Features:**
- Gradient background menu
- Large touch targets
- Smooth animations
- Easy access to all pages

## 🔒 Security & Best Practices

### **Code Quality:**
- TypeScript for type safety
- ESLint for code consistency
- Component-based architecture
- Error boundaries and fallbacks

### **Performance Security:**
- Image optimization to prevent large file attacks
- Proper error handling to prevent crashes
- Client-side validation

## 📈 Future Enhancement Opportunities

### **Phase 2 Features:**
1. **E-commerce Integration**
   - Shopping cart functionality
   - Payment processing (Stripe/Swish)
   - Order management system

2. **Content Management**
   - Admin panel for product management
   - Inventory tracking
   - Customer communication system

3. **Advanced Features**
   - Product filtering and search
   - Customer reviews
   - Wishlist functionality
   - Social media integration

### **Technical Improvements:**
1. **Database Integration**
   - Move from static data to database
   - Content management system
   - User authentication

2. **Analytics**
   - Google Analytics integration
   - Performance monitoring
   - User behavior tracking

## 🎓 Lessons Learned

### **Technical Lessons:**
1. **Next.js 15+** requires async params handling
2. **PhotoSwipe** needs comprehensive error handling
3. **Tailwind** modern syntax is more reliable
4. **shadcn/ui** provides excellent component foundation

### **Design Lessons:**
1. **Mobile-first** approach saves development time
2. **Consistent spacing** system improves visual coherence
3. **High-quality images** are crucial for product showcase
4. **White space** enhances perceived quality

### **Development Process:**
1. **Iterative development** with multiple file versions works well
2. **Documentation** during development saves time later
3. **Error handling** should be built in from the start
4. **Component reusability** reduces code duplication

## 🔄 Reusable Patterns for Future Projects

### **Component Patterns:**
```typescript
// Reusable product card pattern
<Link href={`/products/${id}`}>
  <div className="group cursor-pointer">
    <Image /> {/* Optimized image */}
    <div className="hover:effects"> {/* Hover animations */}
      <ProductInfo />
    </div>
  </div>
</Link>
```

### **Navigation Patterns:**
```typescript
// Mobile navigation with Sheet
<Sheet>
  <SheetTrigger>HamburgerIcon</SheetTrigger>
  <SheetContent side="left">
    <Navigation />
  </SheetContent>
</Sheet>
```

### **Image Viewer Patterns:**
```typescript
// PhotoSwipe integration
const { openPhotoSwipe } = usePhotoSwipe();
<div onClick={() => openPhotoSwipe(images, index)}>
  <Image /> + <HoverOverlay />
</div>
```

## 📊 Project Metrics

### **Codebase:**
- **Total Files:** ~50+ components and pages
- **Lines of Code:** ~3,000+ lines
- **Components:** ~20+ reusable components
- **Pages:** 5+ main pages

### **Performance Targets:**
- **Mobile Performance:** 90+ Lighthouse score
- **Accessibility:** WCAG 2.1 AA compliance
- **SEO:** Optimized meta tags and structure
- **Load Time:** <3 seconds on mobile

---

**Final Note:** This project demonstrates a complete modern web application built with current best practices, comprehensive error handling, and production-ready features. The codebase serves as an excellent reference for future e-commerce or product showcase websites.

**Key Success Factors:**
- Clean, maintainable code structure
- Comprehensive documentation
- Mobile-first responsive design
- Professional image presentation
- Robust error handling
- User-centered design approach
