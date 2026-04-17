---
name: ncode-anti-vibe-coding
description: Prevents AI-generated look in web and mobile apps. Use when building UI, designing pages, or when user says "make it look professional" or "not like AI built it".
---

# Anti Vibe Coding - Professional Polish Guide

Your job is to make this app look like a REAL product, not like an AI generated it in 20 minutes. Apply these rules to EVERY UI decision.

## Red Flags to Remove (Web + Mobile)

Check for and eliminate:
- [ ] Purple/pink gradients anywhere
- [ ] Default Inter/Geist/system fonts with no customization
- [ ] Emoji in buttons or CTAs
- [ ] "AI-powered", "Revolutionary", "Cutting-edge", "Seamlessly" in copy
- [ ] Rainbow color schemes
- [ ] "Built with AI" or "Made with Lovable" footer
- [ ] Particle effects, floating orbs, animated backgrounds
- [ ] Generic stock illustrations (undraw, etc.)
- [ ] More than 2 font weights used inconsistently

## Typography

**Web (Next.js):**
- Pick ONE heading font + ONE body font. Not Inter.
- Good options: DM Sans, Space Grotesk, Satoshi, Plus Jakarta Sans
- Import via `next/font/google` - never CDN link
- Set clear hierarchy: H1 much larger than H2, H2 much larger than body

**Mobile (Expo/NativeWind):**
- Use system fonts (San Francisco on iOS, Roboto on Android) - they ARE professional
- If custom font needed: expo-font with one family only
- Scale: 14px body, 18px subtitle, 24px title, 32px hero

## Colors

- Neutral dominant: 80% of your UI should be grayscale (white, gray, black)
- ONE accent color (not purple, not blue-purple gradient)
- Good accents: deep blue (#1a365d), warm orange (#c05621), forest green (#276749), coral (#c53030)
- Dark mode: invert neutrals, keep accent

## Spacing (Web)

- Section padding: py-24 or py-32 minimum (not py-8 or py-12)
- Container max-width: 1200px (not full-width)
- Card padding: p-6 minimum
- Between heading and content: mb-6 minimum

## Spacing (Mobile)

- Screen padding: px-4 (16px) minimum
- Between cards: gap-4 (16px)
- Bottom tab bar: respect safe area
- Touch targets: minimum 44x44px

## Content Rules

- Write what the product DOES, not buzzwords
- Bad: "Revolutionize your workflow with AI-powered intelligence"
- Good: "Upload a recording, get a summary in 30 seconds"
- Use specific numbers when possible
- Write for humans, not for SEO robots

## shadcn/ui Customization (Web)

- Change the default radius in `components.json`
- Customize at least: primary color, card radius, button padding
- Don't use every component from the library - pick 5-7 and be consistent

## NativeWind Customization (Mobile)

- Extend tailwind.config.js with custom colors matching your brand
- Don't use default blue-500 for primary - set your own
- Consistent border radius across all cards/buttons

## Before Showing to Users

Ask yourself: "If I saw this for the first time, would I think a person designed it or a machine generated it?" If machine - keep polishing.
