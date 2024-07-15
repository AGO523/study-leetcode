# You are given an array prices where prices[i] is the price of a given stock on the ith day.
# 日本語で
#  pricesという配列が与えられます。prices[i]はi日目の株価です。

# You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.
# 1株を買うために1日を選択し、将来別の日にその株を売却することで、利益を最大化したいと考えています。

# Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.
# この取引で達成できる最大の利益を返します。利益を得ることができない場合は、0を返します。

# Example 1:

# Input: prices = [7,1,5,3,6,4]
# Output: 5
# Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
# Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
# Example 2:

# Input: prices = [7,6,4,3,1]
# Output: 0
# Explanation: In this case, no transactions are done and the max profit = 0.
 

# Constraints:

# 1 <= prices.length <= 105
# 0 <= prices[i] <= 104

class Solution
  def max_profit(prices)
    # 最小価格を無限大に初期化
    min_price = Float::INFINITY
    # 最大利益を0に初期化
    max_profit = 0

    # 配列の各価格をループ
    prices.each do |price|
      # 現在の価格が最小価格よりも小さい場合、最小価格を更新
      if price < min_price
        min_price = price
      else
        # 現在の価格で売った場合の利益を計算し、最大利益を更新
        profit = price - min_price
        max_profit = [max_profit, profit].max
      end
    end

    # 最大利益を返す
    max_profit
  end
end

prices1 = [7,1,5,3,6,4]
prices2 = [7,6,4,3,1]

sol = Solution.new
p sol.max_profit(prices1)
p sol.max_profit(prices2)
