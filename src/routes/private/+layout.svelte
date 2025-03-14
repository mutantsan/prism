<script>
	let { data, children } = $props();
	let { supabase } = $derived(data);

	const logout = async () => {
		const { error } = await supabase.auth.signOut();
		if (error) {
			console.error(error);
		}
	};
</script>

<div class="flex flex-col py-7 px-6 bg-white dark:bg-gray-800">
    {@render children()}
</div>
