set-state: make function! [
	"Set and show a widget's state."
	face [object!]
	state [logic!]
	/no-show "Don't show"
] [
	either state [
		all [
			'luma <> second-last face/effect
			insert tail face/effect reduce ['luma -64]
		]
	] [
		all [
			'luma = second-last face/effect
			clear back back tail face/effect
		]
	]
	unless no-show [show face]
]