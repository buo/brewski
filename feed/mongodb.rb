data = json('https://www.mongodb.org/data/downloads/json')
@version = data['releases']['prod']['version']
@url = "https://fastdl.mongodb.org/src/mongodb-src-r#{version}.tar.gz"
