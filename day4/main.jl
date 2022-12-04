count::Int64 = 0
bds = zeros(Int64, 4)

for word in eachline(pwd() *  "/day4/input")
    bds .= [parse(Int64, a.match) for a in eachmatch(r"\d+", word)]

    if ((bds[1] <= bds[3]) && (bds[2] >= bds[4])) || ((bds[1] >= bds[3]) && (bds[2] <= bds[4]))
        count += 1
    end
end


count::Int64 = 0
bds = zeros(Int64, 4)

for word in eachline(pwd() *  "/day4/input")
    bds .= [parse(Int64, a.match) for a in eachmatch(r"\d+", word)]

    if ! ((bds[2] < bds[3]) && (bds[1] < bds[4]) || ((bds[2]> bds[3]) && (bds[1]>bds[4])))
        count += 1
    end
end