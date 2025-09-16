# 🌿 Git Workflow Guide: Professional Version Control

> **📋 Project Context:** See [Project Progress Tracker](./project-progress-tracker.md) for current development status and milestones.

## 🎯 **Overview: Git Strategy for This Project**

This guide covers the Git workflow we've established for the Yarn Toys project, including branching strategies, commit conventions, and release management.

### 🏆 **Current Git Status**
- **Main Branch:** `sanity-studio-setup` (development branch)
- **Latest Tag:** `v2.1.0-professional-dev` 
- **Repository:** `macsalaga-copilot2/yarn-toys`
- **Sync Status:** ✅ All commits pushed to GitHub

---

## 📚 **Git Fundamentals for This Project**

### 🔄 **Branch Strategy**

#### Main Development Branch
```bash
# We're working on the main development branch
git branch
# * sanity-studio-setup  ← Current active branch
```

#### Why This Branch Structure?
- **`sanity-studio-setup`** - Main development branch with all current work
- **Future:** Will create feature branches when needed
- **Future:** Will have `main` branch for production releases

### 🏷️ **Tagging Strategy**

We use semantic versioning with descriptive tags:

```bash
# Current tags in the project
v1.0-layout-architecture     # First major milestone
v2.1.0-professional-dev      # Latest: Professional development standards
```

#### Tag Naming Convention:
- **Major milestones:** `v1.0-description`
- **Minor features:** `v1.1-description`  
- **Patches/fixes:** `v1.1.1-description`
- **Development phases:** `v2.1.0-professional-dev`

---

## 🛠️ **Daily Git Workflow**

### 1. **Starting Your Work Day**

```bash
# Check current status
git status

# Pull latest changes (if working with others)
git pull origin sanity-studio-setup

# Check what branch you're on
git branch
```

### 2. **During Development**

#### Small Changes (Every 30-60 minutes):
```bash
# Check what files changed
git status

# Add specific files
git add src/components/ProductCard.tsx
# OR add all changes
git add .

# Commit with descriptive message
git commit -m "feat: add error boundary to ProductCard component"
```

#### Larger Features (End of day):
```bash
# Add all changes
git add .

# Commit with detailed message
git commit -m "feat: implement complete error boundary system

- Add ErrorBoundary wrapper component
- Update ProductCard with error handling
- Add error fallback UI components
- Update tests for error scenarios"
```

### 3. **End of Work Session**

```bash
# Push your commits to GitHub
git push origin sanity-studio-setup

# If you added a tag
git push origin --tags
```

---

## 📝 **Commit Message Conventions**

### Format:
```
type(scope): description

[optional body]
[optional footer]
```

### Types We Use:
- **`feat:`** - New features
- **`fix:`** - Bug fixes  
- **`docs:`** - Documentation changes
- **`style:`** - Code style changes (formatting, etc)
- **`refactor:`** - Code refactoring
- **`test:`** - Adding or updating tests
- **`chore:`** - Maintenance tasks

### Examples from Our Project:
```bash
# ✅ Good commit messages
git commit -m "feat: replace img tags with Next.js Image components"
git commit -m "fix: resolve unused variables in ChatWidget"
git commit -m "docs: add comprehensive development roadmap"
git commit -m "refactor: improve TypeScript types in layout components"

# ❌ Avoid these
git commit -m "fixed stuff"
git commit -m "updates"
git commit -m "work in progress"
```

---

## 🏷️ **Working with Tags**

### Creating Tags for Milestones

```bash
# Create a tag for a major achievement
git tag -a v2.2.0-error-boundaries -m "Add comprehensive error boundary system"

# Push the tag to GitHub
git push origin --tags

# List all tags
git tag -l
```

### Tag Naming for This Project:
- **Layout Phase:** `v1.0-layout-architecture` ✅
- **Professional Dev:** `v2.1.0-professional-dev` ✅  
- **Error Boundaries:** `v2.2.0-error-boundaries` (upcoming)
- **Environment Config:** `v2.3.0-env-config` (upcoming)
- **Production Ready:** `v3.0.0-production` (future)

---

## 🔍 **Useful Git Commands for Daily Work**

### Checking Status & History
```bash
# See what files are changed
git status

# See recent commits
git log --oneline -10

# See changes in files
git diff

# See changes for specific file
git diff src/components/ProductCard.tsx
```

### Undoing Changes
```bash
# Undo changes to a file (before git add)
git checkout -- src/components/ProductCard.tsx

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (lose changes) - BE CAREFUL!
git reset --hard HEAD~1
```

### Stashing Work
```bash
# Save current work temporarily
git stash

# Get back to your work
git stash pop

# List stashed changes
git stash list
```

---

## 🚀 **Release Workflow**

### When You Complete a Major Feature:

#### 1. **Ensure Everything is Clean**
```bash
# Run all checks
npm run lint
npm run test
npm run build

# All should pass before creating release
```

#### 2. **Create Release Commit**
```bash
git add .
git commit -m "feat: complete error boundary implementation

- All components wrapped with error boundaries
- Custom error fallback components created
- Error logging system implemented
- Tests updated for error scenarios
- Documentation updated

Resolves: Error handling milestone
Next: Environment configuration"
```

#### 3. **Create Release Tag**
```bash
git tag -a v2.2.0-error-boundaries -m "Complete error boundary system implementation"
```

#### 4. **Push Everything**
```bash
git push origin sanity-studio-setup
git push origin --tags
```

---

## 🎯 **Branching Strategy (Future)**

### When to Create Feature Branches:

```bash
# For major new features
git checkout -b feature/shopping-cart
git checkout -b feature/user-authentication
git checkout -b feature/payment-integration

# For bug fixes
git checkout -b fix/mobile-layout-issue
git checkout -b fix/image-loading-bug

# For experiments
git checkout -b experiment/new-ui-design
```

### Merging Back:
```bash
# Switch back to main development branch
git checkout sanity-studio-setup

# Merge your feature
git merge feature/shopping-cart

# Clean up
git branch -d feature/shopping-cart
```

---

## 🛡️ **Best Practices for This Project**

### ✅ **Do This:**
- Commit frequently (every 30-60 minutes)
- Write descriptive commit messages
- Test before committing (`npm run lint && npm run test`)
- Push to GitHub regularly (at least daily)
- Tag major milestones
- Keep commits focused (one feature/fix per commit)

### ❌ **Avoid This:**
- Large commits with multiple unrelated changes
- Committing broken code
- Vague commit messages ("fixed stuff", "updates")
- Forgetting to push for days
- Working directly on main/master branch (future)

---

## 🔧 **Git Configuration**

### Set Up Your Git Identity:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Useful Aliases:
```bash
# Add helpful shortcuts
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit

# Now you can use:
git st    # instead of git status
git co    # instead of git checkout
```

---

## 📊 **Project-Specific Git Workflow**

### Current Development Cycle:

#### Phase 1: Daily Development
```bash
git status                           # Check current state
git add .                           # Stage changes
git commit -m "feat: implement X"  # Commit with message
npm run lint && npm run test        # Verify quality
git push origin sanity-studio-setup # Push to GitHub
```

#### Phase 2: Milestone Completion
```bash
git add .
git commit -m "feat: complete milestone X

- Feature A implemented
- Feature B tested
- Documentation updated
- All tests passing"

git tag -a v2.X.0-milestone-name -m "Milestone description"
git push origin sanity-studio-setup
git push origin --tags
```

#### Phase 3: Status Check
```bash
git log --oneline -5        # See recent work
git tag -l                  # See all milestones
git status                  # Ensure clean state
```

---

## 🎯 **Quick Reference: Essential Commands**

### Daily Commands:
```bash
git status              # What's changed?
git add .              # Stage all changes
git commit -m "msg"    # Commit changes
git push origin sanity-studio-setup  # Push to GitHub
```

### Weekly Commands:
```bash
git log --oneline -10  # See recent work
git tag -l             # See milestones
npm run lint           # Check code quality
npm run test           # Run tests
```

### Milestone Commands:
```bash
git tag -a v2.X.0-name -m "Description"  # Create milestone tag
git push origin --tags                   # Push tags to GitHub
```

---

## 🏆 **Success Metrics**

You're following good Git practices when:
- ✅ You commit at least once per work session
- ✅ Your commit messages clearly describe what changed
- ✅ You push to GitHub regularly (daily)
- ✅ You tag major achievements
- ✅ You can easily see your progress with `git log`
- ✅ You never lose work due to Git issues

**Remember:** Git is your safety net and progress tracker. Use it frequently and descriptively! 🚀
