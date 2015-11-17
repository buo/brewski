item = github('github', 'git-lfs').first
@version = item.tag_name.gsub(/v/,'')
@url = "https://github.com/github/git-lfs/archive/v#{@version}.tar.gz"
