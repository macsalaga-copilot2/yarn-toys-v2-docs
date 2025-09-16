# 🔄 CI/CD Pipeline Documentation

## Overview

This document describes the comprehensive CI/CD pipeline for Yarn Toys V2, featuring advanced deployment strategies, monitoring, and rollback capabilities.

## Pipeline Architecture

### 🚀 Main CI/CD Pipeline (`production-deployment.yml`)
- **Triggers**: Push to `main`, PRs, manual dispatch
- **Features**: Change detection, security audits, environment-specific deployments
- **Environments**: Preview, staging, production

### 🎭 Staging Pipeline (`staging-deployment.yml`)
- **Triggers**: Push to `develop`, manual dispatch
- **Purpose**: Pre-production testing and validation
- **Features**: Staging-specific configuration testing

### 📊 Monitoring & Rollback (`deployment-monitoring.yml`)
- **Triggers**: Post-deployment, manual dispatch
- **Features**: Health monitoring, automatic rollback, reporting

## Workflow Strategies

### 🔍 Change Detection Strategy
The pipeline intelligently detects changes and adjusts deployment strategies:

```yaml
Code Changes: src/**, *.ts, *.js, package*.json
Config Changes: next.config.*, vercel*.json, .env*
Content Changes: scripts/content-*, sanity.config.ts
```

**Deployment Decision Matrix:**
- Code + Config changes → Full deployment
- Code only → Standard deployment
- Config only → Configuration update
- No significant changes → Skip deployment

### 🌊 Branch-Based Deployment Flow

```
develop → Staging Environment
   ↓
main → Production Environment
   ↓
feature/* → Preview Deployments
```

## Environment-Specific Features

### 📋 Preview Deployments
- **URL**: Auto-generated Vercel URLs
- **Features**: Debug mode, no caching, preview mode enabled
- **Testing**: Basic functionality and security headers
- **PR Comments**: Automatic deployment notifications

### 🎭 Staging Deployments  
- **URL**: `https://yarn-toys-staging.vercel.app`
- **Features**: Production-like but with debug mode
- **Testing**: Comprehensive validation and performance checks
- **Monitoring**: 10-minute health check intervals

### 🏭 Production Deployments
- **URL**: `https://yarn-toys.vercel.app`
- **Features**: Full security, optimized caching, analytics
- **Testing**: Smoke tests, security validation, performance monitoring
- **Monitoring**: 5-minute health check intervals

## Security & Quality Gates

### 🔒 Security Audits
```bash
# Dependency vulnerability scanning
npm audit --audit-level=moderate --production

# License compliance checking  
npx license-checker --onlyAllow 'MIT;Apache-2.0;BSD;ISC;CC0-1.0;Unlicense'

# Security headers validation
grep -E "(Content-Security-Policy|X-Frame-Options)" src/lib/security-middleware.ts
```

### 📊 Quality Checks
- **TypeScript**: `tsc --noEmit`
- **Linting**: `npm run lint`
- **Build Validation**: Multi-environment builds
- **Content Health**: Sanity CMS validation

## Deployment Testing

### 🧪 Automated Testing Suite
Each deployment undergoes comprehensive testing:

1. **Connectivity Test**: HTTP status validation
2. **API Health**: `/api/health` endpoint verification
3. **Security Headers**: CSP, X-Frame-Options, etc.
4. **Performance**: Response time measurement (< 3s target)
5. **Environment Validation**: Environment-specific configurations

### 📊 Health Check Monitoring
```json
{
  "connectivity": {"status": "✅ PASS", "duration": "250ms"},
  "api_health": {"status": "✅ PASS", "details": "Status: healthy"},
  "security_headers": {"status": "✅ PASS", "details": "Found 3/3 headers"},
  "performance": {"status": "✅ PASS", "duration": "1200ms"}
}
```

## Monitoring & Alerting

### 📈 Deployment Monitoring
- **Health Checks**: Continuous monitoring post-deployment
- **Performance Tracking**: Response time measurement and trending
- **Security Validation**: Headers and configuration verification
- **Environment Consistency**: Cross-environment comparison

### 🚨 Alerting Strategy
```
Critical Failures → Immediate notification + Auto-rollback
Performance Degradation → Warning alerts
Security Issues → Security team notification
Configuration Drift → DevOps team alert
```

## Rollback Procedures

### 🔄 Automatic Rollback Triggers
- Health check failures (2+ consecutive failures)
- Performance degradation (> 5s response time)
- Critical security header missing
- API endpoint failures

### 🎯 Manual Rollback Process
```bash
# Via GitHub Actions (Manual Dispatch)
Environment: production
Action: rollback  
Rollback URL: https://yarn-toys-abc123.vercel.app

# Via Vercel CLI
vercel promote https://yarn-toys-abc123.vercel.app --scope=team
```

### ✅ Post-Rollback Validation
1. Wait 60s for propagation
2. Health check validation
3. Performance verification
4. Security header confirmation

## Performance Benchmarks

### 📊 Performance Targets
| Environment | Response Time | Build Time | Bundle Size |
|------------|---------------|------------|-------------|
| Development | < 1s | < 30s | N/A |
| Preview | < 2s | < 45s | < 200kB |
| Staging | < 2s | < 60s | < 180kB |
| Production | < 3s | < 120s | < 171kB |

### 🎯 Quality Gates
- **Security Audit**: 0 high/critical vulnerabilities
- **Type Safety**: 0 TypeScript errors
- **Code Quality**: ESLint score > 90%
- **Content Health**: Score > 85/100

## Advanced Features

### 🎯 Feature Flag Integration
```typescript
// Environment-specific feature flags
features: {
  analytics: isProduction,
  debugging: isDevelopment || isStaging,
  previewMode: !isProduction,
  errorReporting: isProduction || isStaging
}
```

### 🔍 A/B Testing Support
- Preview deployments for feature testing
- Environment-specific configurations
- Performance comparison across deployments

### 📊 Deployment Analytics
- Deployment frequency tracking
- Success rate monitoring  
- Performance trend analysis
- Security compliance scoring

## Troubleshooting Guide

### 🔧 Common Issues

**Build Failures**
```bash
# Check environment variables
npm run env:validate

# Validate configurations
./scripts/validate-environments.sh all

# Test deployment locally
npm run deploy:validate
```

**Deployment Failures**
```bash
# Check Vercel logs
vercel logs --follow

# Validate deployment health
npm run deploy:health

# Run comprehensive tests
npm run deploy:test
```

**Performance Issues**
```bash
# Monitor deployment health
# GitHub Actions → Deployment Monitoring workflow

# Check response times
curl -w "@curl-format.txt" -s -o /dev/null https://yarn-toys.vercel.app

# Analyze bundle size
npm run analyze
```

### 🆘 Emergency Procedures

**Critical Production Issue**
1. **Immediate**: Trigger manual rollback via GitHub Actions
2. **Communication**: Alert stakeholders via configured channels
3. **Investigation**: Review deployment logs and health reports
4. **Resolution**: Fix issues on develop branch, deploy via staging
5. **Prevention**: Update monitoring and add safeguards

## Manual Operations

### 🎮 GitHub Actions Manual Dispatch

**Production Deployment**
```
Workflow: Advanced CI/CD Pipeline
Environment: production
Skip Tests: false (recommended)
Force Deploy: false (recommended)
```

**Staging Deployment**
```
Workflow: Staging Deployment Pipeline
Force Deploy: false
```

**Health Monitoring**
```
Workflow: Deployment Monitoring & Rollback
Environment: production
Action: monitor
```

### 📱 Package.json Scripts
```bash
# Environment validation
npm run env:validate
npm run env:test-all

# Deployment testing
npm run deploy:test
npm run deploy:validate

# Health monitoring
npm run deploy:health
```

## Integration Points

### 🔗 External Services
- **Vercel**: Deployment platform and hosting
- **Sanity**: CMS and content validation
- **GitHub**: Version control and CI/CD orchestration
- **npm**: Package registry and dependency management

### 📊 Monitoring Integration
- **GitHub Actions**: Deployment orchestration and monitoring
- **Vercel Analytics**: Performance and usage metrics
- **Custom Health Endpoints**: Application-specific monitoring

---

## 📞 Support & Escalation

**Pipeline Issues**: Check GitHub Actions logs and deployment artifacts
**Performance Problems**: Review deployment reports and health check results  
**Security Concerns**: Validate security configurations and headers
**Emergency Rollback**: Use GitHub Actions manual dispatch with rollback action

For detailed troubleshooting, consult deployment logs and health check artifacts generated by each pipeline run.
