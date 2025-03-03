<!-- src/routes/+layout.svelte -->
<script lang="ts">
	import '../app.css';
	import Header from '$lib/components/layout/Header.svelte';
	import Sidebar from '$lib/components/layout/Sidebar.svelte';
	import MainContent from '$lib/components/layout/MainContent.svelte';
</script>

<div class="bg-prism-gray">
	<div class="mx-auto max-w-7xl">
		<div class="mb-5">
			<Header />
		</div>

		<div class="flex min-h-screen">
			<div class="mr-5">
				<Sidebar />
			</div>
			<MainContent>
				<slot />
			</MainContent>
		</div>
	</div>
</div>
