<!-- src/lib/components/layout/Sidebar.svelte -->
<script lang="ts">
	import Icon from '$lib/components/ui/Icon.svelte';
</script>

<aside class="w-64 bg-white dark:bg-gray-800 p-4">
	<!-- Search bar -->
	<div class="mb-5">
		<input
			type="text"
			placeholder="Поиск"
			class="w-full border-1 border-gray-100 dark:border-gray-700 rounded-md px-3 py-2 dark:text-gray-200 placeholder:text-gray-500 dark:placeholder:text-white"
		/>
	</div>

	<!-- Navigation -->
	<nav>
		<ul>
			<li>
				<a href="/" class="group flex items-center gap-2 py-2">
					<Icon name="home" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Главная</span>
				</a>
			</li>
			<li>
				<a href="/blog" class="group flex items-center gap-2 py-2">
					<Icon name="blog" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Блог</span>
				</a>
			</li>
			<li>
				<a href="/tags" class="group flex items-center gap-2 py-2">
					<Icon name="tag" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Теги</span>
				</a>
			</li>
			<li>
				<a href="/resume" class="group flex items-center gap-2 py-2">
					<Icon name="user" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Резюме</span>
				</a>
			</li>
			<li>
				<a href="/contact" class="group flex items-center gap-2 py-2">
					<Icon name="contact" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Контакты</span>
				</a>
			</li>
		</ul>
	</nav>

    <hr class="my-6 text-gray-100 dark:text-gray-300">

	<!-- Popular tags -->
	<div>
		<h2 class="mb-5 text-xl">Популярные теги</h2>
		<div class="flex flex-wrap gap-2">
			{#each [
				{ name: 'SvelteKit', count: 8 },
				{ name: 'WebDev', count: 12 },
				{ name: 'Python', count: 6 },
				{ name: 'Ubuntu', count: 3 },
				{ name: 'Linux', count: 4 },
				{ name: 'Drupal', count: 2 }
			] as tag}
				<a
					href="/tags/{tag.name.toLowerCase()}"
					class="rounded bg-gray-100 dark:bg-gray-700 px-2 py-1 text-sm hover:bg-gray-200 dark:hover:bg-gray-600"
					>{tag.name} {#if tag.count}({tag.count}){/if}</a
				>
			{/each}
		</div>
	</div>
</aside>
