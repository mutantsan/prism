<!-- src/lib/components/layout/Header.svelte -->
 <script>
    import ThemeToggle from '$lib/components/ThemeToggle.svelte';
 </script>

<header class="bg-white dark:bg-gray-800">
	<div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-3">
		<div>
			<a href="/" class="text-xl font-bold">Prism.</a>
		</div>
		<div class="flex items-center gap-4">
			<ThemeToggle />

			<div class="flex items-center">
				<span>English</span>
			</div>
		</div>
	</div>
</header>
