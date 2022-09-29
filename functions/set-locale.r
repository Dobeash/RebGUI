set-locale: make function! [
	"Dynamically set/change locale."
	language [string! none!]
	/local dat-file
] [
	clear locale*/words
	locale*/dict: none
	all [
		exists? dat-file: join what-dir either language [rejoin [%language/ language %.dat]] [%locale.dat]
		locale*: construct/with load dat-file locale*
	]
	all [
		exists? locale*/dictionary: rejoin [what-dir %dictionary/ locale*/language %.dat]
		locale*/dict: make hash! parse read locale*/dictionary " "
	]
]