### 問題文の日本語訳

2 つの文字列 `s`（長さ m）と `t`（長さ n）が与えられたとき、`t` に含まれるすべての文字（重複を含む）を含む `s` の最小の部分文字列（ウィンドウ）を返してください。  
そのような部分文字列が存在しない場合は、空文字列 `""` を返します。

> **例 1**  
> 入力: s = "ADOBECODEBANC", t = "ABC"  
> 出力: "BANC"
>
> **例 2**  
> 入力: s = "a", t = "a"  
> 出力: "a"
>
> **例 3**  
> 入力: s = "a", t = "aa"  
> 出力: ""

---

### 問題の概要と考え方

この問題は「**スライディングウィンドウ**」と「**ハッシュマップによるカウント管理**」を組み合わせて解くのが定番です。

#### アルゴリズムの流れ（初心者向け）:

1. `t` に含まれる各文字の必要な個数を記録する（ハッシュマップ `need` を作る）。
2. スライディングウィンドウ（開始位置 `left`, 終了位置 `right`）を使って `s` を走査。
3. ウィンドウ内の文字の出現頻度を `window` というハッシュマップでカウント。
4. ウィンドウ内に `t` に必要な文字がすべて含まれていたら、可能な限り `left` を右に移動して、最小のウィンドウを探す。
5. 最小ウィンドウの長さと位置を記録して、最終的にその部分文字列を返す。

---

### Ruby の実装（解説付き）

```ruby
def min_window(s, t)
  return "" if s.empty? || t.empty?

  need = Hash.new(0)
  t.each_char { |char| need[char] += 1 }

  window = Hash.new(0)   # 現在のウィンドウ内の文字のカウント
  left = right = 0       # ウィンドウの左右の境界
  valid = 0              # 条件を満たしている文字数（種類ベース）
  min_len = Float::INFINITY  # 最小のウィンドウサイズ
  start = 0              # 最小ウィンドウの開始位置

  # 右端を動かしながらウィンドウを広げる
  while right < s.length
    c = s[right]
    right += 1
    if need[c]
      # 必要な文字だったら window にカウントして、条件を満たしたら valid += 1
      window[c] += 1
      valid += 1 if window[c] == need[c]
    end

    # ウィンドウが条件を満たしている間、左端を動かして最小ウィンドウを探す
    while valid == need.keys.size
      if right - left < min_len
        min_len = right - left
        start = left
      end

      d = s[left]
      left += 1

      # left を1つ進めたことで、条件を満たさなくなったら valid を減らす
      if need[d]
        valid -= 1 if window[d] == need[d]
        window[d] -= 1
      end
    end
  end

  min_len == Float::INFINITY ? "" : s[start, min_len]
end
```

#### ポイント:

- `need` は `t` の必要な文字とその個数を記録します。
- `window` は現在のスライディングウィンドウの中での文字の出現数を管理します。
- `valid` は `window` において `need` の条件を満たしている文字の数をカウントします。

---

### TypeScript の実装

```ts
function minWindow(s: string, t: string): string {
  if (s.length === 0 || t.length === 0) return "";

  const need = new Map<string, number>();
  for (const char of t) {
    need.set(char, (need.get(char) || 0) + 1);
  }

  const window = new Map<string, number>();
  let left = 0,
    right = 0;
  let valid = 0;
  let start = 0,
    minLen = Infinity;

  while (right < s.length) {
    const c = s[right];
    right++;
    if (need.has(c)) {
      window.set(c, (window.get(c) || 0) + 1);
      if (window.get(c) === need.get(c)) valid++;
    }

    while (valid === need.size) {
      if (right - left < minLen) {
        minLen = right - left;
        start = left;
      }

      const d = s[left];
      left++;
      if (need.has(d)) {
        if (window.get(d) === need.get(d)) valid--;
        window.set(d, window.get(d)! - 1);
      }
    }
  }

  return minLen === Infinity ? "" : s.substring(start, start + minLen);
}
```

---

### Go の実装

```go
func minWindow(s string, t string) string {
	if len(s) == 0 || len(t) == 0 {
		return ""
	}

	need := make(map[byte]int)
	for i := 0; i < len(t); i++ {
		need[t[i]]++
	}

	window := make(map[byte]int)
	left, right := 0, 0
	valid := 0
	start, minLen := 0, len(s)+1

	for right < len(s) {
		c := s[right]
		right++
		if _, ok := need[c]; ok {
			window[c]++
			if window[c] == need[c] {
				valid++
			}
		}

		for valid == len(need) {
			if right-left < minLen {
				start = left
				minLen = right - left
			}
			d := s[left]
			left++
			if _, ok := need[d]; ok {
				if window[d] == need[d] {
					valid--
				}
				window[d]--
			}
		}
	}

	if minLen == len(s)+1 {
		return ""
	}
	return s[start : start+minLen]
}
```
