examine: make function! [
	"Prints information about widgets and attributes."
	'widget
	/indent "Indent output as an MD2 ready string"
	/no-print "Do not print output to console"
	/local string tmp blk funcs
] [
	unless word? widget [widget: to word! widget]
	unless find tmp: next find first widgets 'choose widget [
		print "Unknown widget. Supported widgets are:^/"
		foreach widget tmp [print join "^-" widget]
		exit
	]
	widget: widgets/:widget
	;	usage & description
	string: replace/all trim/head copy widget/options "^/" "^/^-"
	replace/all string "[" join " " "["
	replace/all string "]" join "]" " "
	replace/all string "^- " "^-"
	replace/all string " ^/" "^/"
	replace string "^-DESCRIPTION:" "^/DESCRIPTION:"
	replace string "^-OPTIONS:" "^/OPTIONS:"
	;	standard attributes
	insert tail string "^/^/^/ATTRIBUTES:"
	foreach attribute skip first widgets/baseface 3 [
		if all [
			not find [show? options face-flags feel action] attribute
			get tmp: in widget attribute
		] [
			tmp: either find ["function" "object" "block" "bitset"] form type? get tmp [join type? get tmp "!"] [mold get tmp]
			insert tail string rejoin [
				"^/^-"
				head insert/dup tail form attribute " " 16 - length? form attribute
				tmp
			]
		]
	]
	;	feels
	if all [widget/feel widget/feel <> widgets/default-feel] [
		insert tail string "^/^/PREDEFINED FEELS:"
		foreach attribute next first widgets/default-feel [
			if get in widget/feel attribute [
				insert tail string join "^/^-" attribute
			]
		]
	]
	;	actions
	if all [widget/action widget/action <> widgets/default-action] [
		insert tail string "^/^/PREDEFINED ACTIONS:"
		foreach attribute next first widgets/default-action [
			if get in widget/action attribute [
				insert tail string join "^/^-" attribute
			]
		]
	]
	;	extended attributes
	funcs: copy []
	unless empty? blk: difference first widgets/baseface first widget [
		insert tail string "^/^/EXTENDED ATTRIBUTES:"
		foreach attribute blk [
			if tmp: in widget attribute [
				either all [attribute <> 'init function? get tmp] [
					insert tail funcs attribute
				] [
					tmp: either find ["object" "block" "bitset" "function"] form type? get tmp [join type? get tmp "!"] [mold get tmp]
					insert tail string rejoin ["^/^-" head insert/dup tail form attribute " " 16 - length? form attribute tmp]
				]
			]
		]
	]
	;	accessor functions
	unless empty? funcs [
		insert tail string "^/^/ACCESSOR FUNCTIONS:"
		foreach attribute funcs [
			tmp: copy ""
			foreach w third get in widget attribute [
				all [word? w insert tail tmp join " " w]
				if refinement? w [
					either w = /local [break] [insert tail tmp join " /" w]
				]
			]
			insert tail string rejoin ["^/^-" uppercase form attribute tmp]
		]
	]
	if indent [
		replace/all string "^/" "^/^-"
		replace/all string "^-^/" "^/"
		insert string "^-"
	]
	if no-print [
		replace/all string "^-" "    "
	]
	either any [indent no-print] [string] [print string]
]