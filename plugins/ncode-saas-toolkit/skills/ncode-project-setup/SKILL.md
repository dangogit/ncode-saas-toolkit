---
name: ncode-project-setup
description: Sets up a new SaaS project with the exact nCode Golden Stack. Use when the user says "create a new project", "set up my SaaS", or "start building".
---

# nCode Project Setup

You are setting up a new SaaS project using the nCode Golden Stack. Follow this exact structure - do not deviate.

## Web Track (Next.js)

```bash
npx create-next-app@latest [project-name] --app --typescript --tailwind --eslint --src-dir --import-alias "@/*"
```

Then install in order:
1. `npx shadcn@latest init` - choose New York style, neutral colors
2. `npm install @supabase/ssr @supabase/supabase-js` - Supabase client
3. `npm install ai @ai-sdk/google` - Vercel AI SDK + Gemini
4. `npm install posthog-js` - Analytics
5. `npm install @sentry/nextjs` - Error monitoring

Create these files:
- `.env.local` from `.env.example` (create both)
- `lib/supabase/client.ts` + `lib/supabase/server.ts`
- `middleware.ts` for auth session refresh
- `app/providers.tsx` for PostHog + other providers

## Mobile Track (Expo)

```bash
npx create-expo-app@latest [project-name] --template tabs
```

Then install:
1. NativeWind + Tailwind CSS setup
2. `@react-native-firebase/app` + auth + firestore
3. `expo-router` (already in template)
4. `react-native-purchases` (RevenueCat)
5. `posthog-react-native`

## Both Tracks - Always Do

- Create `.gitignore` with node_modules, .next/.expo, .env*, .DS_Store
- Create `.env.example` with ALL required env vars as placeholders
- `git init` + first commit: "feat: initial project setup with nCode Golden Stack"
- Create `CLAUDE.md` with project-specific conventions

## Do NOT

- Do not use Pages Router (use App Router only)
- Do not install Prisma (use Supabase client directly)
- Do not use styled-components (use Tailwind/NativeWind)
- Do not create a monorepo structure unless explicitly asked
