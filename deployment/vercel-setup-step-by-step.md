# 🚀 Vercel Setup Guide - Step by Step

**Date:** September 12, 2025  
**Project:** Yarn Toys v2  
**Branch:** production-deploy  
**Repository:** macsalaga-copilot2/yarn-toys

---

## 📋 **Prerequisites Checklist**

✅ **Build Success**: `npm run build` passes (21 pages generated)  
✅ **Code Quality**: ESLint and TypeScript checks pass  
✅ **Git Status**: All changes committed and pushed to GitHub  
✅ **Branch Ready**: `production-deploy` branch is current  

---

## 🔧 **Step 1: Vercel Account Setup**

### 1.1 Create/Login to Vercel Account
1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub account (recommended)
3. Authorize Vercel to access your GitHub repositories

### 1.2 Install Vercel CLI (Optional)
```bash
npm i -g vercel
vercel login
```

---

## 🔗 **Step 2: Connect GitHub Repository**

### 2.1 Import Project
1. In Vercel dashboard, click **"Add New..."** → **"Project"**
2. Find `macsalaga-copilot2/yarn-toys` repository
3. Click **"Import"**

### 2.2 Configure Project Settings
- **Framework Preset**: Next.js (auto-detected)
- **Root Directory**: `./` (keep default)
- **Build Command**: `npm run build` (auto-detected)
- **Output Directory**: `.next` (auto-detected)
- **Install Command**: `npm install` (auto-detected)

### 2.3 Branch Configuration
- **Production Branch**: `production-deploy`
- **Preview Deployments**: All branches (recommended)

---

## 🌍 **Step 3: Environment Variables Setup**

### 3.1 Required Environment Variables
Copy these to Vercel → Project Settings → Environment Variables:

#### **Core Application**
```
NODE_ENV=production
NEXT_PUBLIC_APP_URL=https://[your-project-name].vercel.app
NEXT_PUBLIC_API_URL=https://[your-project-name].vercel.app/api
```

#### **Sanity CMS** (Your actual values)
```
NEXT_PUBLIC_SANITY_PROJECT_ID=ye3pqate
NEXT_PUBLIC_SANITY_DATASET=production
NEXT_PUBLIC_SANITY_API_VERSION=2024-05-15
SANITY_API_READ_TOKEN=skMFgnmjsy5AWGNi5uTWPlb5SN3KnRKv1aDNHpRhUecV8eMOuOgxKFYGXWZuRBNKXpD8V1Wb4qwfYOJJsoo0KNGLrBwBy2W8GVpRj9vhVnGqmcwQ8c9DssHI26YzJomWKew8OTBpMGp5Ar2gRiT8eA0yJA5KtcrzLdQ802xRvqhXhCNdmI4c
SANITY_API_WRITE_TOKEN=skMFgnmjsy5AWGNi5uTWPlb5SN3KnRKv1aDNHpRhUecV8eMOuOgxKFYGXWZuRBNKXpD8V1Wb4qwfYOJJsoo0KNGLrBwBy2W8GVpRj9vhVnGqmcwQ8c9DssHI26YzJomWKew8OTBpMGp5Ar2gRiT8eA0yJA5KtcrzLdQ802xRvqhXhCNdmI4c
```

#### **Optional (Add Later)**
```
NEXT_PUBLIC_GA_TRACKING_ID=G-XXXXXXXXXX
NEXT_PUBLIC_GTM_ID=GTM-XXXXXXX
API_SECRET_KEY=your_super_secure_api_secret_key_here
```

### 3.2 Environment Variable Setup in Vercel UI
1. Go to Project Settings → Environment Variables
2. Add each variable:
   - **Key**: Variable name (e.g., `NEXT_PUBLIC_SANITY_PROJECT_ID`)
   - **Value**: Variable value 
   - **Environment**: Select "Production", "Preview", and "Development"
3. Click "Save"

---

## 🚀 **Step 4: Deploy to Production**

### 4.1 Trigger First Deployment
1. Click **"Deploy"** in Vercel dashboard
2. Or push any change to `production-deploy` branch:
```bash
git commit --allow-empty -m "🚀 deploy: Trigger initial Vercel deployment"
git push origin production-deploy
```

### 4.2 Monitor Deployment
- Watch build logs in Vercel dashboard
- Expected build time: 2-5 minutes
- Check for any errors in build process

### 4.3 Verify Deployment
Once deployed, test these URLs:

**Homepage:**
```
https://[your-project-name].vercel.app
```

**API Health Check:**
```
https://[your-project-name].vercel.app/api/health
```

**Products Page:**
```
https://[your-project-name].vercel.app/my-toys
```

---

## ⚙️ **Step 5: Configure Custom Domain (Optional)**

### 5.1 Add Domain
1. Go to Project Settings → Domains
2. Add your custom domain
3. Update DNS records as instructed by Vercel

### 5.2 Update Environment Variables
Update URLs in environment variables:
```
NEXT_PUBLIC_APP_URL=https://yourdomain.com
NEXT_PUBLIC_API_URL=https://yourdomain.com/api
```

---

## 🔍 **Step 6: Post-Deployment Testing**

### 6.1 Functional Testing
- [ ] Homepage loads correctly
- [ ] All 90 products display on `/my-toys`
- [ ] Individual product pages work
- [ ] Images load from Sanity CDN
- [ ] Health check returns "healthy"

### 6.2 Performance Testing
- [ ] Core Web Vitals are good
- [ ] Page load times acceptable
- [ ] Images optimized

### 6.3 API Testing
```bash
# Test API endpoints
curl https://[your-project-name].vercel.app/api/health
curl https://[your-project-name].vercel.app/api/products/latest?limit=3
```

---

## 🏗️ **Step 7: Enable Automatic Deployments**

### 7.1 GitHub Integration Settings
- **Production Deployments**: Only from `production-deploy` branch
- **Preview Deployments**: All other branches and PRs
- **Auto-merge**: Disabled (manual review recommended)

### 7.2 Deployment Protection (Recommended)
1. Enable deployment protection for production
2. Require approval for production deployments
3. Set up Slack/email notifications

---

## 📊 **Step 8: Configure Monitoring**

### 8.1 Vercel Analytics
1. Enable Vercel Analytics in project settings
2. Add to your site (automatically enabled)

### 8.2 Health Monitoring
- Cron job already configured: `/api/health` every 6 hours
- Monitor via Vercel Functions dashboard

### 8.3 Error Tracking
- Vercel automatically tracks build and runtime errors
- Check Functions → Error logs

---

## 🆘 **Troubleshooting Common Issues**

### Build Fails
- Check environment variables are set
- Verify Sanity tokens are valid
- Check build logs for specific errors

### Images Not Loading
- Verify `next.config.ts` has Sanity CDN configuration
- Check image URLs in browser network tab

### API Routes 500 Errors
- Check environment variables
- Verify Sanity connection
- Check function logs in Vercel dashboard

---

## ✅ **Deployment Checklist**

- [ ] Vercel account created and GitHub connected
- [ ] Repository imported to Vercel
- [ ] Environment variables configured
- [ ] First deployment successful
- [ ] Homepage loading correctly
- [ ] Products page showing all 90 items
- [ ] API endpoints responding
- [ ] Health check working
- [ ] Monitoring enabled

---

## 🎯 **Next Steps After Deployment**

1. **Custom Domain**: Set up your domain
2. **Analytics**: Configure Google Analytics
3. **SEO**: Submit sitemap to search engines
4. **Performance**: Run Lighthouse audits
5. **Security**: Review security headers
6. **Backup**: Document rollback procedures

---

**Ready to deploy!** 🚀 Follow steps 1-4 for basic deployment, then continue with additional configuration as needed.
