<!-- src/routes/layout.svelte -->
<script lang="ts">
	import '../app.css';
	import { page } from '$app/state';
	import { locales, localizeHref } from '$lib/paraglide/runtime';

	import Header from '$lib/components/layout/Header.svelte';
	import Sidebar from '$lib/components/layout/Sidebar.svelte';
	import MainContent from '$lib/components/layout/MainContent.svelte';
</script>

<div class="bg-prism-gray p-2 pt-0 dark:bg-prism-gray-dark text-gray-400 dark:text-white h-screen">
	<div class="mx-auto max-w-6xl">
		<div class="mb-5">
			<Header />
		</div>

		<div class="flex md:flex-row flex-col">
			<div class="md:mr-5 md:mb-0 mb-5">
				<Sidebar />
			</div>
			<MainContent>
				<slot />
			</MainContent>
		</div>
	</div>
</div>

<div style="display:none">
	{#each locales as locale}
		<a href={localizeHref(page.url.pathname, { locale })}>{locale}</a>
	{/each}
</div>
