heading: make baseface [
	options: {
		USAGE:
			heading "A text heading."

		DESCRIPTION:
			Large text.
	}
	size: -1x7
	text: ""
	font: font-heading
	init: make function! [] [size/x: text-width? self]
]