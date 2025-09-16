# Tag Recovery Strategy & Methods
**Date**: September 14, 2025  
**Project**: yarn-toys  
**Working Tag**: `v1.0-working-deployment` (commit: e9ad3bd)

## 🎯 **Tag Purpose**
The `v1.0-working-deployment` tag marks the last known stable state where:
- ✅ Vercel deployments work successfully
- ✅ All core functionality operational
- ✅ CI/CD pipeline partially working (Vercel auto-deploy functional)
- ⚠️ GitHub Actions CI failing (Html import error in development matrix)

## 🔄 **Recovery Methods**

### **Method 1: Quick Inspection (Safe)**
```bash
git checkout v1.0-working-deployment
```
**When to use:** Quick verification or testing of stable version  
**Effect:** Temporary detached HEAD state at working commit  
**Safety:** ✅ Non-destructive, doesn't change main branch  
**Return:** `git checkout main` to return to current state

### **Method 2: Emergency Rollback (Destructive)**
```bash
git checkout main
git reset --hard v1.0-working-deployment
git push origin main --force
```
**When to use:** Complete system failure, need immediate rollback  
**Effect:** Main branch permanently reset to working state  
**Safety:** ⚠️ DESTRUCTIVE - Loses all commits after tag  
**Warning:** Use only as last resort

### **Method 3: Recovery Branch (Recommended)**
```bash
git checkout -b recovery-$(date +%Y%m%d) v1.0-working-deployment
```
**When to use:** Need to work from stable base while debugging  
**Effect:** Creates new branch from working state  
**Safety:** ✅ Preserves all history  
**Benefit:** Allows parallel development and debugging

### **Method 4: Selective Revert (Surgical)**
```bash
git checkout main
git revert <problematic-commit-hash>
git push origin main
```
**When to use:** Specific commit caused issues  
**Effect:** Creates revert commit undoing changes  
**Safety:** ✅ Preserves complete history  
**Benefit:** Clean audit trail of what went wrong

## 🛡️ **Recovery Workflow Process**

### **Step 1: Assess the Situation**
```bash
# Check current status
git status
git log --oneline -5

# Verify tag still exists
git tag --list | grep working-deployment
```

### **Step 2: Choose Recovery Method**
- **Minor issues**: Method 4 (Selective Revert)
- **Need debugging**: Method 3 (Recovery Branch)
- **Quick check**: Method 1 (Quick Inspection)
- **Emergency**: Method 2 (Emergency Rollback)

### **Step 3: Execute Recovery**
```bash
# Example: Recovery Branch approach
git checkout -b hotfix-recovery v1.0-working-deployment

# Verify we're in working state
npm run build  # Should pass
vercel deploy  # Should work

# Fix issues in this branch
# When ready:
git checkout main
git merge hotfix-recovery
```

### **Step 4: Validate Recovery**
```bash
# Test local build
npm run build

# Test Vercel deployment
vercel deploy

# Check GitHub Actions (if applicable)
git push origin main
```

## 📋 **Tag Information & Verification**

### **View Tag Details**
```bash
git show v1.0-working-deployment
git log --oneline v1.0-working-deployment -3
```

### **Tag Contents Verification**
- **Commit Hash**: e9ad3bd
- **State**: Post-CI/CD pipeline fixes
- **Vercel Status**: ✅ Working deployments
- **GitHub Actions**: ⚠️ Failing (development matrix issue)
- **Environment Variables**: ✅ Configured
- **Git Integration**: ✅ Connected

### **Working Features at Tag**
- ✅ Local builds pass
- ✅ Vercel manual deployments work
- ✅ Vercel auto-deployments from GitHub
- ✅ Sanity integration functional
- ✅ Next.js App Router working
- ✅ Production environment builds

## 🚨 **Emergency Contact Points**

### **If Complete Rollback Needed**
1. **Immediate**: `git reset --hard v1.0-working-deployment`
2. **Redeploy**: `vercel deploy --prod`
3. **Notify team**: Site restored to working state
4. **Document**: What caused the emergency

### **If Partial Recovery Needed**
1. **Branch**: `git checkout -b emergency-fix v1.0-working-deployment`
2. **Deploy**: From stable branch while investigating
3. **Fix**: Address issues incrementally
4. **Merge**: When ready and tested

## 📊 **Recovery Success Metrics**

**Verify these after any recovery:**
- [ ] `npm run build` passes locally
- [ ] `vercel deploy` succeeds  
- [ ] Site accessible at live URL
- [ ] Auto-deployment working from GitHub
- [ ] No console errors in browser
- [ ] Sanity data loading correctly

## 🔗 **Related Documentation**
- CI/CD Pipeline Resolution: `docs/troubleshooting/ci-cd-pipeline-resolution-sept-13-2025.md`
- Vercel Deployment Guide: `docs/troubleshooting/vercel-deployment-troubleshooting-guide.md`

## 📝 **Recovery Log Template**
```
Date: 
Issue: 
Method Used: 
Recovery Time: 
Verification Steps: 
Lessons Learned: 
```

---
**Last Updated**: September 14, 2025  
**Next Review**: After next major deployment  
**Maintainer**: Development Team