# You are given an m x n integer matrix matrix with the following two properties:

# Each row is sorted in non-decreasing order.
# The first integer of each row is greater than the last integer of the previous row.
# Given an integer target, return true if target is in matrix or false otherwise.

# You must write a solution in O(log(m * n)) time complexity.

 

# Example 1:


# Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
# Output: true

def search_matrix(matrix, target)
  row = matrix.length
  col = matrix[0].length
  left = 0
  right = row * col - 1
  
  while left <= right
    mid = (left + right) / 2
    mid_value = matrix[mid / col][mid % col]
    
    if mid_value == target
      return true
    elsif mid_value < target
      left = mid + 1
    else
      right = mid - 1
    end
  end
end
