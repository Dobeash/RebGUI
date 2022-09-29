alert: make function! [
	"Flashes an alert message to the user. Waits for a user response."
	value [any-type!] "Value to display"
	/title text [string!]
] [
	request/title/ok/type form value any [text "Alert"] 'alert
]