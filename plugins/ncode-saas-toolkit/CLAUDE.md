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

## Student Build Pipeline

The recommended workflow for building a new SaaS product:

1. **PRD** - Use `prd-writer` agent or `ncode-prd` skill to create PRD.md
2. **Design** - Use `design-director` agent to create DESIGN.md from the PRD
3. **Setup** - Use `ncode-project-setup` to scaffold the project
4. **Build** - Build features. `ncode-anti-vibe-coding` + platform design skills enforce DESIGN.md automatically
5. **Review** - Use `code-reviewer` agent (includes design quality checks)
6. **Ship** - Use `ncode-shipping-checklist` (includes RTL and design checks)
