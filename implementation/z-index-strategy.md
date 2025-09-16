# Z-Index Strategy & Layer Management

## Overview
Comprehensive z-index management system to prevent layering conflicts and ensure proper element stacking throughout the application.

## Z-Index Hierarchy

### **Layer 1: Background Elements (z-0 to z-10)**
- `z-0`: Default content, images, cards
- `z-10`: Hover effects, subtle overlays

### **Layer 2: Content Overlays (z-20 to z-50)**
- `z-20`: Content overlays, tooltips
- `z-30`: Dropdown menus, select boxes
- `z-40`: ~~Chat button (old)~~ → **DEPRECATED**
- `z-50`: ~~ChatWidget modal (old)~~ → **DEPRECATED**

### **Layer 3: Navigation Elements (z-90 to z-200)**
- `z-[98]`: Mobile scroll indicator
- `z-[99]`: Mobile navigation gradient overlay
- `z-[100]`: Main navigation bar
- `z-[200]`: Mobile menu overlay (highest navigation layer)

### **Layer 4: Interactive Widgets (z-300 to z-400)**
- `z-[300]`: **Chat button** (above all navigation)
- `z-[400]`: **ChatWidget modal** (above chat button)

### **Layer 5: System Overlays (z-500+)**
- `z-[500]`: Loading overlays, system notifications
- `z-[600]`: Error modals, critical alerts
- `z-[9999]`: Emergency overrides (use sparingly)

## Current Implementation

### Navigation Components
```typescript
// MainNav.tsx
className="fixed top-0 left-0 right-0 z-[100]"           // Main nav
className="z-[200] overflow-hidden"                       // Mobile menu
className="z-[99] w-full h-24 bg-gradient-to-b"         // Mobile gradient
className="z-[98] w-12 h-1 bg-gradient-to-r"            // Scroll indicator
```

### Chat System
```typescript
// Product detail page - Chat button
className="fixed bottom-6 right-6 z-[300]"              // Chat button

// ChatWidget.tsx - Modal
className="fixed inset-0 bg-black/50... z-[400]"        // Chat modal
```

## Best Practices

### ✅ Do's
- **Use semantic ranges**: Group related elements in logical z-index ranges
- **Document changes**: Update this file when adding new z-index values
- **Test overlays**: Verify elements stack correctly across all components
- **Use brackets notation**: `z-[300]` for custom values not in Tailwind defaults

### ❌ Don'ts  
- **Avoid arbitrary high values**: Don't use `z-[9999]` unless absolutely necessary
- **Don't mix systems**: Stick to the defined ranges
- **Avoid conflicts**: Check existing values before adding new ones
- **Don't skip documentation**: Always update this file for new z-index usage

## Debugging Z-Index Issues

### 1. Identify the Problem
```bash
# Search for z-index usage
grep -r "z-\[" src/
grep -r "z-[0-9]" src/
```

### 2. Check Current Values
- Navigation: 90-200 range
- Interactive widgets: 300-400 range  
- System overlays: 500+ range

### 3. Apply Fix
- Choose appropriate range based on element purpose
- Update this documentation
- Test with mobile menu open/closed

## Component-Specific Guidelines

### Navigation Components
- Main nav: `z-[100]`
- Mobile overlays: `z-[200]` max
- Gradient effects: `z-[99]` or below

### Interactive Elements
- Chat button: `z-[300]`
- Chat modal: `z-[400]`
- Tooltips: `z-20` to `z-30`

### Content Elements
- Product cards: `z-0` to `z-10`
- Hover effects: `z-10`
- Image overlays: `z-10`

## Recent Fixes

### Chat Button Layering (August 15, 2025)
**Issue:** Chat button `z-40` covered by navigation `z-[200]`  
**Fix:** Moved chat button to `z-[300]`, modal to `z-[400]`  
**Files:** `[slug]/page.tsx`, `ChatWidget.tsx`

## Testing Checklist

When modifying z-index values:
- [ ] Test with mobile menu open
- [ ] Test with chat widget open
- [ ] Test on mobile devices
- [ ] Test hover states
- [ ] Test keyboard navigation
- [ ] Verify accessibility (focus rings visible)

## Future Considerations

### Planned Additions
- Loading overlays: `z-[500]`
- Error notifications: `z-[600]`
- Image galleries/lightboxes: `z-[450]`

### Reserved Ranges
- `z-[700-800]`: Reserved for future system modals
- `z-[900-999]`: Reserved for accessibility overrides
- `z-[9999]`: Emergency use only

---

**Last Updated:** August 15, 2025  
**Next Review:** When adding new overlay components  
**Maintainer:** Development team
