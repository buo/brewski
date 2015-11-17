doc = html('https://jenkins-ci.org')
link = doc.at_css('a:contains("Latest and greatest")')
@version = link.text.match(/\(([\d\.]+)\)/)[1]
@url = link[:href].gsub(/latest/, @version)
