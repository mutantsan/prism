<!-- src/lib/components/layout/Header.svelte -->
<header class="bg-white">
	<div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-3">
		<div>
			<a href="/" class="text-xl font-bold">Prism.</a>
		</div>
		<div class="flex items-center gap-4">
			<button class="rounded-full p-1 hover:bg-gray-100" aria-label="Toggle dark mode">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-5 w-5"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						stroke-width="2"
						d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"
					/>
				</svg>
			</button>
			<div class="flex items-center">
				<span>English</span>
			</div>
		</div>
	</div>
</header>
