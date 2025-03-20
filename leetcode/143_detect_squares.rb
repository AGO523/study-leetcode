# You are given a stream of points on the X-Y plane. Design an algorithm that:

# Adds new points from the stream into a data structure. Duplicate points are allowed and should be treated as different points.
# Given a query point, counts the number of ways to choose three points from the data structure such that the three points and the query point form an axis-aligned square with positive area.
# An axis-aligned square is a square whose edges are all the same length and are either parallel or perpendicular to the x-axis and y-axis.

# Implement the DetectSquares class:

# DetectSquares() Initializes the object with an empty data structure.
# void add(int[] point) Adds a new point point = [x, y] to the data structure.
# int count(int[] point) Counts the number of ways to form axis-aligned squares with point point = [x, y] as described above.


# 問題文（日本語訳）
# X-Y 平面上のポイントのストリームが与えられます。以下の操作を行うアルゴリズムを設計してください：

# 新しいポイントをデータ構造に追加します。重複したポイントは許容され、それぞれ異なるポイントとして扱われます。
# クエリポイントが与えられたとき、そのクエリポイントを含むような、正方形（辺がX軸またはY軸に平行で正の面積を持つ）を形成する方法を数えます。
# クラス DetectSquares を以下のように実装します：

# DetectSquares(): 空のデータ構造でオブジェクトを初期化します。
# add(int[] point): 新しいポイント point = [x, y] をデータ構造に追加します。
# count(int[] point): 与えられたクエリポイント point = [x, y] を含むような正方形を形成する方法を数えます。

# Example 1:


# Input
# ["DetectSquares", "add", "add", "add", "count", "count", "add", "count"]
# [[], [[3, 10]], [[11, 2]], [[3, 2]], [[11, 10]], [[14, 8]], [[11, 2]], [[11, 10]]]
# Output
# [null, null, null, null, 1, 0, null, 2]

# Explanation
# DetectSquares detectSquares = new DetectSquares();
# detectSquares.add([3, 10]);
# detectSquares.add([11, 2]);
# detectSquares.add([3, 2]);
# detectSquares.count([11, 10]); // return 1. You can choose:
#                                //   - The first, second, and third points
# detectSquares.count([14, 8]);  // return 0. The query point cannot form a square with any points in the data structure.
# detectSquares.add([11, 2]);    // Adding duplicate points is allowed.
# detectSquares.count([11, 10]); // return 2. You can choose:
#                                //   - The first, second, and third points
#                                //   - The first, third, and fourth points
 

# Constraints:

# point.length == 2
# 0 <= x, y <= 1000
# At most 3000 calls in total will be made to add and count.

# アプローチと解説
# アプローチ
# データ構造
# ポイントの数を記録するハッシュテーブル（point_count）を使用します。
# point_count[[x, y]] に (x, y) の出現回数を記録します。
# 操作
# add 操作:

# ポイント (x, y) をハッシュテーブルに追加します。
# もし (x, y) がすでに存在する場合、そのカウントを増やします。
# count 操作:

# 正方形を形成するには、次の条件を確認します：
# クエリポイント (qx, qy) を基準として対角線の位置を決定する。
# 残りの2点がデータ構造に存在しているかをチェックする。
# すべての可能な正方形の辺の長さを試し、条件を満たす組み合わせを数えます。

class DetectSquares
  def initialize
    @point_count = Hash.new(0)  # 各ポイントの出現回数を記録
  end

  def add(point)
    @point_count[point] += 1
    puts "ポイント #{point} を追加しました (カウント: #{@point_count})"
    # (カウント: {[3, 10]=>1, [11, 2]=>1, [3, 2]=>1})
  end

  def count(point)
    qx, qy = point
    total_squares = 0

    # ハッシュテーブルを走査して正方形を形成できるポイントを探す
    @point_count.each do |(px, py), count|
      # クエリポイントと異なる x, y の組み合わせのみチェック
      # px != qx:
      # (px, py) がクエリポイント (qx, qy) と同じ x-座標を持たないことを確認します。
      # これは、正方形を形成するためには、クエリポイントと選ばれた候補ポイントが異なる x-座標を持つ必要があるからです。

      # クエリポイントと候補ポイントが正方形の対角線の一端を形成していることを確認します。
      # 具体的には、正方形の辺の長さを確認している：
      next unless px != qx && (qy - py).abs == (qx - px).abs

      # 他の2つのポイントの存在を確認
      total_squares += count * @point_count[[qx, py]] * @point_count[[px, qy]]
    end

    puts "クエリポイント #{point} に対する正方形の数: #{total_squares}"
    total_squares
  end
end

# テストケース
detect_squares = DetectSquares.new
detect_squares.add([3, 10])
detect_squares.add([11, 2])
detect_squares.add([3, 2])
puts detect_squares.count([11, 10])  # 結果: 1
puts detect_squares.count([14, 8])   # 結果: 0
detect_squares.add([11, 2])
puts detect_squares.count([11, 10])  # 結果: 2
