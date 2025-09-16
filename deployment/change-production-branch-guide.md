# 🔄 How to Change Vercel Production Branch

## 📍 **Current Situation**
- **Current Production Branch**: `main`
- **Desired Production Branch**: `production-deploy` 
- **Goal**: Auto-deploy from `production-deploy` instead of `main`

## 🛠️ **Step-by-Step Instructions**

### **Step 1: Access Project Settings**
1. Go to your Vercel project dashboard
2. Click on **"Settings"** tab  
3. Select **"Git"** from the left sidebar

### **Step 2: Find Production Branch Setting**
Look for one of these sections (Vercel interface varies):
- **"Production Branch"** 
- **"Git Configuration"**
- **"Branch Settings"**
- **"Connected Git Repository"** section

### **Step 3: Change Production Branch**
1. Find the dropdown or input field showing: `main`
2. Change it to: `production-deploy`  
3. Click **"Save"** or **"Update"**

### **Alternative Location (if not in Git tab):**
Some Vercel interfaces show this under:
- **Settings** → **General** → **Git Repository** 
- **Settings** → **Domains** → **Production Branch**

### **Step 3: Automatic Redeploy**
- Vercel will automatically trigger a new deployment
- This deployment will use your `production-deploy` branch
- All your latest fixes will be deployed

## ⚡ **What Happens Next**

### **Immediate Effect:**
- New deployment starts from `production-deploy` branch
- Latest code with all fixes goes live
- Build takes ~3-5 minutes

### **Future Deployments:**
- Every push to `production-deploy` = automatic deployment
- Pushes to other branches = preview deployments only
- `main` branch is no longer used for production

## 🎯 **Alternative: Deploy Hooks (If You Prefer Manual Control)**

If you want to keep `main` as production but manually trigger deployments from `production-deploy`:

### **Create Deploy Hook:**
1. Go to Settings → Git
2. Scroll to "Deploy Hooks" section
3. Click "Create Hook"
   - **Name**: `Production Deploy from production-deploy`
   - **Branch**: `production-deploy`
4. Copy the generated URL

### **Trigger Deployment:**
```bash
curl -X POST https://api.vercel.com/v1/integrations/deploy/YOUR_HOOK_URL
```

## 🏆 **Recommended Choice: Change Production Branch**

**Why this is better for you:**
- ✅ Automatic deployments
- ✅ Standard Git workflow
- ✅ No manual steps needed
- ✅ Clear production branch designation

**Go with changing the production branch to `production-deploy`** - it's the cleanest approach for your workflow.
