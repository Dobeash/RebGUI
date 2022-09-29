request-menu: make function! [
	"Requests a menu choice."
	face [object!] "Widget to appear in relation to"
	menu [block!] "Label/Action block pairs"
	/width x [integer!] "Width in pixels (defaults to 25 units)"
	/offset xy [pair!] "Offset relative to widget (defaults to top right)"
	/local result
] [
	result: none
	do select menu result: widgets/choose face any [x 25 * sizes/cell] any [xy face/offset + as-pair face/size/x 0] extract menu 2
	result
]