<!-- src/lib/components/layout/Header.svelte -->
 <script>
	import ThemeToggle from '$lib/components/ThemeToggle.svelte';
	import LanguageSwitcher from '$lib/components/LanguageSwitcher.svelte';
</script>

<header class="bg-white dark:bg-gray-800">
	<div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-3">
		<div>
			<a href="/" class="text-xl font-bold">Prism.</a>
		</div>
		<div class="flex items-center gap-4">
			<ThemeToggle />

			<LanguageSwitcher />
		</div>
	</div>
</header>
