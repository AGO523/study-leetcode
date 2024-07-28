# Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.
# 整数の配列 heights が与えられ、これは各棒の高さを表しています。各棒の幅は1です。このヒストグラムにおいて、最大の長方形の面積を求めてください。

# 例
# 例1:

# 入力: heights = [2,1,5,6,2,3]
# 出力: 10
# 説明: 上記のヒストグラムでは、各棒の幅は1です。最大の長方形は赤い部分で、面積は10平方単位です。
# 例2:

# 入力: heights = [2,4]
# 出力: 4
# 説明: 最大の長方形は、どちらの棒でも同じで、面積は4平方単位です。
 

# Example 1:


# Input: heights = [2,1,5,6,2,3]
# Output: 10
# Explanation: The above is a histogram where width of each bar is 1.
# The largest rectangle is shown in the red area, which has an area = 10 units.
# Example 2:


# Input: heights = [2,4]
# Output: 4
 

# Constraints:

# 1 <= heights.length <= 105
# 0 <= heights[i] <= 104


# 解答
# この問題では、ヒストグラムにおける最大の長方形の面積を効率的に見つけるためにスタックを使用します。スタックを用いることで、各棒が形成する長方形の最大面積を効果的に計算します。

# アルゴリズムの概要
# 各棒を順に処理し、スタックを使用してその棒が形成できる最大の長方形を計算します。
# 現在の棒の高さがスタックのトップの棒の高さよりも低い場合、スタックからポップして最大の長方形を計算します。
# 最終的にスタックに残っている棒に対しても同様の計算を行います。

def largest_rectangle_area(heights)
  max_area = 0
  stack = []
  heights.each_with_index do |h, i|
    # 現在の棒の高さがスタックのトップの棒の高さより低い場合
    while stack.any? && heights[stack.last] > h
      # スタックのトップの棒のインデックスを取り出す
      height = heights[stack.pop]
      # 左端のインデックスを取得
      width = stack.empty? ? i : i - stack.last - 1
      # 最大面積を更新
      max_area = [max_area, height * width].max
    end
    # 現在の棒のインデックスをスタックに追加
    stack.push(i)
  end

  # スタックに残っている棒に対しても同様の処理を行う
  while stack.any?
    height = heights[stack.pop]
    width = stack.empty? ? heights.length : heights.length - stack.last - 1
    max_area = [max_area, height * width].max
  end

  max_area
end

# 使用例
puts largest_rectangle_area([2, 1, 5, 6, 2, 3])  # 出力: 10
puts largest_rectangle_area([2, 4])             # 出力: 4

# コードの詳細な説明
# 初期化:

# max_area を0で初期化します。これは最大の長方形の面積を記録するための変数です。
# stack を空の配列として初期化します。このスタックはインデックスを保持し、各棒の高さを管理します。
# 棒の処理:

# heights.each_with_index で各棒の高さ h とインデックス i を取得します。
# while stack.any? && heights[stack.last] > h では、現在の棒の高さがスタックのトップの棒の高さより低い場合に、スタックからポップして最大の長方形の面積を計算します。
# height = heights[stack.pop] でスタックのトップのインデックスに対応する高さを取得します。
# width = stack.empty? ? i : i - stack.last - 1 で長方形の幅を計算します。スタックが空の場合は左端が0とみなし、そうでない場合はスタックの新しいトップから計算します。
# max_area = [max_area, height * width].max で最大面積を更新します。
# スタックに残った棒の処理:

# すべての棒を処理した後、スタックに残っているインデックスに対しても同様の処理を行い、最大の長方形の面積を計算します。
# 結果の返却:

# 最終的に max_area を返します。これがヒストグラム内の最大の長方形の面積です。
# この方法により、ヒストグラムの各棒に対して最大の長方形の面積を効率的に計算できます。スタックを使用することで、各棒の高さの範囲を追跡し、棒が形成する長方形の最大面積を決定します。


# 具体例を使って `largest_rectangle_area` 関数の動作を詳しく説明します。

# ### 具体例

# **入力**: `heights = [2, 1, 5, 6, 2, 3]`

# この配列は、各棒の高さを示しています。各棒の幅は1と仮定しています。このヒストグラムで最大の長方形の面積を計算します。

# **期待される出力**: `10`

# これは、ヒストグラム内で形成できる最大の長方形の面積です。

# ### ステップごとの処理

# 1. **初期化**:
#    - `max_area = 0` （最大の長方形の面積を保持）
#    - `stack = []` （インデックスを保持するスタック）

# 2. **各棒の処理**:

#    - **1番目の棒（高さ2）**:
#      - スタックが空なので、インデックス `0` をスタックに追加。
#      - `stack = [0]`

#    - **2番目の棒（高さ1）**:
#      - 現在の棒の高さ `1` がスタックトップの棒の高さ `2` より低いため、スタックからポップして面積を計算。
#      - `height = heights[stack.pop()] = 2`
#      - `width = 1` （スタックが空なので、左端を0と見なす）
#      - `max_area = max(0, 2 * 1) = 2`
#      - インデックス `1` をスタックに追加。
#      - `stack = [1]`

#    - **3番目の棒（高さ5）**:
#      - スタックが空でないが、現在の棒の高さ `5` がスタックトップの高さ `1` より高いため、ポップしない。
#      - インデックス `2` をスタックに追加。
#      - `stack = [1, 2]`

#    - **4番目の棒（高さ6）**:
#      - 現在の棒の高さ `6` がスタックトップの高さ `5` より高いため、ポップしない。
#      - インデックス `3` をスタックに追加。
#      - `stack = [1, 2, 3]`

#    - **5番目の棒（高さ2）**:
#      - 現在の棒の高さ `2` がスタックトップの高さ `6` より低いため、スタックからポップして面積を計算。
#      - `height = heights[stack.pop()] = 6`
#      - `width = 1` （スタックが空でないので、左端を `stack.last + 1 = 3` と見なす）
#      - `max_area = max(2, 6 * 1) = 6`
#      - 次にスタックトップの高さ `5` もポップ。
#      - `height = heights[stack.pop()] = 5`
#      - `width = 2` （スタックが空でないので、左端を `stack.last + 1 = 2` と見なす）
#      - `max_area = max(6, 5 * 2) = 10`
#      - インデックス `4` をスタックに追加。
#      - `stack = [1, 4]`

#    - **6番目の棒（高さ3）**:
#      - 現在の棒の高さ `3` がスタックトップの高さ `2` より高いため、ポップしない。
#      - インデックス `5` をスタックに追加。
#      - `stack = [1, 4, 5]`

# 3. **スタックに残った棒の処理**:

#    - スタック内のすべての棒をポップして面積を計算。

#    - **最後の棒の処理**:
#      - スタックトップのインデックス `5` をポップして面積を計算。
#      - `height = heights[stack.pop()] = 3`
#      - `width = 1` （スタックが空でないので、左端を `stack.last + 1 = 5` と見なす）
#      - `max_area = max(10, 3 * 1) = 10`
#      - 次にスタックトップの高さ `2` もポップ。
#      - `height = heights[stack.pop()] = 2`
#      - `width = 4` （スタックが空でないので、左端を `stack.last + 1 = 2` と見なす）
#      - `max_area = max(10, 2 * 4) = 10`
#      - 次にスタックトップの高さ `1` もポップ。
#      - `height = heights[stack.pop()] = 1`
#      - `width = 6` （スタックが空なので、全幅を計算）
#      - `max_area = max(10, 1 * 6) = 10`

# ### 最終結果

# - `max_area = 10`

# **結果の説明**:
# - 最大の長方形は、3番目（高さ5）と4番目（高さ6）の棒で形成され、面積は10平方単位です。

# このように、スタックを使用して各棒の範囲と高さを効率的に追跡し、最大の長方形の面積を計算します。棒の高さが降順でなくなるたびに、スタックをポップして最大面積を更新します。スタックに残っている棒についても同様の処理を行い、全体の最大長方形面積を取得します。
