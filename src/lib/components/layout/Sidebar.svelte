<!-- src/lib/components/layout/Sidebar.svelte -->
<script lang="ts">
	import Icon from '$lib/components/ui/Icon.svelte';
	import * as m from '$lib/paraglide/messages';
    import { onMount } from 'svelte';

    let sidebar: HTMLElement | null = null;

    onMount(() => {
        sidebar = document.getElementById('sidebar');
    });

    function toggleSidebar() {
        sidebar?.classList.toggle('hidden');
    }
</script>

<aside class="md:w-64 w-full bg-white dark:bg-gray-800 p-4">
	<!-- Search bar -->
	<div class="mb-2 md:mb-5 flex items-center gap-4">
        <!-- Navigation -->
        <div class="md:hidden toggler top-1 relative">
            <button
                on:click={() => toggleSidebar()}
                class="text-gray-200 dark:text-white cursor-pointer hover:text-blue-500">
                <Icon name="menu" className="h-5 w-5" />
            </button>
        </div>

		<input
			type="text"
			placeholder="{m.nav_search()}"
			class="w-full border-1 border-gray-100 dark:border-gray-700 rounded-md px-3 py-2 dark:text-gray-200 placeholder:text-gray-500 dark:placeholder:text-white"
		/>
	</div>

	<nav id="sidebar" class="hidden md:block">
		<ul>
			<li>
				<a href="/" class="group flex items-center gap-2 py-2">
					<Icon name="home" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">
                        {m.nav_home()}
                    </span>
				</a>
			</li>
			<li>
				<a href="/blog" class="group flex items-center gap-2 py-2">
					<Icon name="blog" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">
                        {m.nav_blog()}
                    </span>
				</a>
			</li>
			<li>
				<a href="/tags" class="group flex items-center gap-2 py-2">
					<Icon name="tag" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">
                        {m.nav_tags()}
                    </span>
				</a>
			</li>
			<li>
				<a href="/resume" class="group flex items-center gap-2 py-2">
					<Icon name="user" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">
                        {m.nav_resume()}
                    </span>
				</a>
			</li>
			<li>
				<a href="/contact" class="group flex items-center gap-2 py-2">
					<Icon name="contact" className="h-5 w-5 mr-4 group-hover:text-blue-500" />
					<span class="group-hover:text-blue-500">
                        {m.nav_contact()}
                    </span>
				</a>
			</li>
		</ul>
	</nav>

    <hr class="hidden md:block mt-6 mb-3 text-gray-100 dark:text-gray-300">

	<!-- Popular tags -->
	<div>
		<h2 class="mt-3 mb-5 text-xl">
            {m.main_popular_tags()}
        </h2>
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
