// src/routes/blog/+page.ts
import { supabase } from '$lib/supabase';
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
    const { data: posts, error } = await supabase
        .from('posts')
        .select('id, title, content, slug, excerpt, created_at')
        .eq('published', true)
        .order('created_at', { ascending: false });

    if (error) console.error('Error fetching posts:', error);

    return {
        posts: posts || []
    };
};
