def max_area(height)
  left = 0
  right = height.length - 1
  max_area = 0

  # 左右のポインタが交差するまでループ
  while left < right
    h = [height[left], height[right]].min
    area = h * (right - left)
    max_area = [max_area, area].max

    # 低い方の棒を動かす
    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end

  max_area
end

# テスト
p max_area([1,8,6,2,5,4,8,3,7]) # => 49
p max_area([1,1]) # => 1
