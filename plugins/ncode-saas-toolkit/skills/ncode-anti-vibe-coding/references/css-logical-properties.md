# CSS Logical Properties - RTL Reference

Use logical properties instead of physical properties so layouts automatically adapt to RTL (Hebrew/Arabic) without extra overrides.

---

## Physical-to-Logical Property Mapping

### Margin

| Physical (LTR-only)    | Logical equivalent         | What it means           |
|------------------------|----------------------------|-------------------------|
| `margin-left`          | `margin-inline-start`      | Start of inline axis    |
| `margin-right`         | `margin-inline-end`        | End of inline axis      |
| `margin-top`           | `margin-block-start`       | Start of block axis     |
| `margin-bottom`        | `margin-block-end`         | End of block axis       |
| `margin-left` + `right`| `margin-inline`            | Both inline sides       |
| `margin-top` + `bottom`| `margin-block`             | Both block sides        |

### Padding

| Physical (LTR-only)    | Logical equivalent         |
|------------------------|----------------------------|
| `padding-left`         | `padding-inline-start`     |
| `padding-right`        | `padding-inline-end`       |
| `padding-top`          | `padding-block-start`      |
| `padding-bottom`       | `padding-block-end`        |
| `padding-left` + `right`| `padding-inline`          |
| `padding-top` + `bottom`| `padding-block`           |

### Border

| Physical (LTR-only)    | Logical equivalent              |
|------------------------|---------------------------------|
| `border-left`          | `border-inline-start`           |
| `border-right`         | `border-inline-end`             |
| `border-top`           | `border-block-start`            |
| `border-bottom`        | `border-block-end`              |
| `border-left-width`    | `border-inline-start-width`     |
| `border-right-width`   | `border-inline-end-width`       |

### Position (inset)

| Physical (LTR-only)    | Logical equivalent         |
|------------------------|----------------------------|
| `left`                 | `inset-inline-start`       |
| `right`                | `inset-inline-end`         |
| `top`                  | `inset-block-start`        |
| `bottom`               | `inset-block-end`          |

### Text Alignment

| Physical (LTR-only)    | Logical equivalent         |
|------------------------|----------------------------|
| `text-align: left`     | `text-align: start`        |
| `text-align: right`    | `text-align: end`          |

### Float

| Physical (LTR-only)    | Logical equivalent         |
|------------------------|----------------------------|
| `float: left`          | `float: inline-start`      |
| `float: right`         | `float: inline-end`        |

### Border Radius

| Physical (LTR-only)         | Logical equivalent                    |
|-----------------------------|---------------------------------------|
| `border-top-left-radius`    | `border-start-start-radius`           |
| `border-top-right-radius`   | `border-start-end-radius`             |
| `border-bottom-left-radius` | `border-end-start-radius`             |
| `border-bottom-right-radius`| `border-end-end-radius`               |

---

## Tailwind CSS Equivalents

Tailwind v3.3+ ships logical property utilities. Use these - never use the physical side classes for inline spacing.

### Margin

| Physical class | Logical class | Notes               |
|----------------|---------------|---------------------|
| `ml-*`         | `ms-*`        | margin-inline-start |
| `mr-*`         | `me-*`        | margin-inline-end   |
| `mx-*`         | `mx-*`        | unchanged (symmetric) |
| `mt-*`         | `mt-*`        | unchanged           |
| `mb-*`         | `mb-*`        | unchanged           |

### Padding

| Physical class | Logical class | Notes                |
|----------------|---------------|----------------------|
| `pl-*`         | `ps-*`        | padding-inline-start |
| `pr-*`         | `pe-*`        | padding-inline-end   |
| `px-*`         | `px-*`        | unchanged (symmetric) |
| `pt-*`         | `pt-*`        | unchanged            |
| `pb-*`         | `pb-*`        | unchanged            |

### Position

| Physical class | Logical class | Notes             |
|----------------|---------------|-------------------|
| `left-*`       | `start-*`     | inset-inline-start|
| `right-*`      | `end-*`       | inset-inline-end  |
| `top-*`        | `top-*`       | unchanged         |
| `bottom-*`     | `bottom-*`    | unchanged         |

### Text Alignment

| Physical class  | Logical class    |
|-----------------|------------------|
| `text-left`     | `text-start`     |
| `text-right`    | `text-end`       |
| `text-center`   | `text-center`    |

### Border Radius

| Physical class    | Logical class   | Corner              |
|-------------------|-----------------|---------------------|
| `rounded-l-*`     | `rounded-s-*`   | start side          |
| `rounded-r-*`     | `rounded-e-*`   | end side            |
| `rounded-tl-*`    | `rounded-ss-*`  | start-start         |
| `rounded-tr-*`    | `rounded-se-*`  | start-end           |
| `rounded-bl-*`    | `rounded-es-*`  | end-start           |
| `rounded-br-*`    | `rounded-ee-*`  | end-end             |

### Border Side

| Physical class  | Logical class   |
|-----------------|-----------------|
| `border-l-*`    | `border-s-*`    |
| `border-r-*`    | `border-e-*`    |
| `border-t-*`    | `border-t-*`    |
| `border-b-*`    | `border-b-*`    |

---

## NativeWind Equivalents

NativeWind v4+ mirrors Tailwind's logical class names. The same `ms-*`, `me-*`, `ps-*`, `pe-*`, `start-*`, `end-*`, `text-start`, `text-end`, `rounded-s-*`, `rounded-e-*`, `border-s-*`, `border-e-*` classes apply.

Key difference from web: NativeWind relies on `I18nManager.forceRTL(true)` being called at app startup (before the first render) to activate RTL. Logical classes do nothing without this step.

```ts
// App entry point - call before rendering
import { I18nManager } from 'react-native';
I18nManager.forceRTL(true);
```

After changing RTL mode, the app must be restarted (not just hot-reloaded) for the change to take effect.

---

## Hebrew Font Stack Recommendation

These fonts have full Hebrew Unicode coverage and render cleanly at screen sizes:

**Body text (preferred order):**
```css
font-family: 'Heebo', 'Assistant', 'Noto Sans Hebrew', sans-serif;
```

**Headings (preferred order):**
```css
font-family: 'Rubik', 'Secular One', 'Suez One', sans-serif;
```

**Display / decorative (use sparingly):**
```css
font-family: 'Frank Ruhl Libre', 'Varela Round', serif;
```

Always load fonts with the Hebrew subset to reduce bundle size:
- Google Fonts: append `&subset=hebrew` to the URL
- next/font/google: set `subsets: ['hebrew']`
- Expo: load only the Hebrew variant of the font file

---

## Bidi Text Quick Reference

Mixed RTL/LTR content (Hebrew page with English numbers, URLs, code) requires explicit direction control.

### Inline LTR islands inside RTL container

```html
<!-- Phone numbers -->
<span dir="ltr">+972-50-123-4567</span>

<!-- URLs -->
<span dir="ltr">https://example.com</span>

<!-- Email addresses -->
<span dir="ltr">user@example.com</span>

<!-- Code snippets inline -->
<code dir="ltr">npm install heebo</code>

<!-- Numeric values with units -->
<span dir="ltr">$1,299</span>
```

### Unicode bidi control characters (when HTML attributes are not available)

| Character | Name             | Use                                      |
|-----------|------------------|------------------------------------------|
| `‪`  | LRE              | Start LTR embedding                      |
| `‫`  | RLE              | Start RTL embedding                      |
| `‬`  | PDF              | End embedding (pair with LRE or RLE)     |
| `‏`  | RLM              | RTL mark (for punctuation direction)     |
| `‎`  | LRM              | LTR mark (for punctuation direction)     |

Prefer HTML `dir` attributes over Unicode control characters when possible - they are more readable and maintainable.

### React Native bidi handling

```tsx
// Wrap LTR content in RTL screens
<Text style={{ writingDirection: 'ltr', textAlign: 'left' }}>
  user@example.com
</Text>

// Or use a View with explicit direction
<View style={{ direction: 'ltr' }}>
  <Text>+972-50-123-4567</Text>
</View>
```

---

## Common RTL Bugs Checklist

- [ ] `flex-row-reverse` used to "fix" RTL layout - replace with `dir="rtl"` on the container
- [ ] `margin-left` hard-coded on components that need to flip - replace with `ms-*`
- [ ] `padding-right` used for icon spacing in buttons - replace with `pe-*`
- [ ] `left-0` used for absolute positioning of a drawer or tooltip - replace with `start-0`
- [ ] `rounded-l-*` used for the active tab indicator - replace with `rounded-s-*`
- [ ] `border-l-4` used as a decorative accent stripe - replace with `border-s-4`
- [ ] Arrow icons not mirrored in RTL - add `scale-x-[-1]` or use `rtl:scale-x-[-1]`
- [ ] Progress bar `width` grows from left side in RTL - use `direction: rtl` on the container
- [ ] Phone numbers or URLs displaying reversed in RTL context - wrap in `<span dir="ltr">`
