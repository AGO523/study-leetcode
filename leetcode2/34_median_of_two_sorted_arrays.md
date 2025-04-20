### 🇯🇵 問題の概要（日本語訳）

2 つのソートされた配列 `nums1` と `nums2` が与えられます。これらの配列の **中央値（median）** を求めなさい。  
全体の実行時間計算量は **O(log(m+n))** である必要があります。

---

### 📌 考え方

この問題は、単に 2 つの配列を結合してソートするのではなく、**O(log(m+n))** の時間計算量が求められているため、**二分探索を使って効率的に中央値を探す方法**が必要です。

具体的には、以下のような考え方をします：

- 小さい方の配列に対して **バイナリサーチ** を行い、「左半分の最大値」と「右半分の最小値」が整合しているかを確認します。
- 「分割後の左側の最大値 <= 分割後の右側の最小値」なら、それが中央値候補です。
- 配列の合計長が奇数か偶数かで中央値の求め方が異なります。

---

### 🧠 アルゴリズム概要

1. `nums1` が常に短い配列になるように交換する。
2. `nums1` に対してバイナリサーチ。
3. 分割位置を決めて、`nums1` と `nums2` をそれぞれ左右に分ける。
4. 左の最大値と右の最小値を比べて、条件を満たすか確認。
5. 満たせば中央値を返す。満たさないならバイナリサーチを続ける。

---

## 🧪 Ruby 実装（詳しい解説付き）

```ruby
def find_median_sorted_arrays(nums1, nums2)
  # 常に nums1 の方が短い配列になるようにする
  nums1, nums2 = nums2, nums1 if nums1.length > nums2.length

  m, n = nums1.length, nums2.length
  imin, imax = 0, m
  half_len = (m + n + 1) / 2

  while imin <= imax
    i = (imin + imax) / 2
    j = half_len - i

    if i < m && nums2[j - 1] > nums1[i]
      # i が小さすぎるので右に動かす
      imin = i + 1
    elsif i > 0 && nums1[i - 1] > nums2[j]
      # i が大きすぎるので左に動かす
      imax = i - 1
    else
      # i はちょうど良い位置にある

      # 左側の最大値を求める
      max_of_left = if i == 0
                      nums2[j - 1]
                    elsif j == 0
                      nums1[i - 1]
                    else
                      [nums1[i - 1], nums2[j - 1]].max
                    end

      # 配列の合計が奇数なら、そのまま中央値
      return max_of_left.to_f if (m + n).odd?

      # 右側の最小値を求める
      min_of_right = if i == m
                       nums2[j]
                     elsif j == n
                       nums1[i]
                     else
                       [nums1[i], nums2[j]].min
                     end

      return (max_of_left + min_of_right) / 2.0
    end
  end

  0.0 # 不正ケース（保証されない）
end
```

---

## 🟦 TypeScript 実装

```ts
function findMedianSortedArrays(nums1: number[], nums2: number[]): number {
  if (nums1.length > nums2.length) {
    [nums1, nums2] = [nums2, nums1];
  }

  const m = nums1.length;
  const n = nums2.length;
  let imin = 0,
    imax = m;
  const halfLen = Math.floor((m + n + 1) / 2);

  while (imin <= imax) {
    const i = Math.floor((imin + imax) / 2);
    const j = halfLen - i;

    if (i < m && nums2[j - 1] > nums1[i]) {
      imin = i + 1;
    } else if (i > 0 && nums1[i - 1] > nums2[j]) {
      imax = i - 1;
    } else {
      const maxOfLeft =
        i === 0
          ? nums2[j - 1]
          : j === 0
          ? nums1[i - 1]
          : Math.max(nums1[i - 1], nums2[j - 1]);

      if ((m + n) % 2 === 1) return maxOfLeft;

      const minOfRight =
        i === m ? nums2[j] : j === n ? nums1[i] : Math.min(nums1[i], nums2[j]);

      return (maxOfLeft + minOfRight) / 2;
    }
  }

  return 0;
}
```

---

## 🟨 Go 実装

```go
func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
    if len(nums1) > len(nums2) {
        return findMedianSortedArrays(nums2, nums1)
    }

    m, n := len(nums1), len(nums2)
    imin, imax := 0, m
    halfLen := (m + n + 1) / 2

    for imin <= imax {
        i := (imin + imax) / 2
        j := halfLen - i

        if i < m && nums2[j-1] > nums1[i] {
            imin = i + 1
        } else if i > 0 && nums1[i-1] > nums2[j] {
            imax = i - 1
        } else {
            var maxLeft int
            if i == 0 {
                maxLeft = nums2[j-1]
            } else if j == 0 {
                maxLeft = nums1[i-1]
            } else {
                maxLeft = max(nums1[i-1], nums2[j-1])
            }

            if (m+n)%2 == 1 {
                return float64(maxLeft)
            }

            var minRight int
            if i == m {
                minRight = nums2[j]
            } else if j == n {
                minRight = nums1[i]
            } else {
                minRight = min(nums1[i], nums2[j])
            }

            return float64(maxLeft+minRight) / 2.0
        }
    }

    return 0.0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```
