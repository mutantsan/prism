<script lang="ts">
	export let data;

	import Icon from '$lib/components/ui/Icon.svelte';
</script>

<div>
	<!-- Hero section -->
	<section class="mb-6 flex items-start justify-between bg-white px-7 py-6">
		<div class="max-w-xl">
			<h1 class="mb-4 text-3xl font-bold">Prism Blog</h1>
			<p class="mb-6 text-gray-600">
				A collection of thoughts, ideas, and discoveries about web development, programming, and
				technology.
			</p>
			<a href="/about" class="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600">
				About author
			</a>
		</div>

		<div>
            <img src="/developer.svg" alt="Author" class="h-64 w-64" />
		</div>
	</section>

	<!-- Recent posts -->
	<section class="bg-white px-7 py-6">
		<h2 class="mb-7 text-2xl font-bold">Recent posts</h2>

		<div class="space-y-8">
			{#each data.posts as post}
				<article class="flex border-b border-gray-200 pb-6">
					<div class="mr-5 flex h-64 w-64 items-center justify-center rounded bg-gray-200">
						<span class="text-gray-500">Developer Illustration</span>
					</div>

					<div class="mb-2 flex flex-col text-sm text-gray-500">
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
						<h3 class="mb-2 text-xl font-semibold">
							<a href="/blog/{post.slug}" class="hover:underline">{post.title}</a>
						</h3>

						<p class="text-gray-600">{post.excerpt}</p>
					</div>
				</article>
			{/each}
		</div>

		<div class="mt-8">
			<a href="/blog" class="text-blue-500 hover:underline">View all posts</a>
		</div>
	</section>
</div>
