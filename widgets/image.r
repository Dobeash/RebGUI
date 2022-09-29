image: make baseface [
	options: {
		USAGE:
			image %icons/Tango-feet.png
			image logo
			image logo effect [crop 10x10 50x50]

		DESCRIPTION:
			An image.
	}
	size: -1x-1
	effect: 'fit
	init: make function! [] [
		all [negative? size/x size/x: image/size/x]
		all [negative? size/y size/y: image/size/y]
	]
]