item = github('google', 'jsonnet', :prerelease => true).first
@version = item.tag_name.gsub(/v/,'')
@url = "https://github.com/google/jsonnet/archive/v#{@version}.tar.gz"
