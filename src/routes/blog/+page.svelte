<!-- src/routes/blog/+page.svelte -->
<script lang="ts">
	export let data;
</script>

<div class="mx-auto max-w-4xl">
	<h1 class="mb-8 text-3xl font-bold">All Posts</h1>

	<div class="space-y-8">
		{#each data.posts as post}
			<article class="border-b border-gray-200 pb-6">
				<div class="mb-2 flex items-center text-sm text-gray-500">
					<span>{new Date(post.created_at).toLocaleDateString()}</span>
					<span class="mx-2">•</span>
					<span>20 min</span>
				</div>

				<h2 class="mb-2 text-xl font-semibold">
					<a href="/blog/{post.slug}" class="hover:underline">{post.title}</a>
				</h2>

				<p class="text-gray-600">{post.excerpt}</p>
			</article>
		{/each}
	</div>
</div>
