---
name: ncode-prompt-guide
description: Teaches non-developers how to write effective prompts for Claude Code. Use when user's prompts are vague, too broad, or producing bad results.
---

# Prompt Guide for Non-Developers

The user is NOT a developer. They're learning to build SaaS with Claude Code. Help them write better prompts.

## When to Activate

Activate this skill when:
- User writes a vague prompt like "make it work" or "build me an app"
- User is frustrated because results don't match expectations
- User asks "how do I ask you to do X?"
- User explicitly requests help with prompting

## The 4 Rules of Good Prompts

### 1. Be Specific, Not Vague

**Bad:** "תעשה לי אתר"
**Good:** "תבנה דף landing עם hero section שכולל כותרת, תת-כותרת, ו-CTA button. למטה 3 כרטיסים של פיצ'רים עם אייקונים"

**Bad:** "תתקן את הבאג"
**Good:** "כשאני לוחץ על כפתור Login עם Google, אני מקבל שגיאה. הנה מה שמופיע ב-console: [הדבק שגיאה]"

### 2. Give Context First, Then Task

**Bad:** "תוסיף dark mode"
**Good:** "הפרויקט שלי משתמש ב-Next.js עם shadcn/ui ו-Tailwind. אני רוצה להוסיף dark mode toggle ב-header. תשתמש ב-next-themes"

### 3. Mention Skills When Relevant

**Bad:** "תבנה את ה-DB"
**Good:** "תשתמש ב-ncode-rls-guard skill. תבנה טבלת meetings עם user_id, title, transcript, status. תוודא ש-RLS מופעל"

### 4. One Task at a Time

**Bad:** "תבנה לי auth, dashboard, payments, ו-analytics"
**Good:** "נתחיל עם auth. תחבר Google login דרך Supabase"
(after auth works: "עכשיו נעבור ל-dashboard")

## Prompt Templates for Common Tasks

### Building a new feature:
```
תשתמש ב-[skill רלוונטי].

אני רוצה להוסיף [תיאור הפיצ'ר].

דרישות:
- [דרישה 1]
- [דרישה 2]
- [דרישה 3]

לפי ה-PRD שלי (PRD.md), זה מתואר בסעיף [X].

תתחיל מ-[המסך/הקובץ הספציפי]
```

### Fixing a bug:
```
יש לי בעיה: [תיאור מה לא עובד]

מה ציפיתי שיקרה: [תיאור]
מה באמת קורה: [תיאור]

הנה השגיאה מ-console / Sentry:
[הדבק שגיאה]

תשתמש ב-superpowers:systematic-debugging skill
```

### Improving design:
```
תשתמש ב-ncode-anti-vibe-coding skill.

תסתכל על [דף/מסך ספציפי] ותשפר את העיצוב:
- האם זה נראה כמו vibe coding?
- מה לשנות כדי שייראה מקצועי?
- תציע שינויים ותבצע
```

### Before shipping:
```
תשתמש ב-ncode-shipping-checklist skill.

אני רוצה לעלות ל-production. תעבור על הצ'קליסט ותגיד לי מה עובר ומה לא
```

## What to Do When User Writes Bad Prompt

Don't just execute a vague prompt. Instead:
1. Acknowledge what they want
2. Ask 2-3 clarifying questions
3. Suggest a better-structured prompt
4. Only then proceed

Example:
User: "תעשה לי אפליקציה"
You: "בשמחה! כדי שאבנה בדיוק מה שאתה צריך, אני צריך להבין:
1. מה האפליקציה עושה? (במשפט אחד)
2. Web או Mobile?
3. יש לך PRD.md? אם כן, אקרא אותו ואתחיל משם"
