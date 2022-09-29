btn: make gradface [
	options: {
		USAGE:
			btn "Hello"
			btn -1 "Go!"
			btn "Click me!" [print "click"]

		DESCRIPTION:
			Performs action when clicked.
	}
	size: -1x5
	text: ""
	font: font-button
	feel: feel-click
	action: default-action
	old-color: none
	init: make function! [] [
		all [color set-color/no-show self color]
		all [font size/x: text-width? self]
	]
]