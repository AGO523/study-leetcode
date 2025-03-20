Given an integer array nums and an integer k, return the kth largest element in the array.

Note that it is the kth largest element in the sorted order, not the kth distinct element.

Can you solve it without sorting?

整数の配列 nums と整数 k が与えられたとき、配列内でk番目に大きい要素を返してください。

注意：ここで求めるのは、ソートした順序でのk番目に大きい要素であり、異なる要素だけを数えるわけではありません。

ソートせずに解くことができますか？

Example 1:

Input: nums = [3,2,1,5,6,4], k = 2
Output: 5
Example 2:

Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
Output: 4
 

Constraints:

1 <= k <= nums.length <= 105
-104 <= nums[i] <= 104

解説
この問題では、与えられた配列の中でk番目に大きい要素を見つけることが目的です。単純にソートしてからk番目を取り出すこともできますが、ソートの時間計算量は O(n log n) となり、大きな配列では効率的ではありません。

そこで、ヒープを使って効率的に O(n log k) で解く方法を説明します。具体的には、最小ヒープを使い、ヒープのサイズが k になるように管理します。

アプローチ
最小ヒープを使用：
k 番目に大きい要素を見つけるには、最小ヒープを使います。
ヒープのサイズが k になるまで、配列の要素をヒープに追加していきます。
もしヒープのサイズが k を超えた場合、最小の要素を取り除きます。これにより、最小ヒープには常にk個の要素が残り、その中で最小の要素がk番目に大きい要素となります。

class KthLargestElement
  def find_kth_largest(nums, k)
    # 最小ヒープを表す配列を初期化（配列をヒープとして使用）
    min_heap = []

    # 配列の要素をヒープに追加
    nums.each do |num|
      # ヒープに要素を追加
      min_heap.push(num)
      
      # ヒープを常に最小の順に並べる
      min_heap.sort!

      # ヒープのサイズがkを超えたら最小の要素を削除
      if min_heap.size > k
        removed = min_heap.shift  # 先頭の要素（最小値）を取り除く
        puts "Removed #{removed}, current heap: #{min_heap}"
      end
    end

    # 最小ヒープの最小要素が、k番目に大きい要素
    kth_largest = min_heap.first
    puts "The #{k}th largest element is: #{kth_largest}"
    kth_largest
  end
end

# 使用例
solver = KthLargestElement.new
puts "Kth largest in [3,2,1,5,6,4] when k=2: #{solver.find_kth_largest([3,2,1,5,6,4], 2)}"  # 出力: 5
puts "Kth largest in [3,2,3,1,2,4,5,5,6] when k=4: #{solver.find_kth_largest([3,2,3,1,2,4,5,5,6], 4)}"  # 出力: 4

# def find_kth_largest(nums, k)
#   nums.max(k).last
# end
