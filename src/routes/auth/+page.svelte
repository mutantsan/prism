<form method="POST" action="?/login" class="flex flex-col gap-4">
	<label for="email">Email</label>
	<input id="email" name="email" type="email" class="rounded-md border-2 border-gray-300 p-2" />

	<label for="password">Password</label>
	<input
		id="password"
		name="password"
		type="password"
		class="rounded-md border-2 border-gray-300 p-2"
	/>

	<div class="flex flex-col gap-2">
	<button class="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600">Login</button>
		<button class="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600" formaction="?/signup">
            Sign up
        </button>
	</div>
</form>
