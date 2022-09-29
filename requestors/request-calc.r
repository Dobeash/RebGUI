request-calc: make function! [
	"Requests a calculation."
	/title text [string!] "Title text"
	/stay "Don't exit on ="
	/local result c reg op acc lcd
] [
	result: none

	reg: []
	op: false
	acc: none

	c: make function! [face /local key] [
		either find ".0123456789" key: face/text [
			all [none? pick reg not op insert reg copy ""]
			unless all ["." = key find reg/1 key] [insert tail reg/1 key]
		] [
			if any [key = "=" reg/2] [
				acc: none
				all [
					op
					acc: attempt [do reform [any [reg/2 acc 0] op 'to-decimal reg/1]]
				]
				clear reg
				op: false
			]
			either key = "=" [
				unless stay [
					result: any [reg/1 acc 0]
					hide-popup
				]
			] [
				any [reg/1 insert reg any [acc 0]]
				op: key
			]
		]
		unless find lcd/text: form any [reg/1 acc 0] "." [insert tail lcd/text "."]
		show lcd
	]

	display/dialog any [text "Calculator"] [
		button-size 7
		lcd: text "0." #L font [align: 'right] edge [color: colors/text]
		after 4
		button "7" [c face] button "8" [c face] button "9" [c face] button sky "/" [c face]
		button "4" [c face] button "5" [c face] button "6" [c face] button sky "*" [c face]
		button "1" [c face] button "2" [c face] button "3" [c face] button sky "-" [c face]
		button "0" [c face] button "." [c face] button green "=" [c face] button sky "+" [c face]
	]

	result
]