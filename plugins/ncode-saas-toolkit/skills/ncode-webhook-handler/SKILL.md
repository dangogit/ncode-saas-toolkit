---
name: ncode-webhook-handler
description: Creates production-ready webhook handlers for Polar, RevenueCat, or any payment/event provider. Use when user says "add webhook", "connect payments", "handle subscription events".
---

# Webhook Handler Template

When building webhook endpoints, ALWAYS follow this pattern. Webhooks that skip steps = broken payments.

## The 5-Step Pattern (applies to ALL providers)

```typescript
// app/api/webhooks/[provider]/route.ts

export async function POST(req: Request) {
  // 1. VERIFY SIGNATURE (never skip)
  const body = await req.text();
  const signature = req.headers.get('webhook-signature');
  if (!verifySignature(body, signature, process.env.WEBHOOK_SECRET)) {
    return new Response('Invalid signature', { status: 401 });
  }

  // 2. PARSE EVENT
  const event = JSON.parse(body);

  // 3. IDEMPOTENCY CHECK (prevent double-processing)
  const eventId = event.id || req.headers.get('webhook-id');
  const alreadyProcessed = await checkIdempotency(eventId);
  if (alreadyProcessed) {
    return new Response('Already processed', { status: 200 });
  }

  // 4. HANDLE EVENT (business logic)
  try {
    await handleEvent(event);
    await markProcessed(eventId);
  } catch (error) {
    console.error('Webhook processing failed:', error);
    // Return 200 anyway to prevent retry storms
    // Log to Sentry for investigation
    Sentry.captureException(error, { extra: { event } });
  }

  // 5. RETURN 200 (always, even on error)
  return new Response('OK', { status: 200 });
}
```

## Polar.sh (Web Track)

```typescript
import crypto from 'crypto';

function verifyPolarSignature(body: string, signature: string | null, secret: string): boolean {
  if (!signature) return false;
  const expected = crypto.createHmac('sha256', secret).update(body).digest('hex');
  return crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));
}

// Events to handle:
// subscription.created - INSERT/UPDATE subscription in DB, set status='active'
// subscription.updated - UPDATE subscription status
// subscription.cancelled - UPDATE status='cancelled', keep access until period_end
// subscription.revoked - UPDATE status='expired', revoke access immediately
```

## RevenueCat (Mobile Track)

```typescript
// RevenueCat sends to your Cloud Function or API endpoint

function verifyRevenueCatSignature(body: string, signature: string | null, secret: string): boolean {
  if (!signature) return false;
  // RevenueCat uses Bearer token auth, not HMAC
  return signature === `Bearer ${secret}`;
}

// Events to handle:
// INITIAL_PURCHASE - Grant entitlement
// RENEWAL - Extend entitlement
// CANCELLATION - Mark cancelled (still active until expiry)
// EXPIRATION - Revoke entitlement
// BILLING_ISSUE - Show "update payment" banner
```

## Subscription States to Handle

| State | User experience | DB status |
|-------|----------------|-----------|
| Active | Full access | `active` |
| Trial | Full access | `trial` |
| Past due | Access + warning banner | `past_due` |
| Cancelled | Access until period end | `cancelled` |
| Expired | No access, show upgrade | `expired` |

## Idempotency (Upstash Redis)

```typescript
import { Redis } from '@upstash/redis';
const redis = new Redis({ url: process.env.UPSTASH_URL, token: process.env.UPSTASH_TOKEN });

async function checkIdempotency(eventId: string): Promise<boolean> {
  const exists = await redis.get(`webhook:${eventId}`);
  return !!exists;
}

async function markProcessed(eventId: string): Promise<void> {
  await redis.set(`webhook:${eventId}`, '1', { ex: 86400 }); // 24h TTL
}
```

## Common Mistakes to Prevent

1. **Returning 500 on error** - Provider retries endlessly. Always return 200, log to Sentry
2. **No signature verification** - Anyone can POST fake events to your endpoint
3. **No idempotency** - Network retry = double charge or double grant
4. **Trusting client-side** - Never check payment status from frontend. Always from webhook
5. **Not handling all states** - "cancelled" != "expired". User still has access until period end
