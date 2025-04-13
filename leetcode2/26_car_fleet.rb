# Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]
# Output: 3

def car_fleet(target, position, speed)
  # 位置と速度をペアにして降順で並べる
  # [[10, 2], [8, 4], [0, 1], [5, 1], [3, 3]]
  cars = position.zip(speed)
  # 降順に並べる
  # [[10, 2], [8, 4], [5, 1], [3, 3], [0, 1]]
  cars.sort_by { |pos, _| -pos }

  stack = []

  cars.each do |pos, spd|
    # [10, 2] -> time = (target - 10) / 2 => 1.0
    # [8, 4] -> time = (target - 8) / 4 => 1.0
    # [5, 1] -> time = (target - 5) / 1 => 7.0
    # [3, 3] -> time = (target - 3) / 3 => 3.0
    # [0, 1] -> time = (target - 0) / 1 => 12.0
    time = (target - pos).to_f / spd

    # 追いつかない場合だけスタックに追加
    if stack.empty? || time > stack[-1]
      stack.push(time)
    end
    # 降順のうち、前の車両の到着時間よりも早い場合は fleet に吸収される
    # 追いつく場合はスタックに追加しない
  end

  stack.size
end
