# この問題を **Ruby, TypeScript, Go** で解決しました！ 🚀  

# ---

# ## **問題の日本語訳**
# 文字列の配列 `strs` が与えられたとき、**アナグラムごとにグループ化** して返してください。

# **例1:**
# ```plaintext
# 入力: strs = ["eat","tea","tan","ate","nat","bat"]
# 出力: [["bat"],["nat","tan"],["ate","eat","tea"]]
# ```

# **例2:**
# ```plaintext
# 入力: strs = [""]
# 出力: [[""]]
# ```

# **例3:**
# ```plaintext
# 入力: strs = ["a"]
# 出力: [["a"]]
# ```

# ---

# ## **解法**
# アナグラムは「文字を並び替えると同じになる文字列」です。

# ### **方法**
# 1. **各単語をソート** して、**辞書のキーにする**。
# 2. **同じキーを持つ単語を配列に追加** する。
# 3. **ハッシュマップの値を返す**。

# **例:**  
# `["eat", "tea", "tan", "ate", "nat", "bat"]`  
# → ソートすると  
# `["aet", "aet", "ant", "aet", "ant", "abt"]`  
# → グループ化  
# `{"aet" => ["eat", "tea", "ate"], "ant" => ["tan", "nat"], "abt" => ["bat"]}`

# ---

# ## **実装**
# ### **Ruby**
# ```ruby
def group_anagrams(strs)
  hash = Hash.new { |h, k| h[k] = [] }

  strs.each do |str|
    key = str.chars.sort.join
    hash[key] << str
  end

  hash.values
end

# テスト
p group_anagrams(["eat","tea","tan","ate","nat","bat"]) # [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
p group_anagrams([""]) # [[""]]
p group_anagrams(["a"]) # [["a"]]

# ```
# #### **解説**
# - `hash = Hash.new { |h, k| h[k] = [] }` でデフォルト値を配列に設定。
# - `str.chars.sort.join` でソートし、アナグラムをキーにする。
# - **計算量: O(n * k log k)**（n = 単語数, k = 平均文字長）

# ---

# ### **TypeScript**
# ```typescript
# function groupAnagrams(strs: string[]): string[][] {
#     const map = new Map<string, string[]>();

#     for (const str of strs) {
#         const key = str.split("").sort().join(""); // アナグラムのキー
#         if (!map.has(key)) {
#             map.set(key, []);
#         }
#         map.get(key)!.push(str);
#     }

#     return Array.from(map.values());
# }

# // テスト
# console.log(groupAnagrams(["eat","tea","tan","ate","nat","bat"])); // [["eat","tea","ate"],["tan","nat"],["bat"]]
# console.log(groupAnagrams([""])); // [[""]]
# console.log(groupAnagrams(["a"])); // [["a"]]
# ```
# #### **解説**
# - `Map<string, string[]>` で `キー: アナグラム, 値: 単語配列` を作る。
# - `str.split("").sort().join("")` でソートしたキーを作成。
# - **計算量: O(n * k log k)**

# ---

# ### **Go**
# ```go
# package main

# import (
# 	"fmt"
# 	"sort"
# 	"strings"
# )

# func groupAnagrams(strs []string) [][]string {
# 	hash := make(map[string][]string)

# 	for _, str := range strs {
# 		sorted := sortString(str)
# 		hash[sorted] = append(hash[sorted], str)
# 	}

# 	result := [][]string{}
# 	for _, group := range hash {
# 		result = append(result, group)
# 	}
# 	return result
# }

# // 文字列をソートする関数
# func sortString(s string) string {
# 	chars := strings.Split(s, "")
# 	sort.Strings(chars)
# 	return strings.Join(chars, "")
# }

# func main() {
# 	fmt.Println(groupAnagrams([]string{"eat", "tea", "tan", "ate", "nat", "bat"})) // [["eat","tea","ate"],["tan","nat"],["bat"]]
# 	fmt.Println(groupAnagrams([]string{""})) // [[""]]
# 	fmt.Println(groupAnagrams([]string{"a"})) // [["a"]]
# }
# ```
# #### **解説**
# - `map[string][]string` を使い、キーにアナグラムのソート文字列を設定。
# - `sort.Strings(chars)` で文字列をソートする関数を定義。
# - **計算量: O(n * k log k)**
