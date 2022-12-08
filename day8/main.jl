fp = open(pwd() * "/day8/input")
lines = readlines(fp)
A = map(row -> [parse.(Int,a) for a in row[1]], split.(lines))

xlen, ylen = length(lines), length(lines[1])
invisible = zeros(Int64, xlen, ylen)

for i = 2:xlen-1
    for j = 2:ylen-1

        # up
        for k = 1:j-1
            if A[i][k] >= A[i][j]
                invisible[i,j] += 1
                break
            end
        end

        # down
        for k = j+1:ylen
            if A[i][k] >= A[i][j]
                invisible[i,j] += 1
                break
            end
        end

        #left
        for k = 1:i-1
            if A[k][j] >= A[i][j]
                invisible[i,j] += 1
                break
            end
        end

        #right
        for k = i+1:xlen
            if A[k][j] >= A[i][j]
                invisible[i,j] += 1
                break
            end
        end

    end
end

display(xlen*ylen-length(findall(invisible .==4)))

maxScenic = 0
maxLoc = (0,0)
for i = 2:xlen-1
    for j = 2:ylen-1

        # up
        u = 0
        for k = j-1:-1:1
            if A[i][k] >= A[i][j]
                u = j - k 
                break
            end
            u += 1
        end

        # down
        d = 0
        for k = j+1:ylen
            if A[i][k] >= A[i][j]
                d = k - j 
                break
            end
            d += 1
        end

        # left
        l = 0
        for k = i-1:-1:1
            if A[k][j] >= A[i][j]
                l = i - k 
                break
            end
            l += 1
        end

        # right
        r = 0
        for k = i+1:xlen
            if A[k][j] >= A[i][j]
                r = k - i 
                break
            end
            r += 1
        end

        if u*d*l*r > maxScenic
            maxScenic = u*d*l*r
            maxLoc = (i,j)
        end

    end
end

print(maxScenic)