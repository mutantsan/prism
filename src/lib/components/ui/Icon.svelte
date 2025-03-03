<!-- src/lib/components/ui/Icon.svelte -->
<script lang="ts">
	export let name: string;
	export let className = '';
</script>

<svg class={className} {...$$restProps}>
	<use href="/sprite.svg#{name}" />
</svg>
