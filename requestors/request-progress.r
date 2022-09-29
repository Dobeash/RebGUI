request-progress: make function! [
	"Requests a progress dialog for an action block."
	steps [integer!] "Number of iterations"
	block [block!] "Action block"
	/title text [string!] "Title text"
	/local step *s *p
] [
	*s: 1 / steps
	step: make function! [] [*p/data: *p/data + *s show *p]
	display/dialog/no-wait any [text "Loading ..."] [
		image images/info
		return
		*p: progress
	]
	do bind block 'step
	wait .1
	hide-popup
	wait []
]