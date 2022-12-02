ScoreMatrix = [[4 1 7];[8 5 2];[3 9 6]]

score::Int64 = 0

for word in eachline(pwd() *  "/day2/input")
    score += ScoreMatrix[Int64(word[3]) - 87, Int64(word[1]) - 64]
end

score::Int64 = 0

TransitionMatrix = [['Z' 'X' 'Y'];['X' 'Y' 'Z'];['Y' 'Z' 'X']]

for word in eachline(pwd() *  "/day2/input")
    tact = Int64(word[3]) - 87
    opp = Int64(word[1]) - 64
    score += ScoreMatrix[Int64(TransitionMatrix[opp, tact]) - 87, opp]
end