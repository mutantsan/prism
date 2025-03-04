<!-- src/routes/blog/[slug]/+page.svelte -->
<script lang="ts">
	export let data;

	const { post } = data;

    import Icon from '$lib/components/ui/Icon.svelte';
    import { getLocale } from '$lib/paraglide/runtime';
    import { calculateReadingTime } from '$lib/utils/readingTime.js';
    import * as m from '$lib/paraglide/messages';
</script>

<article class="mx-auto  bg-white dark:bg-gray-800 p-4">
	<header class="mb-8">
		<h1 class="mb-4 text-3xl font-bold">{post.title}</h1>

        <div class="flex items-center">
            <span class="flex items-center mr-6">
                <Icon name="calendar" className="h-4 w-4 mr-2" />
                {new Date(post.created_at).toLocaleDateString(getLocale(), {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                })}
            </span>

            <span class="flex items-center">
                <Icon name="clock" className="h-4 w-4 mr-2" />
                {calculateReadingTime(post.content)} {m.time_minutes()}
            </span>
        </div>
	</header>

	<!-- This is a simple content display. You'll need to process the Markdown content -->
	<div class="prose lg:prose-xl">
		{post.content}
	</div>
</article>
