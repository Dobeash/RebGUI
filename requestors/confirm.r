confirm: make function! [
	"Confirms a user choice."
	question [string!] "Prompt to user"
	/title text [string!]
] [
	request/title/confirm/type question any [text "Confirm"] 'help
]