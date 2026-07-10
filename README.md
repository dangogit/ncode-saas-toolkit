# ncode-saas-toolkit

Base Claude Code plugin for SaaS development. Part of the nCode course by Daniel Goldman.

## Install

```bash
claude plugin add dangogit/ncode-saas-toolkit
```

## What's Included

### Skills
- `env-management` - Local/staging/production environment patterns
- `payment-sandbox` - Test payments safely (Polar.sh, RevenueCat)
- `supabase-local-dev` - Local Supabase development workflow
- `git-for-beginners` - Simplified Git for non-technical founders
- `claude-code-intro` - Claude Code fundamentals and memory

### Agents

**Build pipeline:**
- `saas-mentor` - Business advice + course navigation, routes to specialists
- `prd-writer` - Generate PRDs from idea descriptions
- `design-director` - Generate DESIGN.md design system from the PRD
- `project-manager` - GitHub project board, issues, branches, PRs
- `code-reviewer` - Review code before shipping
- `qa-tester` - Test features and find edge cases

**GTM pipeline (idea to 1000 paying users):**
- `idea-scout` - Find and score SaaS ideas matched to your skills and niche access
- `validation-coach` - Validate before building: Mom Test interviews, smoke tests, pre-sales
- `competitor-analyst` - Map the landscape, tear down competitor pricing, find your wedge
- `pricing-strategist` - Value-based tiers, trial vs freemium, Polar/RevenueCat setup
- `landing-copywriter` - Landing page copy that converts (Hebrew or English)
- `launch-commander` - Launch-week plan: Product Hunt, Israeli + global communities
- `content-engine` - SEO + social content system, calendar, repurposing pipeline
- `outbound-closer` - First 10-100 paying customers: ICP lists, cold outreach, demos, closing
- `funnel-analyst` - PostHog instrumentation, activation metric, weekly metrics ritual
- `retention-builder` - Onboarding, churn saves, referrals, the 100-to-1000 playbook

## MCP Servers (installed by nCode installer)

The nCode installer (`danielthegoldman.com/claude-code-installer`) sets up these MCPs automatically:
- **Context7** - Look up any library/framework docs instantly
- **Playwright** - Browser testing and automation
- **Memory** - Persistent knowledge graph

Track-specific MCPs are listed in each extension's README.

## Recommended Plugins

```bash
# Superpowers - brainstorming, planning, debugging, TDD
claude plugin add superpowers

# Context7 - library docs lookup
claude plugin add context7
```

## Extensions

- `dangogit/ncode-saas-toolkit-web` - Web development track
- `dangogit/ncode-saas-toolkit-mobile` - Mobile development track
