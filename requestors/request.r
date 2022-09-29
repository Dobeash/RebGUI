request: make function! [
	"Requests an answer to a simple question."
	prompt [string!]
	/title text [string!]
	/ok
	/confirm
	/type icon [word!] "Valid values are: alert, help, info, stop"
	/local result
] [
	result: none
	display/dialog any [text "Request"] compose [
		after 1
		(
			either type [
				reduce ['image select [alert images/alert help images/help info images/info stop images/stop] icon]
			] []
		)
		text 60 (prompt)
		bar
		reverse
		(
			case [
				ok [
					[button "OK" [result: true hide-popup]]
				]
				confirm [
					[button "No" [result: false hide-popup] button "Yes" [result: true hide-popup]]
				]
				true [
					[button "Cancel" [hide-popup] button "No" [result: false hide-popup] button "Yes" [result: true hide-popup]]
				]
			]
		)
		do [set-focus last face/pane]
	]
	result
]