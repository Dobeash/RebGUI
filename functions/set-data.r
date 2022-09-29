set-data: make function! [
	"Set and show a widget's data attribute."
	face [object!]
	data [any-type!]
	/no-show "Don't show"
] [
	face/data: either series? data [copy data] [data]
	unless no-show [show face]
]