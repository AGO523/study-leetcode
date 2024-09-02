# You are part of a university admissions office and need to keep track of the kth highest test score from applicants in real-time. This helps to determine cut-off marks for interviews and admissions dynamically as new applicants submit their scores.

# You are tasked to implement a class which, for a given integer k, maintains a stream of test scores and continuously returns the kth highest test score after a new score has been submitted. More specifically, we are looking for the kth highest score in the sorted list of all scores.

# Implement the KthLargest class:

# KthLargest(int k, int[] nums) Initializes the object with the integer k and the stream of test scores nums.
# int add(int val) Adds a new test score val to the stream and returns the element representing the kth largest element in the pool of test scores so far.

# あなたは大学の入学事務局の一員で、応募者のテストスコアの中でリアルタイムでk番目に高いスコアを追跡する必要があります。これは、新しい応募者がスコアを提出するたびに、面接や入学のためのカットオフマークを動的に決定するのに役立ちます。

# このタスクでは、整数 k が与えられたときに、テストスコアのストリームを管理し、新しいスコアが提出されるたびにk番目に高いスコアを返すクラスを実装する必要があります。具体的には、すべてのスコアがソートされたリストの中で、k番目に高いスコアを見つけるという問題です。

# KthLargest クラスを実装してください:

# KthLargest(int k, int[] nums): 整数 k とテストスコアのストリーム nums でオブジェクトを初期化します。
# int add(int val): 新しいテストスコア val をストリームに追加し、これまでのテストスコアのプール内でk番目に大きい要素を返します。

# Example 1:

# Input:
# ["KthLargest", "add", "add", "add", "add", "add"]
# [[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]

# Output: [null, 4, 5, 5, 8, 8]

# Explanation:

# KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
# kthLargest.add(3); // return 4
# kthLargest.add(5); // return 5
# kthLargest.add(10); // return 5
# kthLargest.add(9); // return 8
# kthLargest.add(4); // return 8

# Example 2:

# Input:
# ["KthLargest", "add", "add", "add", "add"]
# [[4, [7, 7, 7, 7, 8, 3]], [2], [10], [9], [9]]

# Output: [null, 7, 7, 7, 8]

# Explanation:

# KthLargest kthLargest = new KthLargest(4, [7, 7, 7, 7, 8, 3]);
# kthLargest.add(2); // return 7
# kthLargest.add(10); // return 7
# kthLargest.add(9); // return 7
# kthLargest.add(9); // return 8
 

# Constraints:

# 0 <= nums.length <= 104
# 1 <= k <= nums.length + 1
# -104 <= nums[i] <= 104
# -104 <= val <= 104
# At most 104 calls will be made to add.

# 解答
# この問題では、ストリーム中のk番目に高い値を効率的に追跡する必要があります。これには最小ヒープを使用するのが一般的です。最小ヒープを用いることで、常にk個の最大値が保持されるようにし、k番目に大きい値を効率的に取得できます。

# 実装手順
# 初期化:

# 最小ヒープ（優先度キュー）を使って、k 番目に大きい要素を維持します。
# 初期の配列 nums の要素をすべてヒープに追加し、ヒープのサイズが k を超えた場合は最小要素を取り除く。
# 新しい値の追加:

# 新しい値をヒープに追加し、ヒープのサイズが k を超えた場合は最小要素を取り除く。
# ヒープの最小要素が k 番目に大きい要素となるので、それを返す。


# require 'pqueue'  # PQueueライブラリを使用して優先度付きキュー（ヒープ）をサポート

# class KthLargest
#   def initialize(k, nums)
#     @k = k  # k番目に大きい要素を追跡するためのkを保存
#     @min_heap = PQueue.new(nums) { |a, b| a < b }  # 最小ヒープを作成し、numsの要素を追加
#     puts "Initial heap: #{@min_heap.to_a}"  # ヒープの初期状態を出力

#     # ヒープのサイズがkを超える場合、最小要素を取り除いて調整
#     while @min_heap.size > k
#       removed = @min_heap.pop  # 最小要素を取り除く
#       puts "Removed element #{removed}, heap now: #{@min_heap.to_a}"  # 取り除いた要素とヒープの状態を出力
#     end
#   end

#   def add(val)
#     @min_heap.push(val)  # 新しい値をヒープに追加
#     puts "Added element #{val}, heap now: #{@min_heap.to_a}"  # 追加後のヒープの状態を出力

#     # ヒープのサイズがkを超える場合、最小要素を取り除いて調整
#     if @min_heap.size > @k
#       removed = @min_heap.pop  # 最小要素を取り除く
#       puts "Removed element #{removed} after adding #{val}, heap now: #{@min_heap.to_a}"  # 取り除いた要素とヒープの状態を出力
#     end

#     kth_largest = @min_heap.top  # ヒープの最小要素がk番目に大きい要素になる
#     puts "The #{@k}th largest element is now #{kth_largest}"  # k番目に大きい要素を出力
#     kth_largest  # k番目に大きい要素を返す
#   end
# end

# # 使用例
# kthLargest = KthLargest.new(3, [4, 5, 8, 2])  # k = 3、初期のテストスコア [4, 5, 8, 2] でKthLargestオブジェクトを初期化
# kthLargest.add(3)  # 新しいスコア3を追加し、3番目に大きい要素を取得
# kthLargest.add(5)  # 新しいスコア5を追加し、3番目に大きい要素を取得
# kthLargest.add(10) # 新しいスコア10を追加し、3番目に大きい要素を取得
# kthLargest.add(9)  # 新しいスコア9を追加し、3番目に大きい要素を取得
# kthLargest.add(4)  # 新しいスコア4を追加し、3番目に大きい要素を取得


class KthLargest
  def initialize(k, nums)
    @k = k
    @min_heap = []
    nums.each { |num| add(num) }  # 初期のnumsからヒープを構築
  end

  def add(val)
    if @min_heap.size < @k
      heap_push(val)  # ヒープに値を追加
    elsif val > @min_heap[0]
      heap_pop  # 最小値を取り除く
      heap_push(val)  # 新しい値を追加
    end
    @min_heap[0]  # k番目に大きい要素を返す
  end

  private

  def heap_push(val)
    @min_heap << val  # 値を追加
    sift_up(@min_heap.size - 1)  # ヒープ特性を維持
  end

  def heap_pop
    swap(0, @min_heap.size - 1)  # ルートと最後の要素を入れ替え
    min_val = @min_heap.pop  # 最後の要素（元のルート）を削除
    sift_down(0)  # ヒープ特性を再構築
    min_val
  end

  def sift_up(index)
    parent = (index - 1) / 2
    return if index <= 0 || @min_heap[parent] <= @min_heap[index]

    swap(index, parent)
    sift_up(parent)
  end

  def sift_down(index)
    child = 2 * index + 1
    return if child >= @min_heap.size

    right_child = child + 1
    if right_child < @min_heap.size && @min_heap[child] > @min_heap[right_child]
      child = right_child
    end

    return if @min_heap[index] <= @min_heap[child]

    swap(index, child)
    sift_down(child)
  end

  def swap(i, j)
    @min_heap[i], @min_heap[j] = @min_heap[j], @min_heap[i]
  end
end

# 使用例
kthLargest = KthLargest.new(3, [4, 5, 8, 2])  # k = 3、初期のテストスコア [4, 5, 8, 2] でKthLargestオブジェクトを初期化
puts kthLargest.add(3)  # 返り値 4
puts kthLargest.add(5)  # 返り値 5
puts kthLargest.add(10) # 返り値 5
puts kthLargest.add(9)  # 返り値 8
puts kthLargest.add(4)  # 返り値 8

# class KthLargest
#   def initialize(k, nums)
#     @k = k  # k番目に大きい要素を追跡するためのkを保存
#     @nums = nums.sort.reverse  # 数字を大きい順にソートして保存
#   end

#   def add(val)
#     # 新しい値を配列に追加し、ソート
#     @nums.push(val)
#     @nums.sort!.reverse!  # ソートして大きい順にする


#     kth_largest = @nums[@k - 1]  # k番目に大きい要素を取得
#     kth_largest  # k番目に大きい要素を返す
#   end
# end
