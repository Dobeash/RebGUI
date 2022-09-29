set-text: make function! [
	"Set and show a widget's text attribute."
	face [object!] "Widget"
	text [any-type!] "Text"
	/caret "Insert at cursor position (tail if none)"
	/no-show "Don't show"
	/focus
] [
	all [face/parent-face/type = 'disable exit]
	unless string? face/text [exit]
	either caret [
		if all [
			face = view*/focal-face
			view*/caret
		] [face/caret: index? view*/caret]
		either face/caret [
			insert at face/text face/caret form text
			view*/caret: at face/text face/caret + length? form text
			face/caret: index? view*/caret
		] [insert tail face/text form text]
	] [insert clear face/text form text]
	all [
		face/para
		face/para/scroll: 0x0
		all [face/type = 'area face/pane/data: 0]
	]
	face/line-list: none
	unless no-show [either focus [set-focus face] [show face]]
]