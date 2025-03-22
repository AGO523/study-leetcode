# この問題を **Ruby, TypeScript, Go** で解決するコードを作成しました。

# ---

# ## **問題の日本語訳**
# 整数の配列 `nums` と整数 `target` が与えられたとき、合計が `target` となる2つの数のインデックスを返してください。

# **条件**
# - 各入力には **必ず1つの解** があります。
# - **同じ要素を2回使ってはいけません**。
# - **答えの順序は自由**。

# ---

# ## **解法**
# この問題を解く方法は **2つ** あります。

# ### **1. ブルートフォース（O(n²)）**
# - **全ての組み合わせ** を試す → `nums[i] + nums[j] == target` をチェック。
# - `O(n²)` なので、大きな配列では遅い。

# ### **2. ハッシュマップを使った方法（O(n)）** ✅ **推奨**
# - 各数字を `hashMap` に記録し、`target - num` が `hashMap` にあるか調べる。
# - `O(n)` で高速。

# ---

# ## **実装**

# ### **Ruby**
# ```ruby
def two_sum(nums, target)
  hash = {}
  
  nums.each_with_index do |num, index|
    complement = target - num
    return [hash[complement], index] if hash.key?(complement)
    
    # 次のループで使うために記録
    # 例: { 2 => 0, 7 => 1, 11 => 2, 15 => 3 }
    # 元のnumsの数字に対応するインデックスを記録
    # 最終的に返すのはインデックスなので、数字をキーにしてインデックスを記録
    hash[num] = index
  end
end

# テスト
puts two_sum([2, 7, 11, 15], 9).inspect # [0, 1]
puts two_sum([3, 2, 4], 6).inspect      # [1, 2]
puts two_sum([3, 3], 6).inspect         # [0, 1]
# ```

# ### **TypeScript**
# ```typescript
# function twoSum(nums: number[], target: number): number[] {
#     const map = new Map<number, number>();

#     for (let i = 0; i < nums.length; i++) {
#         const complement = target - nums[i];

#         if (map.has(complement)) {
#             return [map.get(complement)!, i];
#         }

#         map.set(nums[i], i);
#     }

#     return [];
# }

# // テスト
# console.log(twoSum([2, 7, 11, 15], 9)); // [0, 1]
# console.log(twoSum([3, 2, 4], 6));      // [1, 2]
# console.log(twoSum([3, 3], 6));         // [0, 1]
# ```

# ### **Go**
# ```go
# package main

# import (
# 	"fmt"
# )

# func twoSum(nums []int, target int) []int {
# 	hash := make(map[int]int)

# 	for i, num := range nums {
# 		complement := target - num
# 		if index, exists := hash[complement]; exists {
# 			return []int{index, i}
# 		}
# 		hash[num] = i
# 	}

# 	return nil
# }

# func main() {
# 	fmt.Println(twoSum([]int{2, 7, 11, 15}, 9)) // [0, 1]
# 	fmt.Println(twoSum([]int{3, 2, 4}, 6))      // [1, 2]
# 	fmt.Println(twoSum([]int{3, 3}, 6))         // [0, 1]
# }
# ```

# ---

# ## **時間計算量**
# | 方法 | 計算量 | メリット | デメリット |
# |------|--------|----------|------------|
# | **ブルートフォース (2重ループ)** | **O(n²)** | 実装が簡単 | 遅い |
# | **ハッシュマップ** | **O(n)** ✅ | 高速 | 少しコードが長い |

# **`O(n)` のハッシュマップを使う方法が最適！** 🚀
