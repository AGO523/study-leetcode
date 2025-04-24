class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# Input: head = [1,2,3,4,5]

def reorder_list(head)
  return if head.nil? || head.next.nil?

  # === Step 1: 中間地点を探す ===
  slow = head
  fast = head

  while fast && fast.next
    slow = slow.next
    fast = fast.next.next
  end

  # この時点で slow は 3 を指している

  # === Step 2: 後半を反転 ===
  prev = nil
  curr = slow.next
  slow.next = nil  # 前半と後半を分離

  # この時点で curr は 4 を指していて、後半にあたる
  # slow は前半にあたる

  while curr
    tmp = curr.next
    curr.next = prev
    prev = curr
    curr = tmp
  end

  # === Step 3: 前後を交互にマージ ===
  first = head
  second = prev

  while second
    tmp1 = first.next
    tmp2 = second.next

    first.next = second
    second.next = tmp1

    first = tmp1
    second = tmp2
  end
end

