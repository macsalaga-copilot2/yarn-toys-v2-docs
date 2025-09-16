# 📋 Monitoring & Analytics Quick Reference

## Components Overview

### 🚨 **AlertsDashboard.tsx** (313 lines)
**Real-time system alerts with interactive management**
- Toggle: `Ctrl+Shift+A` (development only)
- Auto-refresh: 30 seconds
- Severity levels: Critical → High → Medium → Low
- Alert types: Performance, Error, Business, Security

### 📊 **Analytics.tsx** (134 lines)
**Privacy-first user behavior tracking**
- GDPR compliant with opt-in/opt-out
- Custom events, page views, conversions
- No personal data collection

### 🐛 **DebugPanel.tsx** (132 lines)  
**Development debugging interface**
- Toggle: `Ctrl+Shift+D` (development only)
- Real-time system info and performance metrics
- Environment and configuration display

### ⚡ **PerformanceDashboard.tsx** (210 lines)
**Interactive performance monitoring**
- Toggle: `Ctrl+Shift+P` (development only)
- Web Vitals: LCP, FCP, CLS, FID, TTFB
- Memory usage and network performance

### 🌐 **WebVitals.tsx** (45 lines)
**Core Web Vitals automatic tracking**
- Continuous performance metric collection
- Real-time reporting to analytics APIs

---

## API Endpoints

### Analytics APIs
- `POST /api/analytics/events` - Custom event tracking
- `POST /api/analytics/performance` - Performance metrics
- `POST /api/analytics/errors` - Error reporting

### Monitoring APIs  
- `GET /api/alerts` - Fetch system alerts
- `PATCH /api/alerts` - Create test alerts
- `PUT /api/alerts/{id}/resolve` - Resolve alerts
- `GET /api/health` - System health check

### Business APIs
- `GET /api/products` - Product catalog
- `GET /api/products/latest` - Latest products
- `GET /api/products/[slug]` - Individual product

---

## Library Functions

### Analytics (`@/lib/analytics/tracking`)
```typescript
// Event tracking
track(event: AnalyticsEvent)
trackPageView(url: string, title?: string)
trackClick(element: string, context?: string)
trackBusiness(action: string, value?: number)
trackConversion(goal: string, value?: number)

// Privacy management
setConsent(granted: boolean)
getConsent(): boolean | null
```

### Alerting (`@/lib/monitoring/alerting`)
```typescript
// Alert management
createAlert(alert: Partial<Alert>): Promise<Alert>
getAlerts(filter?: AlertFilter): Promise<Alert[]>
resolveAlert(id: string): Promise<void>
escalateAlert(id: string): Promise<void>

// Alert types and severities
AlertType: 'performance' | 'error' | 'business' | 'security'
AlertSeverity: 'critical' | 'high' | 'medium' | 'low'
```

### Error Tracking (`@/lib/monitoring/error-tracking`)
```typescript
// Error reporting
trackError(error: Error, context?: any): Promise<void>
trackUnhandledError(error: Error): Promise<void>

// Error batch processing (150 errors/batch)
flushErrorQueue(): Promise<void>
```

### Performance (`@/lib/monitoring/performance`)
```typescript
// Performance monitoring
trackWebVitals(): void
trackCustomMetric(name: string, value: number): void
getPerformanceMetrics(): PerformanceMetrics
```

---

## Development Controls

### Keyboard Shortcuts (Development Only)
- `Ctrl+Shift+A` - Toggle AlertsDashboard
- `Ctrl+Shift+D` - Toggle DebugPanel  
- `Ctrl+Shift+P` - Toggle PerformanceDashboard

### Environment Detection
Components automatically hide in production via:
- `process.env.NODE_ENV === 'production'`
- `process.env.VERCEL_ENV === 'production'`
- `window.location.hostname !== 'localhost'`

---

## Recent Updates

### ✅ **Analytics Batching Fix** (Sept 2025)
- Increased server limits: 50 → 200 errors/batch
- Client-side batching: 150 errors per batch
- Rate limiting: 100ms delays between batches
- Enhanced error recovery and logging

### ✅ **Hero Image Loading Fix** (Sept 2025)  
- Eliminated black flash during image loading
- Next.js Image placeholder optimization
- CSS anti-flash fallback rules

---

## Quick Setup

### 1. Add to Layout
```tsx
import AlertsDashboard from '@/components/AlertsDashboard';
import Analytics from '@/components/Analytics';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
        <AlertsDashboard />
      </body>
    </html>
  );
}
```

### 2. Initialize Monitoring
```tsx
// In your main component
import { initAnalytics } from '@/lib/analytics/tracking';
import { AlertingSystem } from '@/lib/monitoring/alerting';

useEffect(() => {
  initAnalytics({ 
    enableConsoleLog: true,
    respects_dnt: true 
  });
}, []);
```

### 3. Track Events
```tsx
import { track, trackClick } from '@/lib/analytics/tracking';

// Custom events
track({
  type: 'user_interaction',
  action: 'button_click',
  label: 'header_cta'
});

// Click tracking
<button onClick={() => trackClick('purchase_button', 'product_page')}>
  Buy Now
</button>
```

---

## Testing Commands

```bash
# Run monitoring tests
npm test -- __tests__/
npm test -- ErrorBoundary.test.tsx
npm test -- environment.test.ts

# Start development with monitoring
npm run dev
# Open http://localhost:3000
# Use Ctrl+Shift+A/D/P to toggle dashboards
```

---

**Full Documentation:** [monitoring-analytics-system-complete.md](./monitoring-analytics-system-complete.md)