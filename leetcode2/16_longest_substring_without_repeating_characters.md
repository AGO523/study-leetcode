## ✅ 問題の概要

文字列 `s` が与えられたときに、**重複しない文字からなる最長の部分文字列の長さ** を求める問題です。

---

## 🎯 目的

- **重複のない連続した文字列（substring）** の中で最長のものを見つけ、その長さを返す。

---

## 🧠 考え方（スライディングウィンドウ + ハッシュセット）

文字列を 1 文字ずつ見ながら、**「今見ている範囲に重複がないか？」** を管理していきます。

### 🌈 スライディングウィンドウとは？

- **左ポインタ `left`**：現在の部分文字列の開始位置
- **右ポインタ `right`**：文字列を走査しながら伸ばす位置

### ✅ アルゴリズム概要

1. ハッシュセット `chars` を使って、現在のウィンドウ内の文字を記録。
2. `s[right]` がすでにセットにある場合、**`left` を動かして重複を除去**。
3. 重複がなければ、セットに追加し、**現在のウィンドウの長さを比較して最大を更新**。

---

## 💎 Ruby 実装（初心者向けに丁寧に）

```ruby
def length_of_longest_substring(s)
  chars = Set.new  # 現在のウィンドウの中の文字を記録
  left = 0         # スタート位置
  max_len = 0      # 最大長

  # 配列を each で走査しながら、スライディングウィンドウで現在の部分文字列を管理
  s.each_char.with_index do |char, right|
    # 重複がある限り、左側から文字を削除していく
    while chars.include?(char)
      chars.delete(s[left])
      left += 1
    end

    chars.add(char)
    max_len = [max_len, right - left + 1].max
  end

  max_len
end

require 'set'

# テスト
p length_of_longest_substring("abcabcbb") # => 3 ("abc")
p length_of_longest_substring("bbbbb")    # => 1 ("b")
p length_of_longest_substring("pwwkew")   # => 3 ("wke")
```

---

## 💻 TypeScript 実装

```typescript
function lengthOfLongestSubstring(s: string): number {
  const set = new Set<string>();
  let left = 0;
  let maxLen = 0;

  for (let right = 0; right < s.length; right++) {
    while (set.has(s[right])) {
      set.delete(s[left]);
      left++;
    }
    set.add(s[right]);
    maxLen = Math.max(maxLen, right - left + 1);
  }

  return maxLen;
}

// テスト
console.log(lengthOfLongestSubstring("abcabcbb")); // => 3
console.log(lengthOfLongestSubstring("bbbbb")); // => 1
console.log(lengthOfLongestSubstring("pwwkew")); // => 3
```

---

## 🐹 Go 実装

```go
package main

import "fmt"

func lengthOfLongestSubstring(s string) int {
	charSet := make(map[byte]bool)
	left := 0
	maxLen := 0

	for right := 0; right < len(s); right++ {
		for charSet[s[right]] {
			delete(charSet, s[left])
			left++
		}
		charSet[s[right]] = true
		if right-left+1 > maxLen {
			maxLen = right - left + 1
		}
	}

	return maxLen
}

func main() {
	fmt.Println(lengthOfLongestSubstring("abcabcbb")) // => 3
	fmt.Println(lengthOfLongestSubstring("bbbbb"))    // => 1
	fmt.Println(lengthOfLongestSubstring("pwwkew"))   // => 3
}
```

---

## 📌 ポイントまとめ

| ポイント                 | 説明                                               |
| ------------------------ | -------------------------------------------------- |
| 部分文字列（substring）  | 連続した文字列（抜けない）                         |
| 重複を避ける             | Set（Ruby なら `Set.new`）で管理                   |
| スライディングウィンドウ | 左右のポインタを使って範囲を管理                   |
| 計算量                   | 時間 O(n), 空間 O(n)（最大で全文字をセットに保持） |

---

## ✅ 結論

- **重複しないように、必要なら `left` を進めて調整する**
- **今のウィンドウの長さが最大なら更新する**
- 最長の重複なし部分文字列を `O(n)` 時間で見つけることができる！

---
