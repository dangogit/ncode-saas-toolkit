---
name: ncode-prd
description: Guides the user through creating a Product Requirements Document for their SaaS. Use when user says "PRD", "plan my product", "define my app", or "what should I build".
---

# nCode PRD - Product Requirements Document

Guide the user through creating a PRD specifically designed for the nCode course stack. This is NOT a generic PRD - it's tailored for solo founders building SaaS with Claude Code.

## Process

### Phase 1: Understand (ask questions, don't build yet)

Ask these questions one by one. Wait for answers.

1. **What does it do?** - "Describe your product in one sentence. Who uses it and what problem does it solve?"
2. **Who is your customer?** - "Describe one specific person (age, job, daily pain)"
3. **Why now?** - "Why hasn't this been solved already? What changed?"
4. **How do they find you?** - "How will your first 5 customers discover your product?"
5. **How do you make money?** - "Subscription? One-time? Freemium? What price?"

### Phase 2: Define MVP (ruthlessly cut)

Based on answers, propose MVP with MAXIMUM 5 features:

```markdown
## MVP Features (launch with these only)
1. [Core feature that delivers the main value]
2. [Auth - signup/login]
3. [The "aha moment" feature]
4. [Payment/upgrade flow]
5. [Settings/profile]

## V2 Features (after 10 paying users)
- [Feature 6]
- [Feature 7]

## V3 Features (after product-market fit)
- [Feature 8+]
```

**Rules:**
- If the user lists more than 5 MVP features, push back: "Which 2 can wait until V2?"
- Admin dashboard is NOT MVP. It's V2.
- Analytics is NOT MVP. PostHog basic tracking is enough.
- Mobile app is NOT MVP if they also want web. Pick one.

### Phase 3: User Flow

Draw the core user journey:
```
Landing page - Signup - Onboarding (1-3 steps) - Main dashboard - Core action - Result - Upgrade CTA
```

### Phase 4: Stack Decision

Based on the product:

**Web (default for B2B SaaS):**
- Next.js + Supabase + Vercel + Polar + Gemini (if AI feature)

**Mobile (only if product requires phone hardware):**
- Expo + Firebase + RevenueCat + Vertex AI

**Both? NO.** Pick one for MVP.

### Phase 5: Edge Cases

For EACH MVP feature, ask:
- What happens with empty state? (no data yet)
- What happens offline? (mobile only)
- What happens with bad input?
- What happens at scale? (100 users vs 10,000)

### Phase 6: Success Metrics

Define 3 metrics only:
1. **Activation metric** - % of signups that complete core action within 7 days
2. **Retention metric** - % of users returning after 30 days
3. **Revenue metric** - MRR or number of paying users

## Output

Create `PRD.md` in project root with this structure:

```markdown
# [Product Name] - PRD

## One-liner
[One sentence description]

## Target User
[Persona description]

## Problem
[Specific pain point]

## Solution
[How the product solves it]

## MVP Features
1. ...
2. ...
(max 5)

## User Flow
[Step by step]

## Stack
[Web/Mobile + specific tools]

## V2 Features
[After 10 paying users]

## Success Metrics
1. Activation: ...
2. Retention: ...
3. Revenue: ...

## Edge Cases
[Per feature]

## Pricing
[Free tier + paid tier details]
```

## Do NOT

- Write a 20-page document. Max 3 pages.
- Include technical implementation details (that's PLAN.md, not PRD)
- Skip the questions phase - always ask first
- Let the user have 10 MVP features
- Assume both web AND mobile
