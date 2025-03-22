def is_anagram(s, t)
  return false if s.length != t.length
  s.chars.tally == t.chars.tally
end

# テスト
puts is_anagram("anagram", "nagaram") # true
puts is_anagram("rat", "car")         # false
