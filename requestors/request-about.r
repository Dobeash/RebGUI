request-about: make function! [
	"Requests an About dialog."
	product [string!] "Product name"
	version [tuple!] "Product version"
	copyright [string!] "Copyright notice"
	/url link [string! url!] "Product website"
] [
	display/dialog "" compose/deep [
		after 1
		pad (as-pair (60 * sizes/cell / 2) - (images/logo/size/x / 2) 0)
		image images/logo
		text 60 (product) font [size: (sizes/font + 4) style: 'bold align: 'center]
		(either url [[link 60 (link) font [align: 'center]]] [])
		text 60 (join "Version " version) font [align: 'center]
		text 60 (copyright) font [align: 'center]
	]
]