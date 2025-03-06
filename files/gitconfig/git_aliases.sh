# Git Aliases
alias bat='batcat' #this is not a git alias but allows below gfv command to work
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate --all'
alias gp='git push'
alias gpf='git push --force'
alias gpl='git pull'
alias gr='git restore'
alias grs='git restore --staged'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gcl='git clone'
alias gpr='git pull --rebase'
alias gstash='git stash'
alias gpop='git stash pop'

## GIT COMMANDS
gsw() {
	local branch
	branch=$(git branch --sort=-committerdate | sed 's/^..//' | fzf --preview "git log --oneline --graph --color=always {}" --prompt="Switch to branch: ")

	if [[ -n "$branch" ]]; then
		git switch "$branch"
	fi
}
gcp() {
  # Select a branch using fzf
  local branch=$(git branch --all --sort=-committerdate | sed 's/\*//g' | sed 's/remotes\///g' | awk '{$1=$1};1' | uniq | fzf --prompt="Select a branch: ")

  # Exit if no branch is selected
  [ -z "$branch" ] && echo "No branch selected. Exiting..." && return 1

  # Fetch and display commits from the selected branch (latest first)
  local commit=$(git log --oneline --reverse --topo-order "$branch" | fzf --multi --prompt="Select commits to cherry-pick: " | awk '{print $1}')

  # Exit if no commit is selected
  [ -z "$commit" ] && echo "No commits selected. Exiting..." && return 1

  # Cherry-pick the selected commits
  echo "Cherry-picking commits: $commit from $branch"
  git cherry-pick $commit

  # If conflicts occur
  if [ $? -ne 0 ]; then
    echo "Cherry-pick encountered conflicts. Resolve them and run:"
    echo "  git cherry-pick --continue"
    echo "Or abort with:"
    echo "  git cherry-pick --abort"
  fi
}

#view file versions
gfv() {
  local file="$1"

  if [[ -z "$file" ]]; then
    echo "Usage: gfv <current-file-name>"
    return 1
  fi

  # Ensure the file is tracked in Git (even if renamed)
  if ! git log --follow --pretty=format:%H -- "$file" >/dev/null 2>&1; then
    echo "File '$file' is not tracked by Git."
    return 1
  fi

  # Use fzf to select a commit with a live preview of the correct file content
  local commit=$(git log --follow --oneline -- "$file" | \
    fzf --reverse --preview "
      # Find the correct file name in the selected commit
      actual_file=\$(git ls-tree -r {1} --name-only | grep -E \"$(basename "$file")\$\" || echo \"\");

      if [[ -n \"\$actual_file\" ]]; then
        git show {1}:\$actual_file | bat --paging=always --theme=TwoDark --style=plain 2>/dev/null || git show {1}:\$actual_file | head -100;
      else
        # If the file doesn't exist, find the last commit where it existed
        prev_commit=\$(git log --follow --pretty=format:%H -- \"$file\" | grep -B1 {1} | head -n1);
        prev_file=\$(git diff-tree --no-commit-id --name-only -r \$prev_commit | grep -E \"$(basename "$file")\$\" || echo \"\");

        if [[ -n \"\$prev_file\" ]]; then
          echo 'Showing previous version of the file:';
          git show \$prev_commit:\$prev_file | bat --paging=always --theme=TwoDark --style=plain 2>/dev/null || git show \$prev_commit:\$prev_file | head -100;
        else
          echo 'Could not find an older version of the file.';
        fi
      fi
    " --prompt="Select commit: " | awk '{print $1}')

  # Exit if no commit was selected
  [ -z "$commit" ] && echo "No commit selected. Exiting..." && return 1

  # Find the actual file name in the selected commit (handles renames)
  local actual_file=$(git ls-tree -r "$commit" --name-only | grep -E "$(basename "$file")$" || echo "")

  # If the file doesn't exist in the selected commit, find the previous commit where it did exist
  if [[ -z "$actual_file" ]]; then
    commit=$(git log --follow --pretty=format:%H -- "$file" | grep -B1 "$commit" | head -n1)
    actual_file=$(git diff-tree --no-commit-id --name-only -r "$commit" | grep -E "$(basename "$file")$" || echo "")

    if [[ -z "$actual_file" ]]; then
      echo "Error: Could not find an older version of '$file'"
      return 1
    fi
  fi

  # Show the file content at the selected commit
  git show "$commit:$actual_file" | bat --paging=always --theme=TwoDark --style=plain 2>/dev/null || git show "$commit:$actual_file" | less
}

