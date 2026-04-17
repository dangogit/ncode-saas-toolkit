---
name: ncode-rls-guard
description: Enforces Row Level Security on every Supabase table and Firebase Security Rules on every collection. Activates automatically when creating tables or collections.
---

# RLS Guard - Security by Default

EVERY time you create a database table (Supabase) or collection (Firebase), you MUST apply security rules. No exceptions.

## Supabase (Web Track)

### On CREATE TABLE - always add:

```sql
-- 1. Enable RLS
ALTER TABLE [table_name] ENABLE ROW LEVEL SECURITY;

-- 2. Default policy: owner-only access
CREATE POLICY "Users access own records" ON [table_name]
  FOR ALL USING (auth.uid() = user_id);
```

### Common patterns:

**User's own data (meetings, stories, leads):**
```sql
USING (auth.uid() = user_id)
```

**Shared team data:**
```sql
USING (
  EXISTS (
    SELECT 1 FROM team_members
    WHERE team_members.team_id = [table].team_id
    AND team_members.user_id = auth.uid()
  )
)
```

**Public read, owner write:**
```sql
CREATE POLICY "Public read" ON [table] FOR SELECT USING (true);
CREATE POLICY "Owner write" ON [table] FOR INSERT USING (auth.uid() = user_id);
```

### NEVER do:
- `USING (true)` on INSERT/UPDATE/DELETE (allows anyone to write)
- Forget RLS on a new table (it's OPEN by default)
- Use service_role key on client side

### After creating tables, always verify:
```sql
SELECT tablename, rowsecurity FROM pg_tables
WHERE schemaname = 'public' AND rowsecurity = false;
```
If any rows returned - those tables are OPEN. Fix immediately.

## Firebase (Mobile Track)

### On new collection - always add to firestore.rules:

```javascript
match /[collection]/{docId} {
  // Only authenticated users
  allow read: if request.auth != null && resource.data.userId == request.auth.uid;
  allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
  allow update, delete: if request.auth != null && resource.data.userId == request.auth.uid;
}
```

### Validation rules (always add):
```javascript
allow create: if
  request.resource.data.userId == request.auth.uid &&
  request.resource.data.keys().hasAll(['userId', 'createdAt']) &&
  request.resource.data.createdAt == request.time;
```

### Storage rules:
```javascript
match /users/{userId}/{allPaths=**} {
  allow read, write: if request.auth != null && request.auth.uid == userId;
}
```

### NEVER do:
- `allow read, write: if true;` (even for testing)
- Leave default rules that allow all access
- Skip validation on create/update

## Automatic Behavior

When the user asks to create a table/collection, ALWAYS:
1. Create the table/collection
2. Add RLS/Security Rules
3. Tell the user what policies you added and why
4. Warn if any existing tables don't have RLS
