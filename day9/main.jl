fp = open(pwd() * "/day9/input")
lines = readlines(fp)


function newTailPos(xH, yH, xT, yT)
    # touching 
    if (abs(xH - xT) + abs(yH - yT) < 2) || (abs(xH - xT) == 1 && abs(yH - yT) == 1)
        #print("Not moving\n")
        return xT, yT
    end

    # not touching
    if abs(yH - yT) > 1 && xH == xT
        #print("Moving y\n")
        yT += (yH - yT) ÷ 2
        return xT, yT
    end
    
    if abs(xH - xT) > 1 && yH == yT
        #print("Moving x\n")
        xT += (xH - xT) ÷ 2
        return xT, yT
    end

    #print("Moving d\n")
    yT += sign(yH - yT) 
    xT += sign(xH - xT) 
    return xT, yT
end

xH, yH = r, 1
xT, yT = r, 1
visited = []

for line in lines
    cmd, n = split(line)
    n = parse(Int64, n)

    for i = 1:n
        if cmd == "R"
            yH += 1
        elseif cmd == "L"
            yH -= 1
        elseif cmd == "U"
            xH -= 1
        elseif cmd == "D"
            xH += 1
        end

        #print("head ", xH,",", yH, "\n")
        #print("tail ", xT,",", yT, "\n")
        xT, yT = newTailPos(xH, yH, xT, yT)
        #print("new tail ", xT,",", yT, "\n\n")
        push!(visited, (xT, yT))
    end
end

print(length(Set(visited)))


xH, yH = 0, 0
xT = zeros(9)
yT = zeros(9)
visited = []

for line in lines
    cmd, n = split(line)
    n = parse(Int64, n)

    for i = 1:n
        if cmd == "R"
            yH += 1
        elseif cmd == "L"
            yH -= 1
        elseif cmd == "U"
            xH -= 1
        elseif cmd == "D"
            xH += 1
        end

        #print("head ", xH,",", yH, "\n")
        #print("tail ", xT,",", yT, "\n")
        xT[1], yT[1] = newTailPos(xH, yH, xT[1], yT[1])
        for i in 2:9
            xT[i], yT[i] = newTailPos(xT[i-1], yT[i-1], xT[i], yT[i])
        end
        #print("new tail ", xT,",", yT, "\n\n")
        push!(visited, (xT[9], yT[9]))
    end
end


print(length(Set(visited)))