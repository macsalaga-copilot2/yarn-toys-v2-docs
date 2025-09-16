# 🚀 Quick Start Guide: Batch Processing Products

## ⚡ TL;DR - Essential Steps

### 1. Setup (5 minutes)
```bash
# Environment variables in .env.local
NEXT_PUBLIC_SANITY_PROJECT_ID=your_project_id
NEXT_PUBLIC_SANITY_DATASET=production
SANITY_API_TOKEN=your_write_token
```

### 2. Image Preparation
- **Format**: toy-X.jpg, toy-X-original.jpg, toy-X-thumb.jpg
- **Location**: `public/images/products/`
- **Naming**: Sequential numbering (toy-1, toy-2, etc.)

### 3. Batch Script Template
```javascript
// Copy from scripts/process-batch-1.js
// Update toy data array
// Run: node scripts/process-batch-X.js
```

### 4. Success Formula
✅ **Flat image structure**: `image: sanityRef` (not nested)  
✅ **Error handling**: Check file existence before upload  
✅ **Rate limiting**: 500ms delay between operations  
✅ **Progress tracking**: Log successful/failed items  

---

## 📋 Batch Processing Checklist

### Pre-Processing ✅
- [ ] Images exist and follow naming convention
- [ ] Sanity connection tested
- [ ] Preview interface created and reviewed
- [ ] AI-generated names collected in correct format
- [ ] Batch script updated with toy data

### Processing ⚙️
- [ ] Run script: `node scripts/process-batch-X.js`
- [ ] Monitor console for errors
- [ ] Verify uploads in Sanity Studio
- [ ] Test random products on website

### Post-Processing ✅
- [ ] All products display correctly on frontend
- [ ] Images load without broken links
- [ ] Individual product pages work
- [ ] Commit and push changes to Git

---

## 🔧 Common Issues Quick Fix

### Images Not Showing
```javascript
// ❌ Wrong structure
image: { main: sanityRef }

// ✅ Correct structure  
image: sanityRef
```

### Upload Failures
```javascript
// Add file existence check
if (!fs.existsSync(imagePath)) {
  console.log(`⚠️  Image not found: ${imagePath}`);
  return null;
}
```

### API Rate Limiting
```javascript
// Add delay between operations
await new Promise(resolve => setTimeout(resolve, 500));
```

---

## 📊 Batch Size Recommendations

| Total Products | Batch Size | Rationale |
|---------------|------------|-----------|
| 1-50 | 10-15 | Small manageable chunks |
| 51-100 | 15-20 | Our proven successful size |
| 101-200 | 20-25 | Balanced efficiency |
| 200+ | 25-30 | Maximum efficiency |

---

## 🎯 Success Metrics

- **Target Success Rate**: 100%
- **Processing Speed**: 2-3 seconds per product
- **Error Tolerance**: <1%
- **Image Upload**: All 3 variants per product

---

## 🚨 Emergency Troubleshooting

### Script Crashes Mid-Batch
1. Check console for last successful product
2. Update script to start from next product ID
3. Resume processing from failure point

### Sanity Connection Issues
1. Verify API token has write permissions
2. Check project ID and dataset name
3. Test connection with simple query

### Image Upload Failures
1. Verify image file permissions
2. Check file size limits
3. Ensure proper image formats (JPG/PNG)

---

*This guide references the complete methodology in `batch-processing-methodology.md`*
