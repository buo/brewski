item = github('rethinkdb', 'rethinkdb').first
@version = item.tag_name.gsub(/v/,'')
@url = "https://download.rethinkdb.com/dist/rethinkdb-#{@version}.tgz"
