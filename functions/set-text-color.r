set-text-color: make function! [
	"Set and show a widget's font color attribute."
	face [object!]
	color [tuple! none!]
	/no-show "Don't show"
] [
	unless string? face/text [exit]
	all [
		widgets/(face/type)/font
		face/font = widgets/(face/type)/font
		face/font: make face/font []
	]
	face/font/color: color
	unless no-show [show face]
]