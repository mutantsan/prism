<script lang="ts">
	let { data } = $props();
	let { user } = $derived(data);
</script>

<h1>Logged in as: <b>{user?.email}</b></h1>
