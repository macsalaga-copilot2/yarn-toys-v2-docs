# 🚀 Deployment Guide - Yarn Toys V2

## Overview

This document provides comprehensive instructions for deploying Yarn Toys V2 to production using Vercel, with automated CI/CD pipeline via GitHub Actions.

## Prerequisites

### Required Accounts & Access
- ✅ **GitHub Repository**: Access to yarn-toys repository
- ✅ **Vercel Account**: Connected to GitHub
- ✅ **Sanity Account**: Project access with production dataset
- ✅ **Domain**: Custom domain configured (optional)

### Required Tools
- Node.js 20+ 
- npm 10+
- Vercel CLI (optional, for manual deployments)
- Git

## Deployment Environments

### 🌐 Preview Deployments
- **Trigger**: Pull requests to `main` branch
- **URL**: Automatically generated Vercel preview URLs
- **Purpose**: Feature testing and review
- **Environment**: Preview-specific configs

### 🎭 Staging Deployment  
- **Trigger**: Manual deployment via GitHub Actions
- **URL**: `https://yarn-toys-staging.vercel.app`
- **Purpose**: Pre-production testing
- **Environment**: Staging dataset and configs

### 🏭 Production Deployment
- **Trigger**: Push to `main` branch
- **URL**: `https://yarn-toys.vercel.app`
- **Purpose**: Live application
- **Environment**: Production dataset and configs

## Quick Start Deployment

### 1. Initial Vercel Setup

```bash
# Install Vercel CLI
npm install -g vercel@latest

# Login to Vercel
vercel login

# Link project (run from project root)
vercel link

# Set up environment variables
vercel env add NEXT_PUBLIC_SANITY_PROJECT_ID
vercel env add SANITY_API_READ_TOKEN
# ... add all required variables
```

### 2. Automated Deployment (Recommended)

1. **Push to main branch**:
   ```bash
   git add .
   git commit -m "feat: ready for production deployment"
   git push origin main
   ```

2. **Monitor deployment**: 
   - Check GitHub Actions tab for deployment status
   - Review deployment logs in Vercel dashboard

### 3. Manual Deployment

Use the deployment script for manual deployments:

```bash
# Preview deployment
./scripts/deploy.sh preview

# Staging deployment  
./scripts/deploy.sh staging

# Production deployment
./scripts/deploy.sh production
```

## Environment Variables Setup

### Vercel Dashboard Setup

1. Go to Vercel Dashboard → Project → Settings → Environment Variables
2. Add variables for each environment (Production, Preview, Development)

### Required Environment Variables

```env
# Core Application
NODE_ENV=production
NEXT_PUBLIC_APP_URL=https://yarn-toys.vercel.app

# Sanity CMS
NEXT_PUBLIC_SANITY_PROJECT_ID=your_project_id
NEXT_PUBLIC_SANITY_DATASET=production
SANITY_API_READ_TOKEN=your_read_token

# Security
API_SECRET_KEY=your_secure_api_key
WEBHOOK_SECRET=your_webhook_secret

# Analytics (Optional)
NEXT_PUBLIC_GA_TRACKING_ID=G-XXXXXXXXXX
```

### GitHub Secrets Setup

Add these secrets to your GitHub repository:

1. Go to GitHub Repository → Settings → Secrets and Variables → Actions
2. Add the following secrets:

```
VERCEL_TOKEN=your_vercel_token
VERCEL_ORG_ID=your_vercel_org_id  
VERCEL_PROJECT_ID=your_vercel_project_id
NEXT_PUBLIC_SANITY_PROJECT_ID=your_sanity_project_id
SANITY_API_READ_TOKEN=your_sanity_read_token
```

## Deployment Pipeline Features

### 🔒 Security Checks
- Dependency vulnerability scanning
- Security audit with `npm audit`
- Environment validation
- Security headers verification

### 🏗️ Build Process
- Multi-environment builds (development, production)
- TypeScript type checking
- ESLint code quality checks
- Bundle size analysis

### 📝 Content Validation
- Sanity CMS health checks
- Content completeness verification
- Image optimization validation
- SEO metadata checks

### 🧪 Testing & Validation
- Automated smoke tests
- API endpoint validation
- Security headers verification
- Performance benchmarks

### 🚀 Deployment Features
- Zero-downtime deployments
- Automatic rollback on failure
- Preview deployments for PRs
- Production deployment protection

## Deployment Checklist

### Pre-Deployment
- [ ] Environment variables configured
- [ ] Content health check passing (90/100+)
- [ ] All tests passing locally
- [ ] Security audit clean
- [ ] Build successful

### During Deployment
- [ ] Monitor GitHub Actions progress
- [ ] Check Vercel deployment logs
- [ ] Verify deployment URL accessibility
- [ ] Test critical user flows

### Post-Deployment
- [ ] Smoke tests passing
- [ ] API health endpoint responding
- [ ] Security headers present
- [ ] Analytics tracking working
- [ ] Content displaying correctly

## Troubleshooting

### Common Issues

**Build Failures**
```bash
# Check environment variables
npm run build

# Verify TypeScript
npx tsc --noEmit

# Check for missing dependencies
npm ci
```

**Environment Issues**
```bash
# Validate environment configuration
node -e "console.log(process.env.NODE_ENV)"

# Test Sanity connection
npm run sanity-test
```

**Deployment Failures**
```bash
# Check Vercel logs
vercel logs

# Test local deployment
vercel dev

# Rebuild and redeploy
vercel --prod --force
```

### Support Resources

- **Vercel Documentation**: https://vercel.com/docs
- **Next.js Deployment**: https://nextjs.org/docs/deployment
- **Sanity Deployment**: https://www.sanity.io/docs/deployment
- **GitHub Actions**: https://docs.github.com/en/actions

## Rollback Procedures

### Automatic Rollback
- Deployment fails → Previous version remains active
- Health checks fail → Automatic rollback triggered

### Manual Rollback
```bash
# List deployments
vercel ls

# Promote previous deployment
vercel promote [deployment-url] --scope=[team]
```

### Emergency Procedures
1. **Immediate**: Roll back via Vercel dashboard
2. **Investigation**: Check logs and metrics
3. **Fix**: Address issues on development branch
4. **Redeploy**: Push fix through normal pipeline

## Performance Monitoring

### Metrics to Monitor
- **Build Time**: < 5 minutes
- **Deployment Time**: < 3 minutes  
- **First Load**: < 3 seconds
- **API Response**: < 500ms
- **Bundle Size**: < 200kB

### Monitoring Tools
- Vercel Analytics
- Vercel Speed Insights  
- GitHub Actions timing
- Browser DevTools

---

## 📞 Support

For deployment issues or questions:
1. Check this documentation
2. Review deployment logs in Vercel
3. Check GitHub Actions run details
4. Consult Vercel and Next.js documentation
