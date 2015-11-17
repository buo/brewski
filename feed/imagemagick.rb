doc = html('http://www.imagemagick.org/script/binary-releases.php')
@version = doc.css('table')[0].css('tr')[1].css('td')[0].text.match(/ImageMagick-([\d\.\-]+)\.i386\.rpm/)[1]
@url = "http://www.imagemagick.org/download/releases/ImageMagick-#{@version}.tar.xz"
