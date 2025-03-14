import { supabase } from '$lib/supabase';
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
    // First try to fetch without any filters to check if we can access the table at all
    const { data: allPosts, error: initialError } = await supabase
        .from('posts')
        .select('*');

    if (initialError) {
        console.error('Error accessing posts table:', initialError);
        return { posts: [] };
    }

    console.log('Can access posts table, all posts:', allPosts);

    // Now try with filters to debug policy issues
    const { data: posts, error: errors } = await supabase
        .from('posts')
        .select('*')
        .eq('status', 'published')
        .order('created_at', { ascending: false });

    if (errors) {
        console.error('Error fetching filtered posts:', errors);
        return {
            posts: []
        };
    }

    console.log('Filtered posts:', posts);
    console.log('SQL query:', (supabase.from('posts').select('*').eq('status', 'published') as any).sql); // Log the generated SQL

    return {
        posts: posts || []
    };
};
