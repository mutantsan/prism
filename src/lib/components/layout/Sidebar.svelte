<!-- src/lib/components/layout/Sidebar.svelte -->
<script lang="ts">
	import Icon from '$lib/components/ui/Icon.svelte';
</script>

<aside class="w-64 bg-white p-4">
	<!-- Search bar -->
	<div class="mb-5">
		<input type="text" placeholder="Поиск" class="w-full border-1 bg-gray-100 border-gray-200 px-3 py-2" />
	</div>

	<!-- Navigation -->
	<nav class="mb-8">
		<ul>
			<li>
				<a href="/" class="group flex items-center gap-2 py-2">
					<Icon name="home" className="h-5 w-5 mr-4 text-gray-600 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Главная</span>
				</a>
			</li>
			<li>
				<a href="/blog" class="group flex items-center gap-2 py-2">
					<Icon name="blog" className="h-5 w-5 mr-4 text-gray-600 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Блог</span>
				</a>
			</li>
			<li>
				<a href="/tags" class="group flex items-center gap-2 py-2">
					<Icon name="tag" className="h-5 w-5 mr-4 text-gray-600 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Теги</span>
				</a>
			</li>
			<li>
				<a href="/resume" class="group flex items-center gap-2 py-2 group-hover:text-blue-500">
					<Icon name="user" className="h-5 w-5 mr-4 text-gray-600 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Резюме</span>
				</a>
			</li>
			<li>
				<a href="/contact" class="group flex items-center gap-2 py-2">
					<Icon name="contact" className="h-5 w-5 mr-4 text-gray-600 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">Контакты</span>
				</a>
			</li>
		</ul>
	</nav>

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
					class="rounded bg-gray-100 px-2 py-1 text-sm hover:bg-gray-200"
					>{tag.name} {#if tag.count}({tag.count}){/if}</a
				>
			{/each}
		</div>
	</div>
</aside>
