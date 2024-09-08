# The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value, and the median is the mean of the two middle values.

# For example, for arr = [2,3,4], the median is 3.
# For example, for arr = [2,3], the median is (2 + 3) / 2 = 2.5.
# Implement the MedianFinder class:

# MedianFinder() initializes the MedianFinder object.
# void addNum(int num) adds the integer num from the data stream to the data structure.
# double findMedian() returns the median of all elements so far. Answers within 10-5 of the actual answer will be accepted.


# 中央値（Median）は、並べられた整数リストの中で中央に位置する値です。リストのサイズが偶数の場合、中央の値は存在せず、中央値は2つの中央の値の平均値として計算されます。

# 例えば、arr = [2,3,4] の場合、中央値は 3 です。
# arr = [2,3] の場合、中央値は (2 + 3) / 2 = 2.5 です。

# MedianFinder クラスを実装してください:

# MedianFinder() メソッドで MedianFinder オブジェクトを初期化します。
# void addNum(int num) メソッドで、データストリームから整数 num をデータ構造に追加します。
# double findMedian() メソッドで、これまでの全ての要素の中央値を返します。解答は実際の解答に対して 10^-5 以内の誤差で受け入れられます。

# Example 1:

# Input
# ["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
# [[], [1], [2], [], [3], []]
# Output
# [null, null, null, 1.5, null, 2.0]

# Explanation
# MedianFinder medianFinder = new MedianFinder();
# medianFinder.addNum(1);    // arr = [1]
# medianFinder.addNum(2);    // arr = [1, 2]
# medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
# medianFinder.addNum(3);    // arr[1, 2, 3]
# medianFinder.findMedian(); // return 2.0
 

# Constraints:

# -105 <= num <= 105
# There will be at least one element in the data structure before calling findMedian.
# At most 5 * 104 calls will be made to addNum and findMedian.
 

# Follow up:

# If all integer numbers from the stream are in the range [0, 100], how would you optimize your solution?
# If 99% of all integer numbers from the stream are in the range [0, 100], how would you optimize your solution?


# 解説
# この問題では、ストリームから数を追加していきながら、常にデータの中央値を効率的に計算するクラス MedianFinder を実装します。

# 解決方法
# 中央値の定義:

# 奇数個の要素がある場合、中央値はリストの真ん中の値です。
# 偶数個の要素がある場合、中央値は中央2つの値の平均です。
# 効率的なデータ管理:

# 要素の数が多くなると、都度ソートするのは非効率です。そこで、2つのヒープを使用してデータを管理します。
# 左側のヒープ: 最大ヒープで、全体の前半部分の値を管理。
# 右側のヒープ: 最小ヒープで、全体の後半部分の値を管理。
# ヒープの特性を利用:

# 最大ヒープにより、前半部分の最大値を取得できる。
# 最小ヒープにより、後半部分の最小値を取得できる。
# これにより、中央値を効率的に計算できる。


class MedianFinder
  # 初期化メソッド: 最大ヒープと最小ヒープを初期化
  def initialize()
      @small = MaxHeap.new  # 最大ヒープ (小さい値を管理)
      @large = MinHeap.new  # 最小ヒープ (大きい値を管理)
  end

=begin
  :type num: Integer
  :rtype: Void
=end
  # 数値を追加するメソッド
  def add_num(num)
      # まず最大ヒープ（@small）に追加
      @small << num

      # 最大ヒープの最大値が最小ヒープの最小値よりも大きい場合、バランスを取るために要素を移動
      if @small.size > 0 && @large.size > 0 && @small.max > @large.min
          # 最大ヒープから要素をポップして、最小ヒープに追加
          @large << @small.pop
      end

      # 最大ヒープのサイズが最小ヒープより2以上大きい場合、バランスを取るために要素を移動
      if @small.size > @large.size + 1
          # 最大ヒープから最も大きい要素をポップして、最小ヒープに追加
          @large << @small.pop
      end

      # 最小ヒープのサイズが最大ヒープより2以上大きい場合、バランスを取るために要素を移動
      if @large.size > @small.size + 1
          # 最小ヒープから最も小さい要素をポップして、最大ヒープに追加
          @small << @large.pop
      end
  end

=begin
  :rtype: Float
=end
  # 中央値を計算するメソッド
  def find_median()
      # 要素数が奇数の場合、要素数が多い方のヒープの先頭要素が中央値
      if @small.size > @large.size
          @small.max  # 最大ヒープの最大値が中央値
      elsif @large.size > @small.size
          @large.min  # 最小ヒープの最小値が中央値
      else
          # 要素数が偶数の場合、最大ヒープの最大値と最小ヒープの最小値の平均が中央値
          (@small.max + @large.min) / 2.0
      end
  end
end

# MedianFinder オブジェクトのインスタンス化とメソッドの呼び出し例
# obj = MedianFinder.new()
# obj.add_num(num)  # 数値の追加
# param_2 = obj.find_median()  # 中央値の計算
