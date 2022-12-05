fp = open(pwd() * "/day5/input")
lines = readlines(fp)

n::Int64 = (length(lines[1]) + 1) ÷ 4

# find the break in the input
countNew = 0
for line in lines
    countNew += 1
    if line == ""
        break
    end
end

stacks = [Stack{Char}() for i in 1:n]
for i = countNew-2:-1:1
    for j = 2:4:n*4
        display(j)
        if lines[i][j] != ' '
            push!(stacks[(j÷4)+1], lines[i][j])
        end
    end
end

# CraneMover 9000
nums = zeros(Int64, 3)
for i = countNew+1:length(lines)
    nums .= [parse(Int64, a.match) for a in eachmatch(r"\d+", lines[i])]
    for j=1:nums[1]
        push!(stacks[nums[3]], pop!(stacks[nums[2]]))
    end
end

for i = 1:length(stacks)
    print(first(stacks[i]))
end



# CraneMover 9001
tempStack = Stack{Char}()
nums = zeros(Int64, 3)
for i = countNew+1:length(lines)
    nums .= [parse(Int64, a.match) for a in eachmatch(r"\d+", lines[i])]
    for j=1:nums[1]
        push!(tempStack, pop!(stacks[nums[2]]))
    end
    for j=1:nums[1]
        push!(stacks[nums[3]], pop!(tempStack))
    end
end

for i = 1:length(stacks)
    print(first(stacks[i]))
end