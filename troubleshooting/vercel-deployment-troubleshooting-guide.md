# 🛠️ Vercel Deployment Troubleshooting Guide

**Created:** September 12, 2025  
**Project:** Yarn Toys v2 - Step 6 Deployment  
**Context:** Production deployment issues resolved during live deployment session

---

## 📋 **Overview**

## 🔍 **What Vercel Checks During Deployment**

Based on our successful build test (`npm run build`), here's exactly what Vercel validates:

### **1. Build Process Validation**

#### TypeScript Compilation
- **Automatic Check**: `tsc --noEmit` during build
- ✅ **Our Status**: All TypeScript types valid 
- **Previous Issue**: `.next/types/app/page.ts` errors (resolved)

#### ESLint Rules  
- **Automatic Check**: `next lint` during build
- ✅ **Our Status**: 1 minor warning about `<img>` tag in sanity-test page
- 🔧 **Recommendation**: Consider using Next.js `<Image>` component

#### Build Success
```bash
✅ Build Status: SUCCESS
✅ Pages Generated: 21 total (16 static, 5 dynamic)
✅ API Routes: 8 endpoints validated
✅ Bundle Size: Optimized (largest route: 186 kB)
⚠️ Warnings: 1 minor ESLint warning
```

### **2. Route Validation**
```
Route (app)                                 Size  First Load JS    
┌ ○ /                                    20.3 kB         171 kB
├ ○ /my-toys                             4.39 kB         158 kB  
├ ƒ /my-toys/[slug]                      22.5 kB         186 kB
├ ○ /informacja-prawna                     708 B         111 kB
└ ○ /studio/[[...tool]]                  1.47 MB        1.61 MB
```

### **3. API Endpoints Check**
✅ `/api/health` - Health monitoring  
✅ `/api/products` - Product listing  
✅ `/api/products/[slug]` - Individual products  
✅ `/api/products/latest` - Latest products  
✅ `/api/analytics/*` - Analytics endpoints  
✅ `/api/alerts` - Alert system  

### **4. Environment Variables**
Vercel validates required env vars are available:
- `NEXT_PUBLIC_SANITY_PROJECT_ID`
- `NEXT_PUBLIC_SANITY_DATASET` 
- `SANITY_API_READ_TOKEN`
- `NEXT_PUBLIC_BASE_URL`

### **5. Security & Performance**
- **Dependency Scan**: Checks for vulnerabilities
- **Bundle Analysis**: Validates size limits
- **Image Optimization**: Confirms Next.js Image config
- **HTTPS**: Automatic enforcement

This guide documents real-world deployment issues encountered during the yarn-toys-v2 project deployment to Vercel, including specific error messages, root causes, solutions, and prevention strategies. Use this as a comprehensive reference for troubleshooting similar deployment issues in future projects.

---

## 🎯 **Quick Reference - Common Issues**

| Issue Type | Error Pattern | Quick Fix |
|------------|---------------|-----------|
| **Config Conflicts** | `builds` + `functions` conflict | Remove `builds`, use modern config |
| **Plan Limitations** | `Hobby accounts are limited` | Check plan limits, adjust config |
| **Environment Variables** | `Missing environment variable` | Configure in Vercel before deploy |
| **Routing Conflicts** | `routes` cannot be present | Use modern routing properties |
| **Pattern Mismatch** | `pattern doesn't match` | Remove unnecessary functions config |
| **Route Group Issues** | `404: NOT_FOUND` homepage | Create root `page.tsx` with re-export |

---

## 🚨 **Detailed Issue Resolution**

### **1. Vercel Configuration Conflicts**

#### **Issue: Legacy vs Modern Configuration**
```
Error: The `functions` property cannot be used in conjunction with the `builds` property. 
Please remove one of them.
Learn More: https://vercel.link/functions-and-builds
```

**Root Cause Analysis:**
- Mixed legacy (`builds`) and modern (`functions`) configuration patterns
- Vercel requires consistent configuration approach
- Next.js 15 App Router makes explicit builds configuration unnecessary

**Solution Steps:**
```json
// ❌ BEFORE - Conflicting configuration
{
  "builds": [
    {
      "src": "next.config.ts",
      "use": "@vercel/next@latest",
      "config": { "maxDuration": 60 }
    }
  ],
  "functions": {
    "src/app/api/**/*.ts": { "maxDuration": 30 }
  }
}

// ✅ AFTER - Clean modern configuration
{
  "version": 2,
  "public": false
  // Let Next.js handle builds and functions automatically
}
```

**Prevention Strategy:**
- Use either legacy OR modern configuration, never both
- For Next.js 13+, prefer minimal configuration
- Let framework handle build optimization automatically

---

### **2. Vercel Plan Limitations**

#### **Issue: Cron Job Frequency Restrictions**
```
Error: Hobby accounts are limited to daily cron jobs. This cron expression (*/5 * * * *) 
would run more than once per day. Upgrade to the Pro plan to unlock all Cron Jobs features.
Learn More: https://vercel.link/3Fpeeb1
```

**Root Cause Analysis:**
- Attempted to schedule cron job every 5 minutes
- Vercel Hobby plan restricts cron jobs to daily frequency maximum
- Health check endpoint tried to run 288 times per day (every 5 minutes)

**Solution Steps:**
```json
// ❌ BEFORE - Too frequent for Hobby plan
"crons": [
  {
    "path": "/api/health",
    "schedule": "*/5 * * * *"  // Every 5 minutes
  }
]

// ✅ AFTER - Daily schedule compliant with Hobby plan
"crons": [
  {
    "path": "/api/health", 
    "schedule": "0 12 * * *"  // Daily at 12:00 PM UTC
  }
]
```

**Prevention Strategy:**
- Check Vercel plan limitations before configuration
- Use external monitoring services for frequent health checks
- Consider upgrading to Pro plan if frequent crons required

#### **Issue: Multi-Region Deployment Restrictions**
```
Error: Deploying Serverless Functions to multiple regions is restricted to the 
Pro and Enterprise plans.
Learn More: https://vercel.link/multiple-function-regions
```

**Root Cause Analysis:**
- Configured deployment to multiple regions (`fra1`, `iad1`)
- Hobby plan only supports single-region deployment
- Vercel automatically optimizes region selection on Hobby plan

**Solution Steps:**
```json
// ❌ BEFORE - Multiple regions on Hobby plan
{
  "regions": ["fra1", "iad1"]
}

// ✅ AFTER - Let Vercel auto-select optimal region
{
  // Remove regions property entirely
  // Vercel automatically chooses best region
}
```

**Prevention Strategy:**
- Remove regions configuration on Hobby plan
- Trust Vercel's automatic region optimization
- Consider Pro plan if multi-region deployment required

---

### **3. Environment Variables Configuration**

#### **Issue: Missing Required Environment Variables**
```
Error: `projectId` can only contain only a-z, 0-9 and dashes
    at tF (.next/server/chunks/5588.js:10:3597)
    at createClient (.next/server/chunks/5588.js:13:30947)
```

**Root Cause Analysis:**
- Required Sanity CMS environment variables missing from Vercel
- Build process attempted to create Sanity client with undefined projectId
- Local `.env` files don't automatically transfer to Vercel

**Solution Steps:**
```bash
# 1. Identify required environment variables
# From src/lib/environment.ts:
# - NEXT_PUBLIC_SANITY_PROJECT_ID
# - NEXT_PUBLIC_SANITY_DATASET  
# - NEXT_PUBLIC_SANITY_API_VERSION

# 2. Add environment variables to Vercel
vercel env add NEXT_PUBLIC_SANITY_PROJECT_ID
# Value: [REDACTED_PROJECT_ID]
# Environment: Production

vercel env add NEXT_PUBLIC_SANITY_DATASET
# Value: production
# Environment: Production

vercel env add NEXT_PUBLIC_SANITY_API_VERSION  
# Value: 2024-05-15
# Environment: Production

# 3. Verify configuration
vercel env ls
```

**Common User Errors:**
- **Wrong Value Entry:** Entered project ID (`[REDACTED_PROJECT_ID]`) for dataset instead of `production`
- **Environment Selection:** Forgot to select Production environment
- **Typos:** Mistyped environment variable values

**Prevention Strategy:**
- Configure environment variables BEFORE first deployment
- Use environment validation utilities in code
- Double-check values against project documentation
- Test environment variable access in development

---

### **4. Routing Configuration Conflicts**

#### **Issue: Legacy vs Modern Routing**
```
Error: If `rewrites`, `redirects`, `headers`, `cleanUrls` or `trailingSlash` are used, 
then `routes` cannot be present.
Learn More: https://vercel.link/mix-routing-props
```

**Root Cause Analysis:**
- Mixed legacy `routes` with modern routing properties
- Vercel requires consistent routing approach
- Modern properties offer better functionality and performance

**Solution Steps:**
```json
// ❌ BEFORE - Mixed routing configuration
{
  "routes": [
    {
      "src": "/api/health",
      "headers": {
        "Cache-Control": "no-store, no-cache, must-revalidate, max-age=0"
      }
    }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [/* modern headers */]
    }
  ]
}

// ✅ AFTER - Modern routing only
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        }
        // ... other security headers
      ]
    }
  ],
  "redirects": [
    {
      "source": "/admin",
      "destination": "/studio", 
      "permanent": false
    }
  ]
}
```

**Prevention Strategy:**
- Use modern routing properties exclusively
- Migrate legacy `routes` to appropriate modern equivalents
- Consult Vercel documentation for current best practices

---

### **5. Functions Pattern Matching**

#### **Issue: Unnecessary Functions Configuration**
```
Error: The pattern "src/app/api/**/*.ts" defined in `functions` doesn't match any 
Serverless Functions inside the `api` directory.
Learn More: https://vercel.link/unmatched-function-pattern
```

**Root Cause Analysis:**
- Explicit functions configuration unnecessary for Next.js App Router
- Pattern matching failed because Next.js handles API routes automatically
- Over-configuration led to deployment warnings

**Solution Steps:**
```json
// ❌ BEFORE - Unnecessary explicit configuration
{
  "functions": {
    "src/app/api/**/*.ts": {
      "maxDuration": 30
    }
  }
}

// ✅ AFTER - Let Next.js handle automatically
{
  // Remove functions configuration entirely
  // Next.js App Router automatically detects and configures API routes
}
```

**Prevention Strategy:**
- Trust Next.js App Router automatic detection
- Only configure functions if specific customization needed
- Test deployment without explicit configuration first

### **6. Route Group Routing Issues**

#### **Issue: Homepage 404 NOT_FOUND Error**
```
404: NOT_FOUND
Code: NOT_FOUND
ID: arn1::nhg47-1757661921486-1d45e53e50c3
```

**Root Cause Analysis:**
- Next.js App Router route groups `(site)` don't automatically create root routes
- Homepage `page.tsx` was inside `(site)` route group directory
- Vercel deployment successful but root URL not accessible
- Route groups require explicit root-level page for proper routing

**Solution Steps:**
```tsx
// Create /src/app/page.tsx with re-export
// Root page - exports the main site page
// This ensures the homepage loads correctly at the root URL
export { default } from './(site)/page'
```

**Verification:**
```bash
# Build test confirms route detection
npm run build
# Should show: ○ /  (size in kB)  (First Load JS in kB)

# Test deployment
vercel --prod
```

**Prevention Strategy:**
- Always create root-level `page.tsx` when using route groups
- Test homepage routing in local development
- Verify build output shows root route `/`
- Consider flattening structure if route groups aren't necessary

---

### **Pre-Deployment Checklist** ✅

#### **1. Environment Preparation**
- [ ] Identify all required environment variables from code
- [ ] Prepare correct values for production environment
- [ ] Test environment variable access in development
- [ ] Document variable purposes and valid values

#### **2. Vercel Configuration Audit**
- [ ] Check Vercel plan limitations (regions, crons, functions)
- [ ] Use modern configuration patterns consistently
- [ ] Remove unnecessary explicit configurations
- [ ] Validate configuration against current Vercel documentation

#### **3. Code Readiness Verification**
- [ ] Ensure all dependencies are production-ready
- [ ] Validate build process works locally
- [ ] Test API routes and server functions
- [ ] Verify environment variable usage

### **Deployment Process** 🚀

#### **Step 1: Environment Variables First**
```bash
# Always configure environment variables before deployment
vercel env add VARIABLE_NAME
# Follow prompts for value and environment selection
```

#### **Step 2: Clean Configuration**
```json
// Minimal vercel.json for Next.js 15 App Router
{
  "version": 2,
  "public": false,
  "headers": [/* security headers only */],
  "redirects": [/* if needed */],
  "crons": [/* daily frequency for Hobby plan */]
}
```

#### **Step 3: Deploy and Monitor**
```bash
vercel --prod
# Monitor build logs for issues
# Test deployment thoroughly
```

### **Troubleshooting Strategy** 🔧

#### **1. Read Error Messages Completely**
- Vercel error messages often contain specific solution links
- Follow provided documentation links for detailed guidance
- Look for plan limitation indicators

#### **2. Systematic Issue Resolution**
- Fix one configuration issue at a time
- Redeploy after each fix to isolate problems
- Verify fix effectiveness before proceeding

#### **3. Environment Variable Debugging**
```bash
# List all configured environment variables
vercel env ls

# Remove incorrect variables
vercel env rm VARIABLE_NAME

# Add corrected variables
vercel env add VARIABLE_NAME
```

#### **4. Configuration Validation**
- Start with minimal configuration
- Add features incrementally
- Test each addition separately

---

## 📊 **Success Metrics & Benchmarks**

### **Deployment Performance**
- **Target Build Time:** < 5 minutes
- **Configuration Issues:** Aim for zero on first deployment
- **Environment Variables:** 100% correct on first attempt
- **Rollback Time:** < 2 minutes if needed

### **Issue Resolution Time**
- **Configuration Conflicts:** ~5 minutes per issue
- **Environment Variables:** ~10 minutes for complete setup
- **Plan Limitations:** ~2 minutes to identify and resolve
- **Total Resolution:** ~30 minutes for complex issues

### **Quality Indicators**
- **Zero Build Errors** on final deployment
- **All Environment Variables** correctly configured
- **Clean Configuration** with no unnecessary properties
- **Production-Ready** performance and security

---

## 🔮 **Future Project Template**

### **Quick Deployment Checklist**
```markdown
- [ ] Check Vercel plan limitations
- [ ] Prepare environment variables list
- [ ] Create minimal vercel.json
- [ ] Configure environment variables in Vercel
- [ ] Test deployment with clean configuration
- [ ] Validate all functionality post-deployment
```

### **Standard vercel.json Template**
```json
{
  "version": 2,
  "public": false,
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {"key": "X-Content-Type-Options", "value": "nosniff"},
        {"key": "X-Frame-Options", "value": "DENY"},
        {"key": "X-XSS-Protection", "value": "1; mode=block"},
        {"key": "Referrer-Policy", "value": "origin-when-cross-origin"}
      ]
    }
  ],
  "crons": [
    {
      "path": "/api/health",
      "schedule": "0 12 * * *"
    }
  ]
}
```

### **Environment Variables Setup Script**
```bash
#!/bin/bash
# deployment-env-setup.sh

echo "Setting up Vercel environment variables..."

# Sanity CMS (Required)
vercel env add NEXT_PUBLIC_SANITY_PROJECT_ID
vercel env add NEXT_PUBLIC_SANITY_DATASET  
vercel env add NEXT_PUBLIC_SANITY_API_VERSION

# Analytics (Optional)
vercel env add NEXT_PUBLIC_GA_MEASUREMENT_ID
vercel env add NEXT_PUBLIC_SENTRY_DSN

echo "Environment setup complete. Run 'vercel env ls' to verify."
```

---

## 📚 **Additional Resources**

### **Official Documentation**
- [Vercel Configuration Reference](https://vercel.com/docs/projects/project-configuration)
- [Vercel Plan Limitations](https://vercel.com/docs/limits/overview)
- [Next.js App Router Deployment](https://nextjs.org/docs/app/building-your-application/deploying)
- [Environment Variables in Vercel](https://vercel.com/docs/projects/environment-variables)

### **Related Project Documentation**
- [`docs/planning/step-6-deployment-go-live-action-plan.md`](../planning/step-6-deployment-go-live-action-plan.md)
- [`docs/implementation/sanity-implementation-summary.md`](../implementation/sanity-implementation-summary.md)
- [`docs/DEPLOYMENT.md`](../DEPLOYMENT.md)

---

**📝 Guide authored by:** GitHub Copilot  
**🗓️ Based on deployment session:** September 12, 2025  
**🎯 Project:** yarn-toys-v2 Production Deployment  
**✅ Status:** Successfully resolved all issues, production deployment operational

**🔄 Last updated:** September 12, 2025, 08:25 UTC
