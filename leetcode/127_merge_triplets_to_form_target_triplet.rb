# A triplet is an array of three integers. You are given a 2D integer array triplets, where triplets[i] = [ai, bi, ci] describes the ith triplet. You are also given an integer array target = [x, y, z] that describes the triplet you want to obtain.

# To obtain target, you may apply the following operation on triplets any number of times (possibly zero):

# Choose two indices (0-indexed) i and j (i != j) and update triplets[j] to become [max(ai, aj), max(bi, bj), max(ci, cj)].
# For example, if triplets[i] = [2, 5, 3] and triplets[j] = [1, 7, 5], triplets[j] will be updated to [max(2, 1), max(5, 7), max(3, 5)] = [2, 7, 5].
# Return true if it is possible to obtain the target triplet [x, y, z] as an element of triplets, or false otherwise.

# 三つ組（トリプレット）は、3つの整数からなる配列です。triplets という2次元整数配列が与えられ、triplets[i] = [ai, bi, ci] は i 番目のトリプレットを表しています。また、target = [x, y, z] という整数配列が与えられ、目標とするトリプレットが記述されています。

# target を達成するために、以下の操作を任意の回数（0回でもよい）行うことができます：

# 異なる2つのインデックス i と j を選び、triplets[j] を [max(ai, aj), max(bi, bj), max(ci, cj)] に更新します。
# たとえば、triplets[i] = [2, 5, 3] と triplets[j] = [1, 7, 5] の場合、triplets[j] は [max(2, 1), max(5, 7), max(3, 5)] = [2, 7, 5] に更新されます。

# 目標トリプレット [x, y, z] を triplets の要素の1つとして得ることが可能であれば true を返し、不可能であれば false を返してください。

# Example 1:

# Input: triplets = [[2,5,3],[1,8,4],[1,7,5]], target = [2,7,5]
# Output: true
# Explanation: Perform the following operations:
# - Choose the first and last triplets [[2,5,3],[1,8,4],[1,7,5]]. Update the last triplet to be [max(2,1), max(5,7), max(3,5)] = [2,7,5]. triplets = [[2,5,3],[1,8,4],[2,7,5]]
# The target triplet [2,7,5] is now an element of triplets.
# Example 2:

# Input: triplets = [[3,4,5],[4,5,6]], target = [3,2,5]
# Output: false
# Explanation: It is impossible to have [3,2,5] as an element because there is no 2 in any of the triplets.
# Example 3:

# Input: triplets = [[2,5,3],[2,3,4],[1,2,5],[5,2,3]], target = [5,5,5]
# Output: true
# Explanation: Perform the following operations:
# - Choose the first and third triplets [[2,5,3],[2,3,4],[1,2,5],[5,2,3]]. Update the third triplet to be [max(2,1), max(5,2), max(3,5)] = [2,5,5]. triplets = [[2,5,3],[2,3,4],[2,5,5],[5,2,3]].
# - Choose the third and fourth triplets [[2,5,3],[2,3,4],[2,5,5],[5,2,3]]. Update the fourth triplet to be [max(2,5), max(5,2), max(5,3)] = [5,5,5]. triplets = [[2,5,3],[2,3,4],[2,5,5],[5,5,5]].
# The target triplet [5,5,5] is now an element of triplets.
 

# Constraints:

# 1 <= triplets.length <= 105
# triplets[i].length == target.length == 3
# 1 <= ai, bi, ci, x, y, z <= 1000

# アプローチと解説
# この問題のポイントは、各値について目標値（target）を達成できるトリプレットの組み合わせが存在するかどうかです。具体的には、目標とする各値を個別に達成できるトリプレットがあれば、それらを組み合わせて target を生成できます。

# アプローチ
# 3つのフラグを用意:

# target[0]、target[1]、target[2] の各値に対して、少なくとも1つのトリプレットが条件を満たしているかどうかを確認します。
# found_a, found_b, found_c の3つのフラグを用意します。
# トリプレットを1つずつ確認:

# 各トリプレットが目標の各値を超えないか確認します。
# もし、あるトリプレットが target のそれぞれの要素の条件を満たしている場合、該当するフラグを true にします。
# 全てのフラグが true なら true を返す:

# 最後に found_a && found_b && found_c がすべて true なら、target の生成が可能なため true を返します。

def can_obtain_target(triplets, target)
  found_a = found_b = found_c = false
  
  triplets.each do |a, b, c|
    # 各トリプレットの値が目標値を超えない場合のみ処理を続ける
    # 目標値を超えてしまった時点で、そのトリプレットは無視する
    next if a > target[0] || b > target[1] || c > target[2]

    puts "確認中のトリプレット: [#{a}, #{b}, #{c}]"

    # 各目標値に対して、対応するフラグを更新
    found_a = true if a == target[0]
    found_b = true if b == target[1]
    found_c = true if c == target[2]

    puts "フラグ状態: found_a=#{found_a}, found_b=#{found_b}, found_c=#{found_c}"

    # すべての目標が達成されれば終了
    return true if found_a && found_b && found_c
  end

  false
end

# テストケース1
puts "テストケース1: triplets = [[2,5,3],[1,8,4],[1,7,5]], target = [2,7,5]"
puts "結果: #{can_obtain_target([[2,5,3],[1,8,4],[1,7,5]], [2,7,5])}"  # 期待される出力: true

# # テストケース2
# puts "\nテストケース2: triplets = [[3,4,5],[4,5,6]], target = [3,2,5]"
# puts "結果: #{can_obtain_target([[3,4,5],[4,5,6]], [3,2,5])}"  # 期待される出力: false

# # テストケース3
# puts "\nテストケース3: triplets = [[2,5,3],[2,3,4],[1,2,5],[5,2,3]], target = [5,5,5]"
# puts "結果: #{can_obtain_target([[2,5,3],[2,3,4],[1,2,5],[5,2,3]], [5,5,5])}"  # 期待される出力: true
