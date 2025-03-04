<!-- src/routes/blog/+page.svelte -->
<script lang="ts">
	export let data;

    import Icon from '$lib/components/ui/Icon.svelte';
</script>

<div class="mx-auto bg-white dark:bg-gray-800 p-7">
	<h1 class="mb-8 text-3xl font-bold">All Posts</h1>

	<div class="space-y-8">
		{#each data.posts as post}
			<article class="border-b border-gray-200 pb-6">
                <div class="flex items-center mb-2">
                    <span class="flex items-center mr-6">
                        <Icon name="calendar" className="h-4 w-4 mr-2" />
                        {new Date(post.created_at).toLocaleDateString('uk-UA', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        })}
                    </span>

                    <span class="flex items-center">
                        <Icon name="clock" className="h-4 w-4 mr-2" />
                        20 min
                    </span>
                </div>

				<h2 class="mb-2 text-xl font-semibold">
					<a href="/blog/{post.slug}" class="hover:underline">{post.title}</a>
				</h2>

				<p>{post.excerpt}</p>
			</article>
		{/each}
	</div>
</div>
