---
name: ncode-anti-vibe-coding
description: Prevents AI-generated look in web and mobile apps. Enforces DESIGN.md tokens if present, otherwise applies universal anti-patterns and Hebrew design defaults. Use when building UI, designing pages, or when user says "make it look professional".
---

# Anti Vibe Coding - Professional Polish Guide

Your job is to make this app look like a REAL product, not like an AI generated it in 20 minutes. Apply these rules to EVERY UI decision.

This skill operates in two modes:
- **With DESIGN.md:** Reads project-specific tokens (colors, fonts, spacing, radius, dark mode preference) and enforces them alongside all universal rules below.
- **Without DESIGN.md:** Enforces universal rules with sensible Hebrew-first defaults. Flag missing DESIGN.md to the user and suggest creating one.

If DESIGN.md exists, read it first before applying any rules. Always reconcile drift between screens and the design system.

---

## Section 1: AI Slop Detection (Instant Fails)

The following patterns are hard-banned. Remove them on sight:

- Purple/pink/cyan gradients anywhere in the UI
- Gradient buttons or gradient text (background-clip: text)
- Glassmorphism as the default card style (backdrop-filter: blur as a universal card treatment)
- Particle effects, floating orbs, or animated backgrounds
- Buzzword copy: "AI-powered", "Revolutionary", "Cutting-edge", "Seamlessly"
- Bounce/elastic easing on transitions (ease: spring, back, elastic)
- "Built with AI", "Built with Lovable", or "Made with v0" footers
- Hero-metric template (big number + small label + gradient accent color)
- Side-stripe colored borders (border-left or border-right wider than 1px used as accent decoration)
- Cute loading messages - "Herding pixels", "Teaching robots to dance", "Counting backwards from infinity"
- Em dashes (the long dash character: -) anywhere - in code, copy, UI text, or comments. Use regular dashes (-), commas, or semicolons instead
- Rainbow or multi-color schemes
- Generic stock illustrations (undraw, storyset, etc.)
- Confetti or celebration animations as the primary success feedback

---

## Section 2: Card Addiction

Cards are the lazy answer. Question every card before placing it.

- Do not wrap everything in a card. Whitespace is a valid separator.
- Never nest cards inside cards.
- Maximum 3-4 cards visible in one viewport section.
- If everything is in a card, nothing stands out. Use alternating sections, split layouts, or lists instead.
- Identical card grids (same icon + heading + text, repeated 3-6 times) = instant fail.
- Test: "Would removing this card's border change anything?" If no - remove the border.
- Prefer: alternating sections, split layouts, inline elements, definition lists, over uniform card grids.
- Card padding minimum: 24px (p-6). Card with p-4 looks cramped and cheap.
- If using shadcn Card: customize the radius and border color. Never ship with default shadcn Card styling.

If DESIGN.md specifies card styles, enforce those. If not, use subtle borders with generous padding rather than box shadows.

---

## Section 3: Icon Anti-Patterns

Icons should aid scannability, not decorate.

- Ban thick-stroked default icons: Lucide at default strokeWidth={2}, FontAwesome solid, Material filled icons.
- If using Lucide: set strokeWidth={1.5} globally via a wrapper component or Icon primitive.
- Better alternatives: Phosphor Light, Remix Line, Lucide with reduced stroke.
- Not every element needs an icon. Use icons where they help the user scan faster, not as decoration.
- Never use emoji in buttons or CTAs.
- Maximum 1 icon per button, and only when it adds meaning - not a generic sparkle or star.
- Icon size must be consistent: pick one size for nav icons, one for inline icons, one for feature icons. Do not mix randomly.
- Color: icons should inherit text color or use a muted variant. Colored icons on every feature card = visual noise.

---

## Section 4: Hebrew RTL Fundamentals (Always Enforced)

Hebrew is a right-to-left language. RTL is not an afterthought - build for it from the first line of UI code.

These rules are platform-agnostic and apply to both web and mobile:

- Document direction must be set explicitly - web: `<html lang="he" dir="rtl">`, mobile: `I18nManager.forceRTL(true)`.
- Use CSS logical properties, not physical - `margin-inline-start` not `margin-left`, `padding-inline-end` not `padding-right`. The concept applies equally to Tailwind CSS and NativeWind class names.
- Arrows and chevrons with directional meaning MUST mirror in RTL. A left-pointing arrow means "forward/next" in RTL - it should point left, not right.
- Progress bars fill right to left.
- Breadcrumb separators point left (< not >).
- Sliders and carousels: swipe direction reverses.
- Phone numbers, URLs, email addresses, and code snippets must stay LTR even inside RTL containers. Wrap them: `<span dir="ltr">`.
- Flexbox trap: `flex-row-reverse` inside an RTL context double-flips back to LTR. Never use `row-reverse` to fix RTL layout - fix the direction at the container level instead.
- Form labels are right-aligned by default in RTL.
- Table headers and cell alignment respect RTL - first column is on the right.

See `references/css-logical-properties.md` in this skill folder for a full physical-to-logical mapping table with Tailwind and NativeWind equivalents.

For platform-specific implementation (Tailwind classes, NativeWind setup, next/font loading), see ncode-web-design or ncode-mobile-design.

---

## Section 5: Hebrew Typography

Hebrew glyphs are denser than Latin. Adjust accordingly.

- Approved Hebrew font list: Heebo, Assistant, Rubik, Noto Sans Hebrew, Varela Round, Open Sans Hebrew, Secular One, Alef, Suez One, Frank Ruhl Libre, Karantina, Amatic SC (Hebrew subset), Bellefair.
- Minimum body font size: 16px.
- Line height: 1.7 for body text.
- NEVER add letter-spacing to Hebrew text - it breaks readability.
- word-spacing: 0.05em for improved readability.
- If DESIGN.md specifies fonts, use those. If no DESIGN.md, default to Heebo for body and Rubik for headings.
- Font loading is platform-specific - see ncode-web-design or ncode-mobile-design for implementation details.

---

## Section 6: Typography Anti-Patterns

- Reflex-reject fonts (overused by AI tools, never suggest): Inter, Arial, Roboto, Open Sans, Helvetica, DM Sans, Plus Jakarta Sans.
- Maximum 2 font families in the entire project.
- Maximum 2-3 font weights, used consistently - not randomly scattered.
- Body text line length: cap at 65-75 characters per line (use max-w or maxWidth).
- Clear hierarchy: minimum 1.25x ratio between adjacent type scale steps.
- Never set font-weight: 400 for headings - use 600 or 700. Thin headings look unfinished.
- Never mix Hebrew and Latin at the same weight - Hebrew 400 looks heavier than Latin 400. Compensate with relative weight adjustments.
- If DESIGN.md specifies fonts, enforce those even if they are on the reject list (client brand decisions override defaults).

---

## Section 6b: Spacing and Layout Fundamentals

Tight spacing is the single most common reason a UI looks amateurish. AI models default to cramped layouts.

- Section padding on web: minimum py-24 (96px). py-12 or py-16 looks like a tutorial screenshot, not a product.
- Container max-width: 1200px on web. Full-width text blocks are unreadable.
- Between heading and body content: minimum mb-6 (24px).
- Between cards in a grid: minimum gap-6 (24px). gap-2 or gap-4 makes cards feel claustrophobic.
- Mobile screen padding: minimum px-4 (16px) on both sides.
- Touch targets on mobile: minimum 44x44px for any tappable element. Smaller targets fail usability.
- Respect safe areas on mobile - bottom tab bars and top content must account for notch and home indicator.
- If DESIGN.md specifies spacing tokens, use those. Never override design system spacing with ad-hoc values.

---

## Section 7: Color Rules

- 80% of the UI should be neutral tones (whites, grays, off-whites, dark neutrals).
- Never use pure #000000 or #ffffff - tint neutrals slightly toward the brand hue.
- ONE accent color for CTAs and key actions. Two accents maximum, and only if DESIGN.md defines a secondary.
- If no DESIGN.md, suggest safe accents: deep blue (#1a365d), warm orange (#c05621), forest green (#276749), coral (#c53030), amber (#b45309).
- No rainbow or multi-color schemes.
- No purple as primary accent - it is the AI default and signals zero design effort.
- Error states: use a muted red, not a bright #ef4444 - it screams and draws focus away from the form.
- Success states: use a muted green (#276749 range), not a neon #22c55e.
- Border colors: use a very subtle neutral (5-8% opacity black, or a light gray like #e5e7eb). Borders should be felt, not seen.
- If DESIGN.md specifies a full color palette with semantic tokens (background, surface, border, text, accent, error), always defer to those tokens.

---

## Section 8: Dark Mode Principles

- If DESIGN.md specifies dark mode as default, build dark-first.
- Dark mode neutrals: invert lightness but keep the brand hue tint (warm dark, not pure black).
- Never use pure #000000 as a dark background - use #0a0a0a or a tinted dark like #0f172a or #1a1a2e.
- Accent color stays the same in both modes, or slightly increase lightness for dark mode visibility.
- Surface elevation in dark mode: use progressively lighter backgrounds per elevation level, NOT deeper shadows.
- Cards in dark mode: subtle lighter background (#1e1e2e) with a subtle border (#2e2e3e), not box shadows.
- Text in dark mode: never pure #ffffff - use #f0f0f0 or a tinted light.
- Implementation details are platform-specific - see ncode-web-design or ncode-mobile-design.

---

## Section 9: The Sniff Test

Before presenting any UI work, run through this checklist:

1. "Could someone guess this was AI-generated in 20 minutes?" If yes - keep polishing.
2. "Does this look like every other SaaS landing page or mobile app?" If yes - it needs a point of view. Check DESIGN.md for a unique direction.
3. "If I removed all the card borders, would the layout still make sense?" If no - the hierarchy depends on decoration, not content. Fix the content hierarchy first.
4. "Is there any purple, gradient, glassmorphism, or bounce animation?" If yes - remove it.
5. "Are there any buzzwords in the copy?" Scan for: AI-powered, Revolutionary, Cutting-edge, Seamlessly, Next-generation, Game-changer. Replace with specific, concrete language.
6. "Do the spacing and font sizes feel like a professional product or a student project?" Section padding should feel generous. Body text should be at least 16px. Headings should have real visual weight.

If DESIGN.md exists, also ask:
- "Does this screen follow the design system, or has it drifted from the tokens?" Fix drift before shipping.
- "Are the fonts, colors, and spacing from DESIGN.md applied consistently across all screens?" If not - apply them now.
- "Does any new component introduce colors, fonts, or radii not defined in DESIGN.md?" If yes - either add them to DESIGN.md or use existing tokens.

Only ship when ALL sniff test questions pass. Polish is not optional.
