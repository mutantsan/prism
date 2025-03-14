<script>
	let { children } = $props();
</script>

<div class="flex flex-col py-7 px-6 bg-white dark:bg-gray-800">
    {@render children()}
</div>
