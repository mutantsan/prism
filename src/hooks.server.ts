import type { Handle } from '@sveltejs/kit';
import { paraglideMiddleware } from '$lib/paraglide/server';

export const handle: Handle = async ({ event, resolve }) => {
    // Skip paraglide middleware for the email API endpoint
    if (event.url.pathname === '/api/email' && event.request.method === 'POST') {
        return resolve(event);
    }

    // Apply paraglide middleware for all other requests
    return paraglideMiddleware(event.request, ({ locale }) => {
        return resolve(event, {
            transformPageChunk: ({ html }) => html.replace('%lang%', locale)
        });
    });
};
