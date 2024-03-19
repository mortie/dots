{
	; Username and host part
	(if is-remote?
		{(bold-green "∞" space)})
	(case
		{[username == "root"] (list (red "root") "@")}
		{[username != login-name] (list (bold-green username) "@")})
	(if is-remote?
		{(bold-red host)}
		{(bold-yellow host)})
	space

	; Directory part
	(bold-cyan cwd)
	space

	; Git stuff
	(if has-git?
		{(list
			(bold-red git-branch)
			(if [(read (exec "git" "-C" git-workdir "diff" "--name-only")) != ""]
				{(bold-yellow "*")})
			space)})

	; Newline if there's not much space left on the line
	(if [column > [term-width - 40]] {"\n"})

	; Prompt character
	(if [exit-code == 0]
		{(bold-green "$")}
		{(bold-red "$")})
	space
}
