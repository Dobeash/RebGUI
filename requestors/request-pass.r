request-pass: make function! [
	"Requests a username and password."
	/title text [string!] "Title text"
	/user username [string!] "Default username"
	/pass password [string!] "Default password"
	/check rules [block!] "Rules to test password against (fails if string returned)"
	/only "Password only"
	/verify "Verify password"
	/local result s blk u p v ; user, password, verify
] [
	blk: copy []
	all [check rules: make function! [text [string!]] rules]
	all [not only insert tail blk compose [text "Username:" u: field (any [username ""])]]
	insert tail blk compose [text "Password:" p: password (any [password ""])]
	all [verify insert tail blk [text "Verify:" v: password]]
	result: none
	display/dialog any [text "Password"] compose [
		text-size 20
		image images/help
		after 2
		(blk)
		bar
		reverse
		button "Cancel" [hide-popup]
		button "OK" [
			case [
				all [not only empty? u/text] [
					alert "Username must be provided."
					set-focus u
				]
				all [check string? s: rules p/text] [
					alert s
					set-focus p
				]
				all [verify p/text <> v/text] [
					alert "Please try again."
					set-focus v
				]
				true [
					result: either only [copy p/text] [reduce [u/text p/text]]
					hide-popup
				]
			]
		]
		do [set-focus third face/pane]
	]
	result
]