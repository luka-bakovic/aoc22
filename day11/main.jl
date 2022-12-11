fp = open(pwd() * "/day11/input")
lines = readlines(fp)

mutable struct Monkey
    items::Array{Int64}
    operation::Char
    operand::String
    testDivisor::Int64
    trueMonkey::Int64
    falseMonkey::Int64
    noInspections::Int64
end

nMonkeys::Int64 = (length(lines) + 1) ÷ 7
monkeys = Array{Monkey}(undef, nMonkeys)
for i = 1:nMonkeys
    items = [parse(Int64, x) for x in split(strip(split(lines[2+(i-1)*7], ':')[2]), ", ")]
    operation = lines[3+(i-1)*7][24]
    operand = last(split(lines[3+(i-1)*7], ' '))
    testDivisor = parse(Int64, last(split(lines[4+(i-1)*7], ' ')))
    trueMonkey = parse(Int64, last(split(lines[5+(i-1)*7], ' '))) + 1
    falseMonkey = parse(Int64, last(split(lines[6+(i-1)*7], ' '))) + 1

    monkeys[i] = Monkey(items, operation, operand, testDivisor, trueMonkey, falseMonkey, 0)
end

leastCommonMultiple = lcm([x.testDivisor for x in monkeys])

nRounds = 10000
for i = 1:nRounds
    for j = 1:nMonkeys
        # print("\n\n")
        # print("Monkey ", j-1, ":\n")
        tempItems = deepcopy(monkeys[j].items)
        monkeys[j].items = []

        for item in tempItems
            # print("\tMonkey ", j-1, " inspects an item of worry level ",item,"\n")
            monkeys[j].noInspections += 1
            if monkeys[j].operand == "old"
                item = (monkeys[j].operation == '*' ? item * item : item + item)
            else
                x = parse(Int64, monkeys[j].operand)
                item = (monkeys[j].operation == '*' ? item * x : item + x)
            end
            # print("\tWorry level is now ", item, "\n")
            item = item % leastCommonMultiple

            if item % monkeys[j].testDivisor == 0
                # print("\tItem of worry level ", item, " is thrown to monkey ", monkeys[j].trueMonkey - 1,"\n")
                push!(monkeys[monkeys[j].trueMonkey].items, item)
            else
                # print("\tItem of worry level ", item, " is thrown to monkey ", monkeys[j].falseMonkey - 1,"\n")
                push!(monkeys[monkeys[j].falseMonkey].items, item)
            end
        end
    end
end

for i = 1:nMonkeys
    print("Monkey ", i-1, " inspected items ", monkeys[i].noInspections, " times.\n")
end

display(sort([x.noInspections for x in monkeys]))