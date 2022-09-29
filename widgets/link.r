link: make baseface [
	options: {
		USAGE:
			link
			link http://www.dobeash.com
			link "RebGUI" http://www.dobeash.com/rebgui

		DESCRIPTION:
			Hypertext link.
	}
	size: -1x5
	font: font-link
	feel: make default-feel [
		over: make function! [face act pos] [
			face/font/color: either act [colors/theme/1] [colors/link]
			show face
		]
		engage: make function! [face act event] [
			all [act = 'up browse face/data]
		]
	]
	init: make function! [] [
		text: form any [text data "http://www.dobeash.com"]
		unless data [data: to url! text]
		size/x: text-width? self
	]
]