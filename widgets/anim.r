anim: make baseface [
	options: {
		USAGE:
			anim data [ctx-rebgui/images/help ctx-rebgui/images/info]
			anim data [%img1.png %img2.png %img3.png]
			anim data [img1 img2 img3] rate 2

		DESCRIPTION:
			Cycles a set of images at a specified rate.
	}
	size: -1x-1
	effect: 'fit
	action: make default-action [
		on-time: make function! [face] [
			face/image: first face/data
			face/data: either tail? next face/data [head face/data] [next face/data]
			show face
		]
	]
	rate: 1
	init: make function! [/local v] [
		repeat n length? data: reduce data [
			v: pick data n
			all [file? v poke data n load v]
		]
		image: first data
		data: next data
		all [negative? size/x size/x: image/size/x]
		all [negative? size/y size/y: image/size/y]
	]
]