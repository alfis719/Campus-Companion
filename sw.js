/* ============================================================
   Campus Companion – Service Worker
   Network-first strategy for always-fresh content
   ============================================================ */

const CACHE_VERSION = 'v3'; // ⚠️ BUMP THIS every time you update code
const CACHE_NAME = 'campus-companion-' + CACHE_VERSION;

// Install: activate immediately, don't wait
self.addEventListener('install', event => {
  self.skipWaiting();
});

// Activate: delete ALL old caches, take control of pages
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys()
      .then(keys => Promise.all(
        keys
          .filter(k => k !== CACHE_NAME)
          .map(k => caches.delete(k))
      ))
      .then(() => self.clients.claim())
  );
});

// Fetch: network-first for HTML, cache-first for static assets
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // Skip API calls (Supabase, etc.) entirely — never cache these
  if (url.hostname.includes('supabase') || url.hostname.includes('vercel')) {
    return;
  }

  // Skip non-GET requests
  if (event.request.method !== 'GET') return;

  // Network-first for HTML (always try to fetch fresh)
  if (
    event.request.mode === 'navigate' ||
    url.pathname.endsWith('.html') ||
    url.pathname === '/'
  ) {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          // Only cache successful responses
          if (response.status === 200) {
            const clone = response.clone();
            caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
          }
          return response;
        })
        .catch(() =>
          caches.match(event.request).then(
            cached => cached || caches.match('/index.html')
          )
        )
    );
    return;
  }

  // Cache-first for static assets (icons, manifest, etc.)
  event.respondWith(
    caches.match(event.request).then(cached => {
      if (cached) return cached;
      return fetch(event.request).then(response => {
        if (response.status === 200 && response.type === 'basic') {
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
        }
        return response;
      });
    })
  );
});
