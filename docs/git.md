# Git Commands

## Configuration

Check local repo git settings (SSH vs HTTPS):

```bash
git config -l
```

Change remote URL to SSH:

```bash
git config remote.origin.url git@github.com:the_repository_username/your_project.git
```

**Note:** Remember to create and add SSH key to GitHub!

## Git Stash

Restore the last stashed commit:

```bash
git stash pop
```

Restore the n-th most recent stashed commit:

```bash
git stash pop stash@{n}
```

## Git Prune

Remove local list of remote branches that are not in the remote:

```bash
git remote prune origin
```

## Git Branch

List all local branches:

```bash
git branch -vv
```

Delete local branches that are not in the remote (--prune prunes the list of local remotes):

```bash
git fetch --prune
git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
```

## Amending Commits

### Change commit message (not yet pushed)

```bash
git commit --amend -m "Your new and improved commit message"
```

### Change commit message (already pushed)

```bash
git commit --amend -m "Your new commit message"
git push origin main --force-with-lease
```
