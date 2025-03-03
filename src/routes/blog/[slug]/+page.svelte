<!-- src/routes/blog/[slug]/+page.svelte -->
<script lang="ts">
	export let data;

	const { post } = data;
</script>

<article class="mx-auto max-w-3xl">
	<header class="mb-8">
		<h1 class="mb-4 text-3xl font-bold">{post.title}</h1>

		<div class="flex items-center text-gray-500">
			<span>{new Date(post.created_at).toLocaleDateString()}</span>
		</div>
	</header>

	<!-- This is a simple content display. You'll need to process the Markdown content -->
	<div class="prose lg:prose-xl">
		{post.content}
	</div>
</article>
