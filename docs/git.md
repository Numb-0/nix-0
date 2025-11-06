This first commnand checks for the local repo git settings
There you can check if you are using ssh or https
1. git config -l  
2. git config remote.origin.url git@github.com:the_repository_username/your_project.git
3. Remember to create and add key to github!!!

### Git stash
This restore the last stashed commit
`git stash pop`
Or the n most recent stashed commit
`git stash pop stash@{n}`

### Git prune
Remove local list of remote branches that are not in the remote
`git remote prune origin`

### Git branch
List all local branches
`git branch -vv`

Delete local branches that are not in the remote (--prune prunes the list of local remotes)
```
git fetch --prune
git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
```
