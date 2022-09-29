set-color: make function! [
	"Set and show a widget's color attribute."
	face [object!]
	color [tuple! none!]
	/no-show "Don't show"
	/deselect "Restore to base color"
] [
	either block? face/effect [
		all [
			deselect
			attribute-old-color?/only face
			face/old-color: colors/outline/1
		]
		either 'gradient = first face/effect [
			poke face/effect 4 either color [color] [any [attribute-old-color? face colors/outline/1]]
		] [
			either color [
				poke face/effect/draw 13 color
				poke face/effect/draw 15 color
			] [
				poke face/effect/draw 13 any [attribute-old-color? face colors/outline/1]
				poke face/effect/draw 15 any [attribute-old-color? face colors/outline/1]
			]
		]
		unless find reduce [none colors/theme/1 colors/outline/1] color [
			all [attribute-old-color?/only face face/old-color: color]
			face/color: none
		]
	] [
		face/color: color
	]
	unless no-show [show face]
]