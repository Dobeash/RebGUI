flash: make function! [
	"Flashes a message to the user and continues."
	value [any-type!] "Value to display"
	/title text [string!]
] [
	display/dialog/no-wait any [text "Information"] [
		image images/info
		text #V (form value)
	]
]