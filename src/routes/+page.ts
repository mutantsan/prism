import { supabase } from '$lib/supabase';
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
    const { data: posts, error } = await supabase
        .from('posts')
        .select('id, title, slug, excerpt, created_at, content')
        .eq('published', true)
        .order('created_at', { ascending: false });

    if (error) console.error('Error fetching posts:', error);

    return {
        posts: posts || []
    };
};
