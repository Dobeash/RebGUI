button: make pill [
	options: {
		USAGE:
			button "Hello"
			button -1 "Go!"
			button "Click me!" [print "click"]

		DESCRIPTION:
			Performs action when clicked.
	}
	size: 15x5
	text: ""
	font: font-button
	feel: feel-click
	old-color: none
]