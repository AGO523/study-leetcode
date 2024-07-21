
# Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

# Implement the MinStack class:

# MinStack() initializes the stack object.
# void push(int val) pushes the element val onto the stack.
# void pop() removes the element on the top of the stack.
# int top() gets the top element of the stack.
# int getMin() retrieves the minimum element in the stack.
# You must implement a solution with O(1) time complexity for each function.

# 定数時間で要素の追加、削除、取得、および最小要素の取得をサポートするスタックを設計してください。

# MinStack クラスを実装してください：

# MinStack()：スタックオブジェクトを初期化します。
# void push(int val)：要素 val をスタックにプッシュします。
# void pop()：スタックのトップの要素を削除します。
# int top()：スタックのトップの要素を取得します。
# int getMin()：スタック内の最小要素を取得します。
# 各操作は O(1) の時間複雑度で実行する必要があります。

 

# Example 1:

# Input
# ["MinStack","push","push","push","getMin","pop","top","getMin"]
# [[],[-2],[0],[-3],[],[],[],[]]

# Output
# [null,null,null,null,-3,null,0,-2]class MinStack

class MinStack
  # 初期化
  def initialize()
    # 通常のスタックを保持する配列
    @stack = []
    # 最小値を管理するスタックを保持する配列
    @min_stack = []
  end

  # スタックに要素を追加
  def push(val)
    # 通常のスタックに値を追加
    @stack.push(val)
    # 最小値スタックが空の場合またはvalが最小値スタックのトップより小さい場合、最小値スタックにvalを追加
    if @min_stack.empty? || val <= @min_stack.last
      @min_stack.push(val)
    end
  end

  # スタックのトップ要素を削除
  def pop()
    # 通常のスタックから値をポップ（取り出して削除）
    popped_value = @stack.pop
    # ポップした値が最小値スタックのトップと同じ場合、最小値スタックからもポップ
    if popped_value == @min_stack.last
      @min_stack.pop
    end
  end

  # スタックのトップ要素を取得
  def top()
    # 通常のスタックの最後の要素（トップ）を返す
    @stack.last
  end

  # スタックの最小値を取得
  def get_min()
    # 最小値スタックの最後の要素（最小値）を返す
    @min_stack.last
  end

end

# 使用例
minStack = MinStack.new
minStack.push(-2)
minStack.push(0)
minStack.push(-3)
puts minStack.get_min() # 出力: -3
minStack.pop()
puts minStack.top()    # 出力: 0
puts minStack.get_min() # 出力: -2


# Explanation
# MinStack minStack = new MinStack();
# minStack.push(-2);
# minStack.push(0);
# minStack.push(-3);
# minStack.getMin(); // return -3
# minStack.pop();
# minStack.top();    // return 0
# minStack.getMin(); // return -2
 

# Constraints:

# -231 <= val <= 231 - 1
# Methods pop, top and getMin operations will always be called on non-empty stacks.
# At most 3 * 104 calls will be made to push, pop, top, and getMin.

