priority::Int64 = 0

for word in eachline(pwd() *  "/day3/testinput")
    n = length(word)
    for i=(n÷2+1):n
        if occursin(word[i], word[1:n÷2])
            x = convert(Int64, word[i])
            priority += (x<97 ? x - 65 + 27 : x - 96)
            break
        end
    end
end

fp = open(pwd() * "/day3/input")
lines = readlines(fp)

priority::Int64 = 0

for i in 1:3:length(lines)
    for j in 1:length(lines[i])
        if occursin(lines[i][j], lines[i+1])
            if occursin(lines[i][j], lines[i+2])
                x = convert(Int64, lines[i][j])
                priority += (x<97 ? x - 65 + 27 : x - 96)
                break
            end
        end
    end
end