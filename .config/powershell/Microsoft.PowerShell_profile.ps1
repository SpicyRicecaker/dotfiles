Invoke-Expression (&starship init powershell)

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord "Ctrl+w" -Function BackwardDeleteWord

# $env:FZF_DEFAULT_COMMAND = 'fd'
# $env:FZF_CTRL_T_COMMAND = 'fd --type f'
# $env:FZF_ALT_C_COMMAND = 'fd --type d'

# Remove-PSReadlineKeyHandler 'Ctrl+r'
# Remove-PSReadlineKeyHandler 'Ctrl+t'
# Import-Module PSFzf

$global:g = "$HOME/git"
$global:nvim = "$HOME/.confignvim"

function dotgit () {
	git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME $args
}