<!-- src/lib/components/ThemeToggle.svelte -->
<script lang="ts">
	import { onMount } from 'svelte';
    import Icon from '$lib/components/ui/Icon.svelte';
	let isDarkMode = false;

    onMount(() => {
        const savedTheme = localStorage.getItem('theme');
        const preferDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

        isDarkMode = savedTheme === "dark" || (!savedTheme && preferDark);
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

<button class="rounded-full p-2 cursor-pointer hover:bg-gray-100" onclick={toggleTheme} aria-label="Toggle dark mode">
    <Icon name="moon" className="h-5 w-5" />
</button>
