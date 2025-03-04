<script lang="ts">
	import * as m from '$lib/paraglide/messages';

	const handleSubmit = async (event: SubmitEvent) => {
		event.preventDefault();

		const formData = new FormData(event.target as HTMLFormElement);
		const name = formData.get('name') as string;
		const email = formData.get('email') as string;
		const message = formData.get('message') as string;

		try {
			const response = await fetch('/api/email', {
				method: 'POST',
				body: JSON.stringify({ name, email, message }),
				headers: {
					'Content-Type': 'application/json'
				}
			});

			const result = await response.json();
			console.log(result);
		} catch (error) {
			console.error(error);
		}
	};

	const inputClasses =
		'w-full border-1 border-gray-100 dark:border-gray-700 rounded-md px-3 py-2 dark:text-gray-200 placeholder:text-gray-500 dark:placeholder:text-white';
</script>

<div class="bg-white p-4 dark:bg-gray-800">
	<h1 class="mb-4 text-3xl font-bold">{m.contact_me()}</h1>
	<p class="mb-7">{m.contact_me_description()}</p>

    <form on:submit={handleSubmit} class="flex w-lg flex-col gap-4">
        <input name="name" type="text" placeholder={m.contact_me_name()} class={inputClasses} required />
        <input name="email" type="email" placeholder={m.contact_me_email()} class={inputClasses} required />
        <textarea name="message" placeholder={m.contact_me_message()} class={inputClasses} required></textarea>
        <button type="submit" class="mt-3 w-36 rounded-md bg-blue-500 p-2 text-white">
            {m.contact_me_send()}
        </button>
    </form>
</div>
