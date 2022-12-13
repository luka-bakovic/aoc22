fp = open(pwd() * "/day13/input")
lines = readlines(fp)

import Base.isless

function isless(l::Int64, r::Vector{<:Any})
    return isless([l], r)
end

function isless(l::Vector{<:Any}, r::Int64)
    return isless(l, [r])
end

function isless(l::Vector{<:Any}, r::Vector{<:Any})
    for (x, y) in zip(l,r)
        if (!(isless(x,y))) && (!(isless(y,x)))
            continue
        end
        return isless(x,y)
    end

    return isless(length(l), length(r))
end


inOrder = []
for i = 1:(length(lines)÷3 +1)
    eval(Meta.parse("a="*lines[3*(i-1)+1]))
    eval(Meta.parse("b="*lines[3*(i-1)+2]))

    if isless(a,b) 
        push!(inOrder, i)
    end
end

all = []
for i = 1:(length(lines)÷3 +1)
    eval(Meta.parse("a="*lines[3*(i-1)+1]))
    eval(Meta.parse("b="*lines[3*(i-1)+2]))

    push!(all, a)
    push!(all, b)
end

sAll = sort(all)
findall(x->x==[[2]], sAll)
findall(x->x==[[6]], sAll)