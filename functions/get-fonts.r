get-fonts: make function! [
	"Obtain list of fonts on supported platforms."
	/cache file [file!] "Obtain fonts from file"
	/local s
] [
	all [cache exists? file] [insert clear fonts unique load file]
	if empty? fonts [
		either OS = 'Win [
			call/output {reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"} s: copy ""
			s: skip parse/all s "^-^/" 4
			request-progress/title (length? s) / 3 [
				foreach [fn reg style] s [
					fn: trim first parse/all fn "("
					all [
						not find fonts fn
						not find ["Estrangelo Edessa" "Gautami" "Latha" "Mangal" "Mv Boli" "Raavi" "Shruti" "Tunga"] fn
						not find fn " Bold"
						not find fn " Italic"
						not find fn " Black"
						not find fn "WST_"
						insert tail fonts fn
					]
					wait .01
					step
				]
			] "Loading fonts ..."
		] [
			call/output "fc-list" s: copy ""
			s: parse/all s ":^/"
			request-progress/title (length? s) / 2 [
				foreach [fn style] s [
					all [
						not find fonts fn
						(size-text make widgets/gradface [text: "A" font: make font [name: fn size: 10]]) <>
						size-text make widgets/gradface [text: "A" font: make font [name: fn size: 12 style: 'bold]]
						insert tail fonts fn
					]
					wait .01
					step
				]
			] "Loading fonts ..."
		]
	]
	sort fonts
]