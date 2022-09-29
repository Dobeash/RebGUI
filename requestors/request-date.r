request-date: make function! [
	"Requests a date."
	/title text [string!] "Title text"
	/date dt [date!] "Initial date to show (default is today)"
	/local result
] [
	result: none
	display/dialog any [text "Calender"] [
		calendar data (any [dt now/date]) [result: face/data hide-popup]
		reverse
		button "Cancel" [hide-popup]
		button "OK" [result: any [dt now/date] hide-popup]
	]
	result
]