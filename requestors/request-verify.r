request-verify: make function! [
	"Displays a set of labels/values and prompts for verification."
	labels [block!] "Labels"
	values [block!] "Values"
	/title text [string!] "Title text"
	/prompt string [string!] "Prompt text"
	/ok
	/local result blk width
] [
	
	blk: copy []
	width: 0
	foreach label labels [
		label: form label
		insert tail blk compose [label (label) text (form first values)]
		width: max width first widgets/text-size? label
		values: next values
	]
	values: head values
	result: false
	display/dialog any [text either ok ["Info"] ["Verify"]] compose [
		label-size (1 + to integer! width / sizes/cell)
		image (either ok [images/info] [images/help])
		return
		text (any [string either ok ["Details."] ["Are these details correct?"]])
		after 2
		(blk)
		return
		bar
		reverse
		(
			either ok [
				[button "OK" [result: true hide-popup]]
			] [
				[button "No" [hide-popup] button "Yes" [result: true hide-popup]]
			]
		)
		do [set-focus last face/pane]
	]
	result
]