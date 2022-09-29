bar: make baseface [
	options: {
		USAGE:
			bar 100

		DESCRIPTION:
			A thin bar used to separate widgets.
			Defaults to maximum display width.
	}
	size: -1x-1
	color: colors/outline/3
	init: make function! [] [
		size/y: 1
	]
]