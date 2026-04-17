---
name: ncode-shipping-checklist
description: Pre-production checklist before deploying to Vercel/App Store. Use when user says "ready to deploy", "ship it", "go to production", or "launch".
---

# Shipping Checklist - Don't Go Live Without This

Before deploying to production, verify EVERY item. Block the deploy if critical items fail.

## Web (Next.js + Supabase + Vercel)

### Security (CRITICAL - block deploy if failing)
- [ ] RLS enabled on ALL Supabase tables (query: `SELECT tablename FROM pg_tables WHERE schemaname='public' AND rowsecurity=false`)
- [ ] No `USING (true)` on write policies
- [ ] `.env.local` in `.gitignore` (check: `git ls-files .env*`)
- [ ] No hardcoded API keys in code (search: `grep -r "sk_\|key_\|secret" --include="*.ts" --include="*.tsx"`)
- [ ] `NEXT_PUBLIC_` vars are safe to expose (anon key OK, service_role NOT OK)
- [ ] Webhook signature verification on Polar endpoint

### Environment
- [ ] All env vars set in Vercel (production AND preview)
- [ ] Supabase URL/Key match production project (not local)
- [ ] Auth redirect URLs include production domain in Supabase dashboard

### Functionality
- [ ] `npm run build` passes locally with zero errors
- [ ] Auth flow works: signup, login, logout, forgot password
- [ ] Payment flow works in sandbox: checkout, subscription active, cancel
- [ ] AI feature works with production API key
- [ ] Error boundary exists (app/error.tsx)

### Monitoring
- [ ] Sentry configured with production DSN
- [ ] Source maps uploading to Sentry
- [ ] PostHog tracking key events (signup, feature_use, subscription)

### SEO
- [ ] Meta title + description on all public pages
- [ ] OpenGraph image set
- [ ] sitemap.xml exists
- [ ] robots.txt exists

### Performance
- [ ] Images optimized (next/image, not raw img)
- [ ] No console.log in production code
- [ ] Lighthouse score > 80 on Performance + SEO

## Mobile (Expo + Firebase)

### Security (CRITICAL)
- [ ] Firebase Security Rules deployed (not default open)
- [ ] Security Rules tested with 2 different users
- [ ] No hardcoded API keys
- [ ] Content moderation active (Vertex AI safety settings)

### App Store Readiness
- [ ] Ghost user created with Pro access for Apple reviewer
- [ ] Review Notes prepared (REVIEW_NOTES.md)
- [ ] Privacy Manifest (PrivacyInfo.xcprivacy) up to date
- [ ] App icon 1024x1024
- [ ] Screenshots for all required device sizes
- [ ] Description + keywords written

### Functionality
- [ ] Works on physical device (not just simulator)
- [ ] Auth: Google sign-in + Apple sign-in (iOS requirement)
- [ ] IAP tested in sandbox
- [ ] Push notifications working
- [ ] Offline behavior graceful (no crash)

### Monitoring
- [ ] Sentry configured for React Native
- [ ] PostHog tracking
- [ ] Crash-free sessions alert set

## How to Run This Check

When the user asks to ship, run through each item:
1. Check what you can automatically (file existence, grep for keys, RLS query)
2. List items you can't check automatically (screenshots, App Store metadata)
3. Output: ✓ passing, ✗ failing, ? needs manual check
4. Block deploy recommendation if ANY critical item fails
