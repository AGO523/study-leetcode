この問題は「**文字列の中から、最大 `k` 回まで文字を他の文字に置き換えることで、** 同じ文字だけからなる最長の部分文字列の長さを求めよ」というものです。

---

## ✅ 要点整理

- 与えられた文字列 `s` は **大文字アルファベットのみ**
- **最大 `k` 回** の文字変更が許されている
- **目的**は「**同じ文字の連続部分列の最長長さ**」を作ること

---

## 🧠 アルゴリズムの考え方（スライディングウィンドウ）

### ✨ コアアイデア

ウィンドウ内で最も頻度の高い文字をベースに、それ以外を変えて一致させる、という考え方です。

- **ウィンドウのサイズ - 最頻出文字の数 > k** なら → ウィンドウが成立しない（変える量が多すぎる）
- なので、「**変える必要のある文字数が k 以下である最大のウィンドウ**」を常に追いかける

---

## 🔁 アルゴリズム手順

1. ウィンドウの左端 `left` と右端 `right` を定義
2. ウィンドウ内の各文字の出現回数をカウント（`count`）
3. 現在のウィンドウ内の **最も多く出現している文字数** を記録（`max_count`）
4. ウィンドウサイズ `right - left + 1` から `max_count` を引いた値が **k を超えたら左端を動かす**
5. 常にウィンドウサイズの最大を更新していく

---

## 💎 Ruby 実装

```ruby
def character_replacement(s, k)
  counts = Hash.new(0)
  left = 0
  max_count = 0
  max_length = 0

  s.chars.each_with_index do |char, right|
    counts[char] += 1
    max_count = [max_count, counts[char]].max

    # ウィンドウ内で置き換えが必要な文字数が k を超えたら縮める
    if (right - left + 1) - max_count > k
      counts[s[left]] -= 1
      left += 1
    end

    max_length = [max_length, right - left + 1].max
  end

  max_length
end

# テスト
p character_replacement("ABAB", 2)      # => 4
p character_replacement("AABABBA", 1)   # => 4
```

---

## 💻 TypeScript 実装

```typescript
function characterReplacement(s: string, k: number): number {
  const count: Record<string, number> = {};
  let left = 0,
    maxCount = 0,
    maxLength = 0;

  for (let right = 0; right < s.length; right++) {
    const char = s[right];
    count[char] = (count[char] || 0) + 1;
    maxCount = Math.max(maxCount, count[char]);

    if (right - left + 1 - maxCount > k) {
      count[s[left]]--;
      left++;
    }

    maxLength = Math.max(maxLength, right - left + 1);
  }

  return maxLength;
}

// テスト
console.log(characterReplacement("ABAB", 2)); // => 4
console.log(characterReplacement("AABABBA", 1)); // => 4
```

---

## 🐹 Go 実装

```go
package main

import "fmt"

func characterReplacement(s string, k int) int {
	count := make(map[byte]int)
	left, maxCount, maxLen := 0, 0, 0

	for right := 0; right < len(s); right++ {
		count[s[right]]++
		if count[s[right]] > maxCount {
			maxCount = count[s[right]]
		}

		if (right - left + 1 - maxCount) > k {
			count[s[left]]--
			left++
		}

		if right-left+1 > maxLen {
			maxLen = right - left + 1
		}
	}

	return maxLen
}

func main() {
	fmt.Println(characterReplacement("ABAB", 2))      // => 4
	fmt.Println(characterReplacement("AABABBA", 1))   // => 4
}
```

---

## 📝 ポイントまとめ

| ポイント         | 内容                                               |
| ---------------- | -------------------------------------------------- |
| 最頻文字         | ウィンドウ内で最も出現した文字（変える必要がない） |
| `k`              | 他の文字を何文字まで変えていいかの上限             |
| ウィンドウの条件 | `(right - left + 1) - max_count <= k`              |
| 計算量           | 時間 O(n), 空間 O(1)（英大文字のみ → 26 文字固定） |

---
