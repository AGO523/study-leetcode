require 'securerandom'

class Solution
  def initialize
    @url_map = {}
    @base_url = 'http://tinyurl.com/'
  end

  def encode(long_url)
    key = SecureRandom.alphanumeric(6)
    url = @base_url + key
    # { 'http://tinyurl.com/abc123' => 'https://leetcode.com/problems/design-tinyurl' }
    @url_map[url] = long_url
    url
  end

  def decode(url)
    @url_map[url] || ""
  end
end
