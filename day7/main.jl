fp = open(pwd() * "/day7/input")
lines = readlines(fp)

mutable struct Directory
    name::String
    bytes::Int64
    children::Vector{Directory}
    parent::Union{Nothing, Directory}
end

cwd = Directory(" ", 0, [], nothing)
root = cwd
for line in lines
    cmds = collect(eachsplit(line, " "))
    if cmds[1] == "\$"
        if cmds[2] == "cd"
            if cmds[3] == ".."
                cwd = cwd.parent
                continue
            end
            names = [a.name for a in cwd.children]
            if !(cmds[3] in names)
                push!(cwd.children, Directory(cmds[3], 0, [], cwd))
            end
            for a in cwd.children
                if a.name == cmds[3]
                    cwd = a
                end
            end
            continue
        else
            print("Listing: ", cwd.name, "\n")
        end
    elseif cmds[1] == "dir"
        names = [a.name for a in cwd.children]
        if !(cmds[1] in names)
            push!(cwd.children, Directory(cmds[1], 0, [], cwd))
        end
    else
        names = [a.name for a in cwd.children]
        if !(cmds[2] in names)
            push!(cwd.children, Directory(cmds[2], parse(Int64, cmds[1]), [], cwd))
        end
    end

end

function size(d::Directory)
    if d.children == []
        return d.bytes
    else
        return sum([size(a) for a in d.children])
    end
end

global dirs = []
function printAllSizes(d::Directory)
    global sums, dirs
    if d.children == []
        return 0
    else
        x = sum([size(a) for a in d.children])
        print(d.name, " ", x, "\n")
        push!(dirs, (d.name, x))
        for c in d.children
            printAllSizes(c)
        end
        return x
    end
end

printAllSizes(root)

sort(dirs, by=x->x[2])

# try and stop me from using a magic number
sort([a for a in dirs if a[2] >= 30000000 - (70000000 - 41412830)], by=x->x[2])