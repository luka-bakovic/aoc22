fp = open(pwd() * "/day12/input")
lines = readlines(fp)
r = length(lines)
c = length(lines[1])


foundAt = []
for i = 1:r
    for j = 1:c
        if lines[i][j] == 'a'
            cnt = 0
            vList = zeros(Int64, r, c)
            toDo = [(i,j,1)]
            while toDo != [] 
                cnt += 1
                x, y, lvl  = popfirst!(toDo)
                vList[x, y] = lvl
                grads = []

                if lines[x][y] == 'z'
                    print("Found at lvl ", lvl, "\n")
                    push!(foundAt, lvl)
                end

                myHeight = (lines[x][y] == 'S' ? 400 : Int(lines[x][y]))
                
                if x > 1
                        hDiff = Int(lines[x-1][y]) - myHeight
                        if hDiff <= 1 push!(grads, (x-1,y, hDiff, lvl+1)) end
                end
                if x < r
                        hDiff = Int(lines[x+1][y]) - myHeight
                        if hDiff <= 1 push!(grads, (x+1,y, hDiff, lvl+1)) end
                end

                if y > 1
                        hDiff = Int(lines[x][y-1]) - myHeight
                        if hDiff <= 1 push!(grads, (x,y-1, hDiff, lvl+1)) end
                end
                if y < c
                        hDiff = Int(lines[x][y+1]) - myHeight
                        if hDiff <= 1 push!(grads, (x,y+1, hDiff, lvl+1)) end
                end


                sort!(grads, by = x -> x[3])
                #display(grads)
                for item in grads
                    if (!((item[1], item[2], item[4]) in toDo)) && (vList[item[1], item[2]] == 0 || vList[item[1], item[2]] > item[4] )
                        push!(toDo, (item[1], item[2], item[4]))
                    end
                end
            end
        end
    end
end