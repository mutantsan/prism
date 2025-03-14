<!-- src/routes/layout.svelte -->
<script lang="ts">
	import '../app.css';
	import { page } from '$app/state';
	import { locales, localizeHref } from '$lib/paraglide/runtime';
	import { invalidate } from '$app/navigation';
	import { onMount } from 'svelte';

	import Header from '$lib/components/layout/Header.svelte';
	import Sidebar from '$lib/components/layout/Sidebar.svelte';
	import MainContent from '$lib/components/layout/MainContent.svelte';

	let { data, children } = $props();
	let { session, supabase } = $derived(data);

	onMount(() => {
		const { data } = supabase.auth.onAuthStateChange((_, newSession) => {
			if (newSession?.expires_at !== session?.expires_at) {
				invalidate('supabase:auth');
			}
		});

		return () => data.subscription.unsubscribe();
	});
</script>

<div class="bg-prism-gray dark:bg-prism-gray-dark h-lvh p-2 pt-0 text-gray-400 dark:text-white">
	<div class="mx-auto max-w-6xl">
		<div class="mb-5">
			<Header />
		</div>

		<div class="h-vh flex flex-col md:flex-row">
			<div class="mb-5 md:mr-5 md:mb-0">
				<Sidebar />
			</div>
			<MainContent>
				{@render children()}
			</MainContent>
		</div>
	</div>
</div>

<div style="display:none">
	{#each locales as locale}
		<a href={localizeHref(page.url.pathname, { locale })}>{locale}</a>
	{/each}
</div>
