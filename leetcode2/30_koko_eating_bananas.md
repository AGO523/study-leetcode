### 🔍 問題の日本語訳

Koko はバナナを食べるのが大好きです。バナナの山が `n` 個あり、`piles[i]` は i 番目の山にあるバナナの数です。警備員が戻ってくるまでに `h` 時間しかありません。

Koko は 1 時間あたり `k` 本のスピードでバナナを食べることができます。ただし、1 時間に 1 つの山からしか食べられません。もしその山に `k` 本未満しかなければ、その山の全てを食べて、1 時間休みます。

Koko はなるべくゆっくり食べたいと考えていますが、警備員が戻ってくるまでにすべて食べきる必要があります。

**最小の k を求めてください。**

---

### 🧠 アルゴリズムの考え方

- 各 `k` に対して、バナナ全体を `h` 時間以内に食べ切れるかを判定できる。
- したがって、この問題は **二分探索** で解けます。

#### ステップ

1. `k` の最小値は 1、最大値は `piles.max`。
2. 二分探索を使って、ある `k` で食べ切れるかを判定。
3. 条件を満たす中で最小の `k` を見つける。

---

## ✅ Ruby 解説付きコード

```ruby
# 入力: piles = [3,6,7,11], h = 8
# 出力: 4

def min_eating_speed(piles, h)
  # 二分探索の範囲（最小スピードは1、最大はpileの最大値）
  left = 1
  right = piles.max

  while left < right
    mid = (left + right) / 2

    # 与えられたmidのスピードで食べたときの合計時間を計算
    # [3, 6, 7, 11].sum { |x| x * 2 } # => 54
    # pile.to_f：山のバナナの数を 小数 に変換します（割り算で小数になるため）。
    # / mid：1時間に mid 本食べるとして、何時間かかるかを計算。
    # .ceil：小数を切り上げて整数にする。
    hours = piles.sum { |pile| (pile.to_f / mid).ceil }

    # 時間内に食べきれるなら、スピードを落としてみる
    if hours <= h
      right = mid
    else
      left = mid + 1
    end
  end

  left
end
```

### 🧾 解説（初心者向け）

- `piles.sum { |pile| (pile.to_f / mid).ceil }` は、1 つの山を `mid` 本/時間で食べたときにかかる時間。
  - 例: `pile = 7, mid = 4` のとき → `7 / 4 = 1.75` → 切り上げて 2 時間
- 各山でかかる時間を合計し、それが `h` 以下かどうかで判定。
- 条件を満たすなら、もっと遅く食べられないかを試すため、右側を狭める。

---

## ✅ TypeScript 版

```ts
function minEatingSpeed(piles: number[], h: number): number {
  let left = 1;
  let right = Math.max(...piles);

  while (left < right) {
    const mid = Math.floor((left + right) / 2);
    const hours = piles.reduce((sum, pile) => sum + Math.ceil(pile / mid), 0);

    if (hours <= h) {
      right = mid;
    } else {
      left = mid + 1;
    }
  }

  return left;
}
```

---

## ✅ Go 版

```go
import "math"

func minEatingSpeed(piles []int, h int) int {
    left, right := 1, max(piles)

    for left < right {
        mid := (left + right) / 2
        hours := 0
        for _, pile := range piles {
            hours += int(math.Ceil(float64(pile) / float64(mid)))
        }
        if hours <= h {
            right = mid
        } else {
            left = mid + 1
        }
    }

    return left
}

func max(nums []int) int {
    m := nums[0]
    for _, v := range nums {
        if v > m {
            m = v
        }
    }
    return m
}
```
