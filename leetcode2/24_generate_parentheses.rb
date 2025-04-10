def generate_parenthesis(n)
  result = []

  def backtrack(current, left, right, result)
    if left == 0 && right == 0
      result << current
      return
    end

    if left > 0
      backtrack(current + "(", left - 1, right, result)
    end

    if right > left
      backtrack(current + ")", left, right - 1, result)
    end
  end

  backtrack("", n, n, result)
  result
end

backtrack("", 3, 3)
└── "(" → backtrack("(", 2, 3)
    └── "(" → backtrack("((", 1, 3)
        └── "(" → backtrack("(((", 0, 3)
            └── ")" → backtrack("((()", 0, 2)
                └── ")" → backtrack("((())", 0, 1)
                    └── ")" → backtrack("((()))", 0, 0) ✅ 完成！

        └── ")" → backtrack("(()", 1, 2)
            └── "(" → backtrack("(()(", 0, 2)
                └── ")" → backtrack("(()()", 0, 1)
                    └── ")" → backtrack("(()())", 0, 0) ✅ 完成！

            └── ")" → backtrack("(())", 1, 1)
                └── ")" → backtrack("(())(", 0, 1)
                    └── ")" → backtrack("(())()", 0, 0) ✅ 完成！

    └── ")" → backtrack("()", 2, 2)
        └── "(" → backtrack("()(", 1, 2)
            └── "(" → backtrack("()((", 0, 2)
                └── ")" → backtrack("()(()", 0, 1)
                    └── ")" → backtrack("()(())", 0, 0) ✅ 完成！

            └── ")" → backtrack("()()", 1, 1)
                └── ")" → backtrack("()()(", 0, 1)
                    └── ")" → backtrack("()()()", 0, 0) ✅ 完成！
