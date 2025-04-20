この問題は、「**時間ごとに記録されるキーと値を管理し、指定した時間以前の直近の値を取得する**」という典型的な問題です。

---

## 📘 問題の要点

### 要件：

- 同じキーに対して**複数の値を異なる時刻で保存**できる。
- 指定された時刻以前の中で最も**近い時刻の値を取得**する必要がある。
- 時刻（timestamp）は `set` のたびに **単調増加**（昇順）

### 解決のコツ：

- 各キーに対して、**(timestamp, value)** のペアを**昇順で保存**
- `get(key, timestamp)` のとき、**timestamp 以下で最大の timestamp を探す**  
  → **二分探索** を使えば O(log n) で高速！

---

## ✅ Ruby 版（詳細解説付き）

```ruby
class TimeMap
  def initialize
    # 各キーごとに [ [timestamp, value], ... ] を格納
    @store = Hash.new { |h, k| h[k] = [] }
  end

  def set(key, value, timestamp)
    @store[key] << [timestamp, value]
  end

  def get(key, timestamp)
    return "" unless @store.key?(key)

    entries = @store[key]
    left = 0
    right = entries.size - 1
    res = ""

    while left <= right
      mid = (left + right) / 2
      time, val = entries[mid]

      if time <= timestamp
        res = val       # 一旦この値を候補にする
        left = mid + 1  # さらに後ろの時間も探してみる
      else
        right = mid - 1
      end
    end

    res
  end
end
```

---

## 🔍 解説：初心者向けポイント

### set(key, value, timestamp)

- ただ配列に `[timestamp, value]` を追加
- 時間は **昇順にしか追加されない** ので、毎回 push で OK！

---

### get(key, timestamp)

- timestamp 以下で最も近い時間の値を取得する必要がある
- **二分探索**で `[timestamp, value]` のペアを探索
- `time <= timestamp` なら値を候補にしつつ、もっと後ろの時間を探す

---

## ✅ TypeScript 版

```ts
class TimeMap {
  private store: Map<string, [number, string][]> = new Map();

  set(key: string, value: string, timestamp: number): void {
    if (!this.store.has(key)) this.store.set(key, []);
    this.store.get(key)!.push([timestamp, value]);
  }

  get(key: string, timestamp: number): string {
    if (!this.store.has(key)) return "";
    const entries = this.store.get(key)!;

    let left = 0,
      right = entries.length - 1;
    let result = "";

    while (left <= right) {
      const mid = Math.floor((left + right) / 2);
      const [time, val] = entries[mid];
      if (time <= timestamp) {
        result = val;
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return result;
  }
}
```

---

## ✅ Go 版

```go
type TimeMap struct {
	store map[string][][2]interface{} // [timestamp, value]
}

func Constructor() TimeMap {
	return TimeMap{store: make(map[string][][2]interface{})}
}

func (tm *TimeMap) Set(key string, value string, timestamp int) {
	tm.store[key] = append(tm.store[key], [2]interface{}{timestamp, value})
}

func (tm *TimeMap) Get(key string, timestamp int) string {
	entries, ok := tm.store[key]
	if !ok {
		return ""
	}

	left, right := 0, len(entries)-1
	res := ""

	for left <= right {
		mid := (left + right) / 2
		if entries[mid][0].(int) <= timestamp {
			res = entries[mid][1].(string)
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return res
}
```

---

## ✅ 実行例

```ruby
time_map = TimeMap.new
time_map.set("foo", "bar", 1)
time_map.get("foo", 1)    # => "bar"
time_map.get("foo", 3)    # => "bar"
time_map.set("foo", "bar2", 4)
time_map.get("foo", 4)    # => "bar2"
time_map.get("foo", 5)    # => "bar2"
```
