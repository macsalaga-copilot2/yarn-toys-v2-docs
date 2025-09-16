# GitHub Account Migration Guide

This document outlines the complete process of migrating a project from one GitHub account to another, including repository transfer and VS Code Copilot subscription switching.

## Overview

**Migration Details:**
- **From:** `macsalaga-copilot2/yarn-toys`
- **To:** `Macsalaga-copilot3/yarn-toys`
- **Project:** Next.js yarn toys e-commerce website
- **Goal:** Use Copilot trial from new account while preserving commit history

## Pre-Migration Situation

### Current Setup Before Migration:
```bash
# Git Configuration
user.name=Mseitech
user.email=maciej.salaga@gmail.com

# Remote Repository
remote.origin.url=git@github.com:macsalaga-copilot2/yarn-toys.git

# VS Code Copilot
Authenticated with: macsalaga-copilot2 account
```

### Account Structure:
- **Mseitech**: Original GitHub account (first ever created)
- **macsalaga-copilot2**: Current working account with active Copilot trial
- **Macsalaga-copilot3**: New target account for fresh Copilot trial

## Migration Process

### Step 1: Repository Setup on New Account

1. **Create new repository:**
   - Navigate to `https://github.com/Macsalaga-copilot3`
   - Click "New repository"
   - Repository name: `yarn-toys`
   - Visibility: Public/Private (your choice)
   - **Important:** Do NOT initialize with README (we're pushing existing code)
   - Click "Create repository"

### Step 2: Update Local Git Remote

```bash
# Navigate to project directory
cd /mnt/projekty/yarn-toys-v2

# Update remote URL to point to new repository
git remote set-url origin https://github.com/Macsalaga-copilot3/yarn-toys.git

# Verify the change
git remote -v
# Should show: 
# origin  https://github.com/Macsalaga-copilot3/yarn-toys.git (fetch)
# origin  https://github.com/Macsalaga-copilot3/yarn-toys.git (push)
```

### Step 3: Push Code to New Repository

```bash
# Push current development branch
git push -u origin layout-development

# Push main branch (if exists)
git push origin main
```

**Expected Output:**
- GitHub will process ~612 objects and ~142MB of data
- Both branches will be successfully created on new repository
- GitHub may suggest URL correction (macsalaga-copilot3 → Macsalaga-copilot3)

### Step 4: Fix URL Capitalization (if needed)

```bash
# Update to correct GitHub capitalization
git remote set-url origin https://github.com/Macsalaga-copilot3/yarn-toys.git
```

### Step 5: VS Code Copilot Account Switch

1. **Sign out from current account:**
   - Click profile icon in VS Code (bottom-left)
   - Select "Sign Out"
   - Confirm sign out from `macsalaga-copilot2`

2. **Sign in with new account:**
   - Click profile icon again
   - Select "Sign In"
   - Choose GitHub authentication
   - Sign in with `Macsalaga-copilot3` credentials
   - Grant necessary permissions

3. **Verify Copilot activation:**
   - Open Command Palette (`Ctrl+Shift+P`)
   - Type: "GitHub Copilot: Check Status"
   - Confirm active with new account

## Post-Migration Configuration

### Git Configuration Decision

**We kept the original git configuration:**
```bash
user.name=Mseitech
user.email=maciej.salaga@gmail.com
```

**Reasoning:**
- Maintains consistency with existing commit history
- `maciej.salaga@gmail.com` can be linked to new account for attribution
- No need to change local development workflow

### Email Linking (Optional)

To properly attribute commits to the new GitHub account:

1. **Add email to new account:**
   - Go to `https://github.com/Macsalaga-copilot3/settings/emails`
   - Add `maciej.salaga@gmail.com` as secondary email
   - Verify the email when prompted

2. **Benefits:**
   - Commits show proper attribution to `Macsalaga-copilot3`
   - Contribution graphs appear on new profile
   - Repository insights count contributions correctly

**Important:** Email linking does NOT affect Copilot trials or billing.

## Verification Checklist

After migration, verify these items:

- [ ] Repository accessible at `https://github.com/Macsalaga-copilot3/yarn-toys`
- [ ] Both `main` and `layout-development` branches pushed successfully
- [ ] Local git remote points to new repository
- [ ] VS Code signed in with `Macsalaga-copilot3`
- [ ] Copilot suggestions working with new account
- [ ] Commit history preserved (shows "Mseitech" as author)
- [ ] All project files and images transferred correctly

## Benefits Achieved

### ✅ **Repository Migration:**
- Project successfully moved to new GitHub account
- Complete commit history preserved
- All branches and files transferred

### ✅ **Copilot Trial Access:**
- Fresh Copilot trial available on new account
- No conflicts with previous trials
- Full access to AI coding assistance

### ✅ **Development Continuity:**
- Local development environment unchanged
- Git workflow remains the same
- No disruption to project development

## Troubleshooting

### Common Issues and Solutions:

1. **"Repository not found" error:**
   - Ensure repository is created on GitHub first
   - Verify remote URL capitalization
   - Check repository visibility settings

2. **Copilot not working after switch:**
   - Sign out and sign back in to VS Code
   - Check Copilot status in Command Palette
   - Verify account has active trial/subscription

3. **Commit attribution issues:**
   - Add email to new GitHub account settings
   - Verify email address in git config
   - Check GitHub email verification status

## Final Repository State

```bash
# Final git configuration
user.name=Mseitech
user.email=maciej.salaga@gmail.com
remote.origin.url=https://github.com/Macsalaga-copilot3/yarn-toys.git

# VS Code Copilot
Authenticated with: Macsalaga-copilot3 account
Status: Active trial

# Repository structure preserved:
yarn-toys-v2/
├── src/
│   ├── components/
│   │   └── hero/
│   │       └── NewHeroSection.tsx
│   └── ...
├── public/
│   └── images/
│       └── hero/
├── docs/
│   └── github-account-migration.md (this file)
└── ...
```

## Notes

- Migration completed successfully with zero data loss
- Development workflow remains unchanged
- Fresh Copilot trial available for continued development
- All project assets and commit history preserved

---

**Migration Date:** July 19, 2025  
**Project:** Yarn Toys E-commerce Website  
**Technology Stack:** Next.js 14, TypeScript, Tailwind CSS  
**Migration Duration:** ~30 minutes
