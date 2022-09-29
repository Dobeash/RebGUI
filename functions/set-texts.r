set-texts: make function! [
	"Set and show text attribute of a block of widgets."
	faces [block!] "Widgets"
	text [any-type!] "Text or block of text"
	/no-show "Don't show"
] [
	unless block? text [text: reduce [text]]
	foreach face reduce faces [
		unless face/parent-face/type = 'disable [set-text face first text]
		unless 1 = length? text [text: next text]
	]
	text: head text
	unless no-show [show faces]
]