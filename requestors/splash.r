splash: make function! [
	"Displays a centered splash screen for one or more seconds."
	spec [block! file! image!] "The face spec or image to display"
] [
	spec: either block? spec [make widgets/baseface spec] [
		make widgets/baseface [
			image: either file? spec [load spec] [spec]
			size: image/size
		]
	]
	spec/type: 'splash
	spec/offset: max 0x0 screen*/size - spec/size / 2
	spec/color: any [spec/color colors/page]
	view/new/options spec 'no-title
	wait effects/splash-delay
]