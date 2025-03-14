<!-- src/lib/components/ThemeToggle.svelte -->
<script lang="ts">
	import { onMount } from 'svelte';
	import Icon from '$lib/components/ui/Icon.svelte';
	import * as m from '$lib/paraglide/messages';

	let isDarkMode = false;

	onMount(() => {
		const savedTheme = localStorage.getItem('theme');
		const preferDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

		isDarkMode = savedTheme === 'dark' || (!savedTheme && preferDark);
		document.documentElement.classList.toggle('dark', isDarkMode);
	});

	function toggleTheme() {
		isDarkMode = !isDarkMode;
		applyTheme();
		localStorage.setItem('theme', isDarkMode ? 'dark' : 'light');
	}

	function applyTheme() {
		if (isDarkMode) {
			document.documentElement.classList.add('dark');
		} else {
			document.documentElement.classList.remove('dark');
		}
	}
</script>

<button
	class="hover:text-blue-500 flex cursor-pointer items-center gap-2 rounded-full
        p-2 "
	onclick={toggleTheme}
	aria-label={!isDarkMode ? m.header_dark_mode() : m.header_light_mode()}
>
	<Icon name="moon" className="h-5 w-5" />
</button>
