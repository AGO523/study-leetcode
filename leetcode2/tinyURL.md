### **TinyURL の設計と実装**

この問題は、URL 短縮サービス **TinyURL** を設計・実装する問題です。  
エンコード（短縮）とデコード（元の URL 復元）の両方を実装する必要があります。

---

## **1. アプローチ**

URL を短縮する方法は **一意な識別子を作る** 必要があります。  
以下の 2 つのアプローチが考えられます。

### **🔹 方法 1: ハッシュマップを使用**

1. **エンコード（短縮 URL 生成）**
   - URL ごとに一意なキー（`ID`）を割り当てる。
   - `ID` は `UUID` や `Base62` で生成できる。
   - ハッシュマップに `{ 短縮URL: 元のURL }` を保存。
2. **デコード（元の URL に復元）**
   - 短縮 URL から `ID` を取り出し、ハッシュマップで元の URL を検索。

💡 **利点:** シンプル・短縮 URL の一意性が保証される  
💡 **欠点:** メモリを消費する（DB が必要）

---

### **🔹 方法 2: ハッシュ関数を使用**

1. **エンコード**
   - `SHA256` や `MD5` などのハッシュ関数を用いて URL を短縮。
   - `Base62`（62 進数変換）で短縮化。
2. **デコード**
   - ハッシュ値から元の URL を復元（ただし、衝突があるため難しい）

💡 **利点:** ストレージ不要  
💡 **欠点:** 衝突が起きる可能性がある（同じ短縮 URL が異なる URL にマッピングされる可能性）

---

## **2. Ruby, TypeScript, Go での実装**

### **🔹 Ruby**

```ruby
require 'securerandom'

class Solution
  def initialize
    @url_map = {} # 短縮URLを元のURLに対応させるハッシュマップ
    @base_url = "http://tinyurl.com/"
  end

  def encode(long_url)
    short_key = SecureRandom.alphanumeric(6) # 6文字のランダムキー
    short_url = @base_url + short_key
    @url_map[short_url] = long_url
    short_url
  end

  def decode(short_url)
    @url_map[short_url] || ""
  end
end

# テスト
obj = Solution.new
url = "https://leetcode.com/problems/design-tinyurl"
tiny = obj.encode(url)
puts tiny # 短縮URL
puts obj.decode(tiny) # 元のURL
```

**🔹 解説**

- `SecureRandom.alphanumeric(6)` でランダムな 6 文字のキーを生成。
- `@url_map` に **{ 短縮 URL => 元の URL }** を保存。
- `decode` で短縮 URL を元の URL に復元。

---

### **🔹 TypeScript**

```typescript
class Solution {
  private urlMap: Map<string, string>;
  private baseUrl: string;

  constructor() {
    this.urlMap = new Map<string, string>();
    this.baseUrl = "http://tinyurl.com/";
  }

  encode(longUrl: string): string {
    const shortKey = Math.random().toString(36).substring(2, 8); // 6文字のランダムキー
    const shortUrl = this.baseUrl + shortKey;
    this.urlMap.set(shortUrl, longUrl);
    return shortUrl;
  }

  decode(shortUrl: string): string {
    return this.urlMap.get(shortUrl) || "";
  }
}

// テスト
const obj = new Solution();
const url = "https://leetcode.com/problems/design-tinyurl";
const tiny = obj.encode(url);
console.log(tiny); // 短縮URL
console.log(obj.decode(tiny)); // 元のURL
```

**🔹 解説**

- `Math.random().toString(36).substring(2, 8)` でランダムな 6 文字のキーを生成。
- `Map<string, string>` で **{ 短縮 URL => 元の URL }** を管理。
- `decode` でマップから元の URL を取得。

---

### **🔹 Go**

```go
package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Solution struct {
	urlMap   map[string]string
	baseUrl  string
}

func NewSolution() *Solution {
	rand.Seed(time.Now().UnixNano())
	return &Solution{
		urlMap:  make(map[string]string),
		baseUrl: "http://tinyurl.com/",
	}
}

func (s *Solution) encode(longUrl string) string {
	shortKey := randomString(6)
	shortUrl := s.baseUrl + shortKey
	s.urlMap[shortUrl] = longUrl
	return shortUrl
}

func (s *Solution) decode(shortUrl string) string {
	if longUrl, exists := s.urlMap[shortUrl]; exists {
		return longUrl
	}
	return ""
}

func randomString(n int) string {
	const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	result := make([]byte, n)
	for i := range result {
		result[i] = letters[rand.Intn(len(letters))]
	}
	return string(result)
}

func main() {
	obj := NewSolution()
	url := "https://leetcode.com/problems/design-tinyurl"
	tiny := obj.encode(url)
	fmt.Println(tiny)        // 短縮URL
	fmt.Println(obj.decode(tiny)) // 元のURL
}
```

**🔹 解説**

- `rand.Seed(time.Now().UnixNano())` でランダムシードを設定。
- `randomString(6)` で 6 文字のランダムキーを生成。
- `map[string]string` で **{ 短縮 URL => 元の URL }** を保存。

---

## **3. 設計のポイント**

| 設計                       | 方法                | メリット              | デメリット                |
| -------------------------- | ------------------- | --------------------- | ------------------------- |
| **ハッシュマップ方式**     | `Map` / `Hash`      | 一意な短縮 URL を確保 | メモリ使用が多い          |
| **ハッシュ関数方式**       | `SHA256` や `MD5`   | データベース不要      | 衝突の可能性あり          |
| **インクリメント ID 方式** | `ID++` を短縮キーに | 簡単に一意性を確保    | 短縮 URL が推測されやすい |

---

## **4. 最適な方法は？**

1. **小規模なら** → `HashMap` 方式が最もシンプルで確実。
2. **大規模なら** → `DB` を使用し `Base62` や `UUID` 方式にする。
3. **セキュリティを考慮するなら** → `HMAC + Base62` で短縮 URL を生成。

💡 **実際のサービスでは、データベースを活用して `Base62` で短縮 URL を生成する方法が多い！** 🚀
