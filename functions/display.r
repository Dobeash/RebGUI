display: make function! [
	"Displays widgets in a centered window with a title."
	title [string!] "Window title"
	spec [block!] "Block of widgets, attributes and keywords"
	/dialog "Modal dialog with /parent & /close options"
	/parent "Force parent to be last window (default is first)"
	/close closer [block!] "Handle window close event"
	/offset xy [pair!] "Offset of window on screen"
	/maximize "Maximize window"
	/no-wait "Don't wait if a dialog (used by request-progress)"
] [
	;	prevent duplicate display being opened
	foreach window screen*/pane [all [title = window/text exit]]
	;	create window face
	spec: layout spec
	spec/text: title
	spec/feel: view*/window-feel
	all [offset spec/offset: xy]
	all [close spec/action: make function! [face /local var] closer]
	;	window after 1st is a child of 1st (or last if /dialog or /parent)
	all [
		not empty? screen*/pane
		insert tail spec/options reduce [
			'parent
			either any [dialog parent] [last screen*/pane] [first screen*/pane]
		]
	]
	;	resize window?
	either maximize [
		insert tail spec/options 'resize
		spec/changes: [maximize]
	] [
		;	do any faces require resize?
		foreach face spec/pane [
			all [
				face/span
				not empty? intersect face/span #HWXY
				insert tail spec/options 'resize
				break
			]
		]
	]
	;	min-size?
	all [
		find spec/options 'resize
		insert tail spec/options reduce ['min-size spec/size + view*/title-size + view*/resize-border]
	]
	;	modal dialog?
	all [
		dialog
		spec/type: 'modal
		insert tail view*/pop-list view*/pop-face: spec
	]
	insert tail screen*/pane spec 
	show screen*
	disable disable-widgets
	either all [dialog not no-wait] [wait []] [spec]
]