doc = html('https://nodejs.org/en/download/stable/')
@url = doc.at_css('a:contains("Source Code")')[:href]
@version = @url.match(/v([\d\.]+)\.tar\.gz/)[1]
