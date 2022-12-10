fp = open(pwd() * "/day10/input")
lines = readlines(fp)

mutable struct CPU
    X::Int64
    clock::Int64
end

cpu = CPU(1, 0)
strength = []

for line in lines
    if startswith(line, "noop")
        cpu.clock += 1
        if (cpu.clock - 20) % 40 == 0
            push!(strength, cpu.clock*cpu.X)
        end
    elseif startswith(line, "addx")
        _, x = split(line, " ")
        for i = 1:2
            cpu.clock += 1
            if (cpu.clock - 20) % 40 == 0
                push!(strength, cpu.clock*cpu.X)
            end
        end
        cpu.X += parse(Int64, x)
    end
end

display(sum(strength))

CRT = Array{Char}(undef, 240)
cpu = CPU(1, 0)
pos = 1

for line in lines
    if startswith(line, "noop")
        cpu.clock += 1
        CRT[pos] = (cpu.X <= pos % 40 <= cpu.X + 2 ? '#' : '.' )
        pos += 1
    elseif startswith(line, "addx")
        _, x = split(line, " ")
        for i = 1:2
            cpu.clock += 1
            CRT[pos] = (cpu.X <= pos % 40 <= cpu.X + 2 ? '#' : '.' )
            pos += 1
        end
        cpu.X += parse(Int64, x)
    end
end

for i = 1:240
    print(CRT[i])
    if i % 40 == 0
        print("\n")
    end
end