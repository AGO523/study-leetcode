### 🇯🇵 問題の日本語訳

昇順にソートされた整数配列 `nums` が、ある未知のインデックス `k`（1 ≦ k < nums.length）で回転されているかもしれません。  
例えば `[0,1,2,4,5,6,7]` が `k = 3` で回転されると `[4,5,6,7,0,1,2]` になります。

このような回転された配列と、整数 `target` が与えられたとき、  
🔍 `target` のインデックスを返してください（存在しない場合は `-1` を返す）。

---

### 🎯 条件

- 必ず **O(log n)** の計算時間で解く必要があります（つまり **二分探索**）。

---

### 🧠 アルゴリズムの考え方（O(log n)）

配列は以下のように回転されています：

```
[4,5,6,7,0,1,2]
 ↑     ↑
 大きい   小さい（最小値）
```

このように、**2 つの「ソートされた領域」** に分かれているのがポイントです！

---

## ✅ 解法ステップ

1. **普通の二分探索のように left, right を設定**
2. mid を計算し、`nums[mid]` と `target` の位置関係を評価
3. 配列のどちら側がソートされているかを見極め、
4. 対象がその中にあるかで探索範囲を絞る！

---

## ✅ Ruby 版（詳しいコメント付き）

```ruby
def search(nums, target)
  left = 0
  right = nums.size - 1

  while left <= right
    mid = (left + right) / 2

    # 見つけたら即 return
    return mid if nums[mid] == target

    # 左側がソートされている場合
    if nums[left] <= nums[mid]
      # 左側の範囲内に target があるか確認
      if nums[left] <= target && target < nums[mid]
        # target はソート済み左側にいる
        right = mid - 1
      else
        # target は右側にいる
        left = mid + 1
      end
    else
      # 右側がソートされている場合
      # 右側の範囲内に target があるか確認
      if nums[mid] < target && target <= nums[right]
        # target はソート済み右側にいる
        left = mid + 1
      else
        # target は左側にいる
        right = mid - 1
      end
    end
  end

  -1 # 見つからなかった場合
end
```

---

## ✅ TypeScript 版

```ts
function search(nums: number[], target: number): number {
  let left = 0,
    right = nums.length - 1;

  while (left <= right) {
    const mid = Math.floor((left + right) / 2);
    if (nums[mid] === target) return mid;

    if (nums[left] <= nums[mid]) {
      // 左半分がソートされている
      if (nums[left] <= target && target < nums[mid]) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    } else {
      // 右半分がソートされている
      if (nums[mid] < target && target <= nums[right]) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
  }

  return -1;
}
```

---

## ✅ Go 版

```go
func search(nums []int, target int) int {
    left, right := 0, len(nums)-1

    for left <= right {
        mid := (left + right) / 2

        if nums[mid] == target {
            return mid
        }

        if nums[left] <= nums[mid] {
            // 左側がソートされている
            if nums[left] <= target && target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else {
            // 右側がソートされている
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }

    return -1
}
```

---

## 🔍 例で確認（Ruby）

```ruby
nums = [4,5,6,7,0,1,2]
target = 0
# → 出力: 4
```

- mid = 3 → nums[3] = 7
- 左側はソートされてる（4 ≤ 7）
- でも target = 0 は含まれてない → 右側へ！

---

### 💡 ポイントまとめ

- ソートされている側を見極めて、探索する側を決める！
- 二分探索のように常に探索範囲を絞っていく！
- `nums[mid] == target` を最初に判定して return！
