maxCalories1::Float64 = 0
maxCalories2::Float64 = 0
maxCalories3::Float64 = 0

curCalories::Float64 = 0


for word in eachline(pwd() *  "/day1/input")
    if word == ""
        if curCalories > maxCalories1
            maxCalories3 = maxCalories2
            maxCalories2 = maxCalories1
            maxCalories1 = curCalories
        elseif curCalories > maxCalories2
            maxCalories3 = maxCalories2
            maxCalories2 = curCalories
        elseif curCalories > maxCalories3
            maxCalories3 = curCalories
        end

        curCalories = 0
        continue
    end

    curCalories += parse(Float64, word) 
end

display(maxCalories1 + maxCalories2 + maxCalories3)