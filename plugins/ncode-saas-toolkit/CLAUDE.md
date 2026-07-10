# ncode-saas-toolkit

Base toolkit for SaaS development with Claude Code. Part of the nCode course ecosystem.

## Plugin Architecture

This is the base plugin. Students also install one track extension:
- `ncode-saas-toolkit-web` - Next.js + Supabase + Vercel + AI SDK + Gemini
- `ncode-saas-toolkit-mobile` - React Native + Expo + Firebase + Gemini

## Conventions

- Students are non-technical founders. Explain decisions simply.
- Always use environment variables for secrets. Never hardcode.
- Default to the "Golden Stack": Next.js + Supabase + Vercel + Polar.sh + PostHog
- When suggesting commands, prefer Claude Code skills over raw CLI commands.
- Hebrew is the primary language of course content but code and comments should be in English.
- After PRD, run design-director agent to generate DESIGN.md before building UI.
- The ncode-anti-vibe-coding skill enforces DESIGN.md tokens during all UI work.
- Platform-specific design rules live in ncode-web-design (web extension) and ncode-mobile-design (mobile extension).
- All agents respond in the language the student uses. If Hebrew, respond in Hebrew. If English, English.
- Code, comments, git commits, branch names, GitHub issues, and PR descriptions are always in English.

## Student Build Pipeline

The recommended workflow for building a new SaaS product:

0. **Idea + validation** - Use `idea-scout` to find and score ideas, `validation-coach` to validate before building, `competitor-analyst` to find the differentiation wedge
1. **PRD** - Use `prd-writer` agent or `ncode-prd` skill to create PRD.md
2. **Design** - Use `design-director` agent to create DESIGN.md from the PRD
3. **GitHub Project** - Use `project-manager` agent to create the GitHub project board and issue backlog
4. **Setup** - Use `ncode-project-setup` to scaffold the project
5. **Build** - Build features. `ncode-anti-vibe-coding` + platform design skills enforce DESIGN.md automatically
6. **Review** - Use `code-reviewer` agent (includes design quality checks)
7. **Ship** - Use `ncode-shipping-checklist` (includes RTL and design checks)

## Student GTM Pipeline (after shipping)

From live product to 1000 paying users:

1. **Price** - `pricing-strategist` designs tiers and maps them to Polar/RevenueCat
2. **Message** - `landing-copywriter` writes the landing page copy
3. **Launch** - `launch-commander` runs the launch-week plan
4. **First customers** - `outbound-closer` drives direct outreach to the first 10-100 paying
5. **Inbound engine** - `content-engine` builds the SEO + social content system
6. **Measure** - `funnel-analyst` instruments PostHog and runs the weekly metrics ritual
7. **Retain + scale** - `retention-builder` owns onboarding, churn, referrals, and the 100-to-1000 playbook

`saas-mentor` is the router: it knows the student's stage and points to the right specialist.
