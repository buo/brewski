require 'curb'
require 'digest'
require 'tempfile'

module Brewski
  def self.shasum(url)
    file = Tempfile.new('brewski')
    Curl::Easy.download(url, file.path) do |curl|
      curl.follow_location = true
    end
    sha256 = Digest::SHA2.file(file.path).hexdigest
    return sha256
  end
end
