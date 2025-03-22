def is_anagram(s, t)
  return false if s.length != t.length
  s.chars.tally == t.chars.tally
end

# テスト
puts is_anagram("anagram", "nagaram") # true
puts is_anagram("rat", "car")         # false

# package main

# import (
# 	"fmt"
# )

# func isAnagram(s string, t string) bool {
# 	if len(s) != len(t) {
# 		return false
# 	}

# 	count := make(map[rune]int)

# 	for _, char := range s {
# 		count[char]++
# 	}

# 	for _, char := range t {
# 		count[char]--
# 		if count[char] < 0 {
# 			return false
# 		}
# 	}

# 	return true
# }

# func main() {
# 	fmt.Println(isAnagram("anagram", "nagaram")) // true
# 	fmt.Println(isAnagram("rat", "car"))         // false
# }

# function isAnagram(s: string, t: string): boolean {
#   if (s.length !== t.length) return false;

#   const count: Record<string, number> = {};

#   for (const char of s) {
#       count[char] = (count[char] || 0) + 1;
#   }

#   for (const char of t) {
#       if (!count[char]) return false;
#       count[char]--;
#   }

#   return true;
# }

# // テスト
# console.log(isAnagram("anagram", "nagaram")); // true
# console.log(isAnagram("rat", "car"));         // false
