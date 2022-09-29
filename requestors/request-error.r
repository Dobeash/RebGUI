request-error: make function! [
	"Displays an error with send and exit options."
	error [error! string!]
	/local s
] [
	error: either error? error [disarm error] [disarm make error! error]
	;	Get window stack
	s: copy ""
	foreach window screen*/pane [
		insert tail s join window/text "^/"
	]
	remove back tail s
	;	Clean up environment
	clear screen*/pane
	clear view*/pop-list
	view*/focal-face: view*/pop-face: none
	show screen*
	recycle
	;	Display error
	display/dialog join uppercase/part form error/type 1 " Error" compose [
		after 1
		image images/stop
		heading (form error/id)
		panel data [
			after 1
			label "Info"
			text 100 (reform ["RebGUI" build now/date now/time])
			label "Displays"
			text 100 s
			label "Arguments"
			text 100 (reform [mold error/arg1 mold error/arg2 mold error/arg3])
			label "Near"
			text 100 (mold/only error/near)
			label "Where"
			text 100 (mold/only error/where)
		]
		reverse
		button "Exit" [quit]
		(
			either all [on-error/email system/user/email] [
				[
					button "Send" [
						alert either error? try [
							send/subject on-error/email rejoin [
								error/type error/id
								"^/^/-INFO-^/" reform ["RebGUI" build now/date now/time]
								"^/^/-DISPLAYS-^/" s
								"^/^/-ARGUMENTS-^/" reform [mold error/arg1 mold error/arg2 mold error/arg3]
								"^/^/-NEAR-^/" mold/only error/near
								"^/^/-WHERE-^/" mold/only error/where
							] on-error/subject
						] ["Failed to send email!"] ["Email sent." quit]
					]
				]
			] []
		)
		do [set-focus last face/pane]
	]
]