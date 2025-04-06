def max_sliding_window(nums, k)
  return [] if nums.empty?
  return nums if k == 1

  deque = []  # インデックスを保存
  result = []

  nums.each_with_index do |num, i|
    # deque[0] <= i - k
    # 現在のウィンドウの 左端よりも前にあるインデックスを削除

    # キューの先頭がウィンドウから外れてたら削除
    p "deque: #{deque}, i: #{i}, num: #{num}"
    deque.shift if !deque.empty? && deque[0] <= i - k

    # キューの末尾から、自分より小さいものを削除（単調減少を維持）
    # これをすることで、deque[0] が常にウィンドウ内の最大値になる
    # つまり、deque[0] はウィンドウ内の最大値を指す
    # 例: deque = [0, 1, 2] のとき、nums[deque[-1]] < num なら
    # nums[2] < num なら、deque[-1] = 2 を削除
    # nums[1] < num なら、deque[-1] = 1 を削除
    # nums[0] < num なら、deque[-1] = 0 を削除
    while !deque.empty? && nums[deque[-1]] < num
      deque.pop
    end

    deque << i  # 自分のインデックスを追加

    # k個以上見たら最大値（キューの先頭）を結果に追加
    # つまり k 個以上の回数のループを回したら、deque[0]が最大値
    result << nums[deque[0]] if i >= k - 1
  end

  result
end

