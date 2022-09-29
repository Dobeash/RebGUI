do-events: make function! [
	"Process all Display events."
	/email address [email!] "Specify an email address to send errors to."
	/local *error
] [
	all [
		email
		on-error/email: address
	]
	if error? set/any '*error try [
		wait []
	] [request-error *error]
]