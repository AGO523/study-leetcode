## **解法: 文字列が回文（Palindrome）かどうかを判定**

この問題では、以下の処理を行った後に回文かどうかを判定します。

1. **大文字を小文字に変換**
2. **英数字（アルファベット・数字）以外の文字を削除**
3. **前から読んでも後ろから読んでも同じなら `true` を返す**

---

## **解法のアプローチ**

### **1. 文字列の前処理**

- **`downcase`** で小文字に変換
- **正規表現 `gsub(/[^a-z0-9]/, '')`** で英数字以外を削除

### **2. 回文チェック**

- 文字列を逆順にして一致するか確認 (`s == s.reverse`)
- または **2 ポインタ法** を使う（左右から 1 文字ずつ比較）

---

## **1. Ruby の実装**

```ruby
def is_palindrome(s)
  clean_s = s.downcase.gsub(/[^a-z0-9]/, '') # 前処理
  clean_s == clean_s.reverse # 回文チェック
end

# テスト
p is_palindrome("A man, a plan, a canal: Panama")  # true
p is_palindrome("race a car")  # false
p is_palindrome(" ")  # true
```

### **🔹 解説**

1. `s.downcase` で小文字に統一
2. `.gsub(/[^a-z0-9]/, '')` で **英数字以外を削除**
3. `.reverse` して元の文字列と比較

✅ **O(n) 時間で処理可能！**

---

## **2. TypeScript の実装**

```typescript
function isPalindrome(s: string): boolean {
  const cleanS = s.toLowerCase().replace(/[^a-z0-9]/g, ""); // 前処理
  return cleanS === cleanS.split("").reverse().join(""); // 回文チェック
}

// テスト
console.log(isPalindrome("A man, a plan, a canal: Panama")); // true
console.log(isPalindrome("race a car")); // false
console.log(isPalindrome(" ")); // true
```

### **🔹 解説**

1. `s.toLowerCase()` で小文字化
2. `.replace(/[^a-z0-9]/g, "")` で英数字以外を削除
3. `.split("").reverse().join("")` で逆順にして比較

✅ **JavaScript/TypeScript でも `O(n)` で解ける！**

---

## **3. Go の実装**

```go
package main

import (
	"fmt"
	"regexp"
	"strings"
)

func isPalindrome(s string) bool {
	// 小文字変換
	s = strings.ToLower(s)

	// 英数字以外を削除
	re := regexp.MustCompile("[^a-z0-9]")
	s = re.ReplaceAllString(s, "")

	// 逆順にして比較
	n := len(s)
	for i := 0; i < n/2; i++ {
		if s[i] != s[n-1-i] {
			return false
		}
	}
	return true
}

func main() {
	fmt.Println(isPalindrome("A man, a plan, a canal: Panama"))  // true
	fmt.Println(isPalindrome("race a car"))  // false
	fmt.Println(isPalindrome(" "))  // true
}
```

### **🔹 解説**

1. `strings.ToLower(s)` で小文字変換
2. `regexp.MustCompile("[^a-z0-9]")` で英数字以外を削除
3. **2 ポインタ法 (`O(n)`) で回文をチェック**

✅ **`O(n)` で最適！Go では `reverse` がないので 2 ポインタ法を採用。**

---

## **4. 計算量分析**

| 方法                                      | 時間計算量 | 空間計算量 |
| ----------------------------------------- | ---------- | ---------- |
| **`reverse` を使う方法**                  | **O(n)**   | **O(n)**   |
| **2 ポインタ法 (`while` で左右から比較)** | **O(n)**   | **O(1)**   |

**結論:**

- **メモリを節約したいなら `2ポインタ法` (`O(1)` 空間)**
- **シンプルに書くなら `reverse` を使う (`O(n)` 空間)**

💡 **データが `10^5` 以上なら、2 ポインタ法を推奨！** 🚀
