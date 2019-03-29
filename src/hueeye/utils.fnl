(local utils {})
(local dictionary ["A" "B" "C" "D" "E" "F" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"])
(lambda utils.get-random-string [length]
  (var result "")
  (for [i 1 length]
    (local this-index (math.random 1 length))
    (local this-character (. dictionary this-index))
    (set result (.. result this-character)))
  result)
utils
