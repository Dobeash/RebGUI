request-value: make function! [
	"Requests a value."
	prompt [string!] "Prompt text"
	/title text [string!] "Title text"
	/default value [any-type!] "Default value"
	/type datatype [datatype!] "Return type"
	/key keytype [datatype!] "Key type"
	/chars limit [pair!]
	/local result f b
] [
	value: form any [value ""]
	limit: any [limit 0x255]
	result: none
	display/dialog any [text "Ask"] [
		after 1
		image images/help
		text 50 prompt
		f: field value [b/action/on-click b] on-key [
			;	ignore editing keys
			unless any [
				word? event/key
				find edit/keymap event/key
			][
				;	char limit exceeded?
				all [
					limit/2 <= length? face/text
					return false
				]
				;	valid key datatype?
				all [
					key
					error? try [to keytype form event/key]
					return false
				]
			]
			true
		]
		bar
		reverse
		button "Cancel" [hide-popup]
		b: button "OK" [
			if limit/1 <= length? trim f/text [
				either type [
					unless result: attempt [to datatype f/text] [
						alert rejoin [f/text " is not a valid " datatype "!"]
						exit
					]
				] [
					result: f/text
				]
			]
			hide-popup
		]
		do [set-focus first in-widget face 'field]
	]
	result
]