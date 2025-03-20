# Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane and an integer k, return the k closest points to the origin (0, 0).

# The distance between two points on the X-Y plane is the Euclidean distance (i.e., √(x1 - x2)2 + (y1 - y2)2).

# You may return the answer in any order. The answer is guaranteed to be unique (except for the order that it is in).

# 2次元平面上の点を表す配列 points が与えられ、各点は points[i] = [xi, yi] で表されます。また、整数 k も与えられます。原点 (0, 0) から最も近い k 個の点を返してください。

# 2点間の距離はユークリッド距離（すなわち、√((x1 - x2)^2 + (y1 - y2)^2)）で計算します。

# 結果の点の順序は任意でかまいません。また、結果は一意であることが保証されています（順序は異なる可能性があります）。

# Example 1:


# Input: points = [[1,3],[-2,2]], k = 1
# Output: [[-2,2]]
# Explanation:
# The distance between (1, 3) and the origin is sqrt(10).
# The distance between (-2, 2) and the origin is sqrt(8).
# Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
# We only want the closest k = 1 points from the origin, so the answer is just [[-2,2]].
# Example 2:

# Input: points = [[3,3],[5,-1],[-2,4]], k = 2
# Output: [[3,3],[-2,4]]
# Explanation: The answer [[-2,4],[3,3]] would also be accepted.
 

# Constraints:

# 1 <= k <= points.length <= 104
# -104 <= xi, yi <= 104

# 実装と解説
# この問題では、各点から原点 (0, 0) までのユークリッド距離を計算し、その距離が最も小さい k 個の点を効率よく返す必要があります。

# 考え方:

# ユークリッド距離を計算するとき、平方根を計算する必要はありません。距離の相対的な比較には、二乗した距離で十分です。
# 距離が小さい順にソートして、上位 k 個の点を取得するのが基本的なアプローチです。


class KClosestPoints
  # points: 2次元平面上の点のリスト
  # k: 最も原点に近いk個の点を求める
  def k_closest(points, k)
    # 各点の原点からの距離（ユークリッド距離の2乗）を計算してソート
    sorted_points = points.sort_by { |(x, y)| x * x + y * y }
    
    puts "Sorted points by distance: #{sorted_points}"

    # k個の最も近い点を返す
    closest_points = sorted_points.first(k)
    puts "Closest #{k} points: #{closest_points}"

    closest_points
  end
end

# 使用例
solver = KClosestPoints.new
puts "Result: #{solver.k_closest([[1,3],[-2,2]], 1)}" # 出力: [[-2,2]]
puts "Result: #{solver.k_closest([[3,3],[5,-1],[-2,4]], 2)}" # 出力: [[3,3], [-2,4]]

# `x * x + y * y` は、2次元平面上の点 `(x, y)` から原点 `(0, 0)` までの**ユークリッド距離の2乗**を計算しています。

# ### ユークリッド距離とは？

# ユークリッド距離は、2つの点間の距離を計算する方法で、2次元平面では以下の式を使います：

# \[ \text{距離} = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2} \]

# ここで、点 `(x_1, y_1)` から点 `(x_2, y_2)` までの距離を計算しています。今回の場合は、原点 `(0, 0)` と点 `(x, y)` の距離を計算するため、式は次のようになります：

# \[ \text{距離} = \sqrt{(x - 0)^2 + (y - 0)^2} = \sqrt{x^2 + y^2} \]

# ### なぜ平方根を取らないのか？

# 距離の比較をするだけであれば、**平方根を計算する必要はありません**。なぜなら、平方根を取る前後で大小関係は変わらないためです。

# 例えば、以下の2つの距離を比較する場合：

# - 距離1 = √(9) = 3
# - 距離2 = √(16) = 4

# 平方根を取る前（9 と 16）の時点でも、すでに9 < 16なので、平方根を取らなくても比較できます。

# したがって、効率を高めるために `x * x + y * y` を使って**距離の2乗**を計算し、それを基に点同士の距離を比較しています。平方根を計算する手間が省けるため、処理が高速になります。

# ### まとめ

# - `x * x + y * y` は、点 `(x, y)` から原点 `(0, 0)` までのユークリッド距離の2乗を表します。
# - 直接距離を比較する場合、平方根を取る必要がないため、効率的に距離を比較できる。
