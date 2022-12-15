fp = open(pwd() * "/day14/input")
lines = readlines(fp)
using Printf

# a fancy cave printer
function drawCave(A::Array{Char}, maxR, minC, maxC)

    r = minC:maxC
    for i = 1:3
        print(" "^4)
        for j = 1:size(A)[2]
            print((r[j] - (r[j] ÷ 10^(4-i))*10^(4-i)) ÷ 10^(3-i), ' ')
        end
        print('\n')
    end

    for i = 1:size(A)[1]
        @printf "%3d " (i-1)
        for j = 1:size(A)[2]
            print(A[i,j], ' ')
        end
        print('\n')
    end
end


# ok time to parse
rocks = []
rCols = []
minC, maxC, maxR = 10000, 0, 0


for line in lines
    r, c = [], []

    x = split.(split(line, "->"), ",")
    #display(x)
    for item in x
        push!(c, parse(Int64, item[1]))
        push!(rCols, parse(Int64, item[1]))
        push!(r, parse(Int64, item[2]))
    end

    #display(r)
    #display(c)

    minC = (minimum(c) < minC ? minimum(c) : minC)
    maxC = (maximum(c) > maxC ? maximum(c) : maxC)
    maxR = (maximum(r) > maxR ? maximum(r) : maxR)

    push!(rocks, (r,c))
end

push!(rocks,([maxR+2, maxR+2],[490-maxR, 510+maxR]))
minC = (490-maxR < minC ? 490-maxR : minC)
maxC = (510+maxR > maxC ? 510+maxR : maxC)
maxR += 2

A = Array{Char}(undef, maxR+1, maxC-minC+1);
fill!(A, '.');

for rock in rocks
    for i = 1:(length(rock[1]) - 1) 
        a = min(rock[1][i],rock[1][i+1])
        b = max(rock[1][i],rock[1][i+1])
        c = min(rock[2][i]-minC+1,rock[2][i+1]-minC+1) 
        d = max(rock[2][i]-minC+1,rock[2][i+1]-minC+1) 
        A[a:b, c:d] .= '#'
    end
end



drawCave(A, maxR, minC, maxC)

# part 1
B = copy(A)
abyss = false
cnt = 0
while !abyss 
    move = true 
    x, y = 0, (500 - minC + 1) 
    while move
        move = false
        if x+1 > maxR
            abyss = true
            break
        end

        if B[x+1, y] == '.'
            x += 1
            move = true
        elseif y-1 < 1 
            abyss = true
        elseif y+1 > size(B)[2]
            abyss = true
        else
            if B[x+1, y-1] == '.'
                x += 1
                y -= 1
                move = true
            elseif B[x+1, y+1] == '.'
                x += 1
                y += 1
                move = true
            end
        end
    end
    if !abyss
        B[x, y] = 'o'
        cnt += 1
    end
    #drawCave(B, maxR, minC, maxC)
end
cnt


# part 2
B = copy(A);
abyss = false
full = false
cnt = 0
#while !full
while true
    move = true 
    x, y = 0, (500 - minC + 1) 
    while move
        move = false
        if x+1 > maxR
            abyss = true
            break
        end

        if B[x+1, y] == '.'
            x += 1
            move = true
        elseif y-1 < 1 
            abyss = true
        elseif y+1 > size(B)[2]
            abyss = true
        else
            if B[x+1, y-1] == '.'
                x += 1
                y -= 1
                move = true
            elseif B[x+1, y+1] == '.'
                x += 1
                y += 1
                move = true
            end
        end
    end
    if (x, y) == (0, 500-minC+1)
        full = true
        print("Full at ", cnt+1, "\n")
        break
    elseif !abyss
        B[x, y] = 'o'
        cnt += 1
    end
    #drawCave(B, maxR, minC, maxC)
end
cnt


drawCave(B, maxR, minC, maxC)