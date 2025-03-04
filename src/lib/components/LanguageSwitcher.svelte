<!-- src/lib/components/ui/LanguageSwitcher.svelte -->
<script lang="ts">
	import { locales, setLocale } from '$lib/paraglide/runtime';
	import * as m from '$lib/paraglide/messages';
	import { page } from '$app/state';

	const languageNames = {
		en: m.lang_en(),
		de: m.lang_de(),
		uk: m.lang_uk()
	};

	function switchLanguage(locale: 'en' | 'de' | 'uk') {
		setLocale(locale);
		document.cookie = `lang=${locale}; path=/; max-age=31536000; secure; samesite=strict`;
	}
</script>

<div class="relative inline-block text-left">
	<div class="flex gap-2">
		<select
			class="rounded-md border border-gray-100 bg-white px-3 py-1 text-sm dark:border-gray-600 dark:bg-gray-800"
			on:change={(e) => switchLanguage(e.currentTarget.value as 'en' | 'de' | 'uk')}
		>
			{#each locales as locale}
				<option value={locale} selected={locale === page.params.lang}>
					{languageNames[locale]}
				</option>
			{/each}
		</select>
	</div>
</div>
