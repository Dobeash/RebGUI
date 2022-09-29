request-list: make function! [
	"Requests a selection from a list."
	items [block!] "List of items to display."
	/title text [string!] "Title text"
	/prompt string [string!] "Prompt text"
	/ok
	/local result size
] [
	size: 0
	foreach item items [
		size: max size first widgets/text-size? form item
	]
	size: max 50x10 min 200x100 as-pair size / sizes/cell + sizes/cell 5 * length? items
	result: none
	display/dialog any [text either ok ["View"] ["List"]] compose [
		after 1
		image (either ok [images/info] [images/help])
		text (any [string either ok ["Details:"] ["Select an entry:"]])
		text-list (size) data items
		reverse
		(either ok [] [[button "Cancel" [hide-popup]]])
		button "OK" [result: face/parent-face/pane/3/selected hide-popup]
		do [set-focus last face/pane]
	]
	result
]