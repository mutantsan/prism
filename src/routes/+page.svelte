<script lang="ts">
	export let data;

	import { getLocale } from '$lib/paraglide/runtime';
	import { page } from '$app/state';
	import * as m from '$lib/paraglide/messages';
	import Icon from '$lib/components/ui/Icon.svelte';
	import { calculateReadingTime } from '$lib/utils/readingTime.js';

	const locale = getLocale();
</script>

<div>
	<!-- Hero section -->
	<section class="mb-5 flex items-start justify-between bg-white px-7 py-6 dark:bg-gray-800">
		<div class="max-w-xl">
			<h1 class="mb-4 text-3xl font-bold">
				{m.main_title()}
			</h1>
			<p class="mb-6">
				{m.main_slogan()}
			</p>
			<a href="/about" class="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600">
				{m.main_about_author()}
			</a>
		</div>

		<div>
			<img src="/developer.svg" alt="Author" class="h-64 w-64" />
		</div>
	</section>

	<!-- Recent posts -->
	<section class="bg-white px-7 py-6 dark:bg-gray-800">
		<h2 class="mb-7 text-2xl font-bold">
			{m.main_recent_posts()}
		</h2>

		<div class="space-y-8">
			{#each data.posts as post}
				<article class="flex flex-col md:flex-row border-b border-gray-100 pb-6 dark:border-gray-300">
					<div
						class="md:mr-6 mb-4 md:mb-0 flex h-55 md:h-35 w-full md:w-45 md:min-w-45 items-center justify-center rounded bg-gray-100 dark:bg-gray-300"
					>
						<span class="dark:text-white">Mock image</span>
					</div>

					<div class="mb-2 flex flex-col">
						<div class="mb-2 flex items-center">
							<span class="mr-6 flex items-center">
								<Icon name="calendar" className="h-4 w-4 mr-2" />
								{new Date(post.created_at).toLocaleDateString(locale, {
									year: 'numeric',
									month: 'long',
									day: 'numeric'
								})}
							</span>

							<span class="flex items-center">
								<Icon name="clock" className="h-4 w-4 mr-2" />
								{calculateReadingTime(post.content)}
								{m.time_minutes()}
							</span>
						</div>
						<h3 class="mb-2 text-xl font-semibold">
							<a href="/blog/{post.slug}" class="hover:underline">{post.title}</a>
						</h3>

						<p>{post.excerpt}</p>
					</div>
				</article>
			{/each}
		</div>
		<div class="mt-8">
			<a href="/blog" class="text-blue-500 hover:underline">
				{m.main_view_all_posts()}
			</a>
		</div>
	</section>
</div>
