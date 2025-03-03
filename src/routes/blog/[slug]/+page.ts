// src/routes/blog/[slug]/+page.ts
import { supabase } from '$lib/supabase';
import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ params }) => {
    const { slug } = params;

    const { data: post, error: postError } = await supabase
        .from('posts')
        .select('*')
        .eq('slug', slug)
        .eq('published', true)
        .single();

    if (postError || !post) {
        throw error(404, 'Post not found');
    }

    return {
        post
    };
};
