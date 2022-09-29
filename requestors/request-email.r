request-email: make function! [
	"Requests email settings."
	/title text [string!] "Title text"
	/default settings [block!] "Default user, address, SMTP and POP settings"
	/local result f1 f2 f3 f4
] [
	unless default [
		settings: reduce [
			any [system/user/name ""]
			any [system/user/email ""]
			any [system/schemes/default/host ""]
			any [system/schemes/pop/host ""]
		]
	]
	result: none
	display/dialog any [text "Email Settings"] [
		image images/help
		after 2
		label "User name" f1: field (form first settings)
		label "Email address" f2: field (form second settings)
		label "SMTP server" f3: field (form third settings)
		label "POP server" f4: field (form fourth settings) on-focus [
			all [empty? face/text face/text: copy f3/text]
			true
		]
		bar
		reverse
		button "Cancel" [hide-popup]
		button "OK" [
			unless any [
				empty? f1/text
				empty? f2/text
				empty? f3/text
				empty? f4/text
			][
				either error? try [set-net reduce [to email! f2/text f3/text f4/text]] [
					alert "Failed to change email settings."
				][
					system/user/name: f1/text
					result: reduce [f1/text to email! f2/text f3/text f4/text]
				]
			]
			hide-popup
		]
		do [set-focus third face/pane]
	]
	result
]