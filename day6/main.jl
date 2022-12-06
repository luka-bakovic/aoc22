fp = open(pwd() * "/day6/input")
lines = readlines(fp)

for line in lines
    l = 14
    while !(length(Set(line[l-13:l])) == 14)
        l += 1
    end
end