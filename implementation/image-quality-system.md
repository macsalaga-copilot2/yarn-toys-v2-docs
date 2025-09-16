# Image Quality System - Technical Documentation

## Overview
Ultra-high quality image system with intelligent fallback architecture for yarn-toys website. Provides maximum resolution display while ensuring 100% reliability.

## Architecture

### Multi-Tier Image Sources
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Local Files   │    │   Local Files   │    │   Sanity CDN    │
│  {slug}-orig.jpg│ -> │  {toy-id}-orig  │ -> │  Compressed     │
│  2000x2500      │    │  2000x2500      │    │  1200x1500      │
│  Full Quality   │    │  Full Quality   │    │  Reliable       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Display Specifications
- **Product Cards**: 400x600 (Sanity optimized)
- **Single Product**: 720px width, auto height (preserves ratios)
- **PhotoSwipe**: Native resolution with auto-detected dimensions

## Implementation Details

### Image Loading Strategy
```typescript
// Primary attempt: slug-based naming
src: `/images/products/${product.slug.current}-original.jpg`

// Secondary: toy-ID naming  
src: `/images/products/${product._id}-original.jpg`

// Fallback: Sanity CDN
src: getImageUrl(product.image)
```

### PhotoSwipe Integration
```typescript
// Auto-dimension detection
testImg.onload = () => {
  openPhotoSwipe([{
    src: currentSrc,
    width: testImg.naturalWidth,   // Actual dimensions
    height: testImg.naturalHeight, // Perfect aspect ratio
    alt: product.name
  }], 0, element);
};
```

### Error Handling
```typescript
// Progressive fallback with onError
onError={(e) => {
  const target = e.target as HTMLImageElement;
  if (target.src.includes(product.slug.current)) {
    target.src = `/images/products/${product._id}-original.jpg`;
  } else {
    target.src = getImageUrl(product.image);
  }
}}
```

## File Organization

### Current Products
```
/public/images/products/
├── blossom-bear-original.jpg     (2000x2500)
├── toy-83-original.jpg           (1280x1600)
├── meadow-rabbit-girl-original.jpg
└── [product-slug]-original.jpg
```

### Naming Conventions
- **Slug-based**: `{product.slug.current}-original.jpg`
- **ID-based**: `{product._id}-original.jpg`
- **Sanity fallback**: Auto-generated URLs

## Quality Specifications

### Resolution Support
| Product Type | Resolution | Aspect Ratio | File Size |
|-------------|------------|--------------|-----------|
| Standard    | 2000x2500  | 4:5          | ~400KB    |
| Variant     | 1280x1600  | 4:5          | ~250KB    |
| Sanity      | 1200x1500  | 4:5          | ~150KB    |

### Display Quality
- **Original Preservation**: Zero compression loss
- **Aspect Ratio**: Natural proportions maintained
- **Responsive**: 720px desktop, 100vw mobile
- **Performance**: `unoptimized` flag for direct serving

## Adding New Products

### Method 1: Full Quality (Recommended)
1. Add product to Sanity CMS
2. Save original photo as `{slug}-original.jpg`
3. System automatically uses high-res version

### Method 2: Sanity Only
1. Upload high-resolution image to Sanity
2. System falls back to Sanity version
3. Still maintains good quality

## Benefits

### Quality Improvements
- **5x Resolution**: 2000x2500 vs 400x600 previous
- **Perfect Ratios**: No cropping or distortion
- **Zero Loss**: Direct camera file serving

### Reliability Features
- **100% Uptime**: Always shows working image
- **Smart Fallback**: Multiple quality tiers
- **Error Recovery**: Graceful degradation

### User Experience
- **Clean Design**: No hover effects or distractions
- **Fast Loading**: Optimized serving strategies
- **Professional**: High-quality presentation

## Technical Stack
- **Frontend**: Next.js 15 with Image optimization
- **CMS**: Sanity with CDN integration
- **Gallery**: PhotoSwipe with auto-dimension detection
- **Fallback**: Progressive error handling
- **Performance**: Direct file serving with responsive images

## Maintenance

### Adding Products
- Upload original files to `/public/images/products/`
- Follow naming convention: `{slug}-original.jpg`
- System handles everything automatically

### Quality Monitoring
- Original files: Check file sizes and dimensions
- Fallback system: Monitor Sanity CDN availability
- Performance: Track loading times and optimization

## Future Enhancements
- **Lazy Loading**: Implement for better performance
- **WebP Support**: Add next-gen format support
- **Batch Processing**: Automate original file management
- **Quality Analytics**: Track image performance metrics
