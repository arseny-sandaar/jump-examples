#=
We are going to the thrift store and need 99 cents. What is the least amount of
weight we need to carry?
i.e. a knapsack problem
We specify that you need at least 99 cents - does the answer change if you need exact change?
=#

using JuMP
using Cbc # Open source solver. Must support integer programming.

m = Model(Cbc.Optimizer)

# Variables represent how many of each coin we want to carry
@variable(m, pennies >= 0, Int)
@variable(m, nickels >= 0, Int)
@variable(m, dimes >= 0, Int)
@variable(m, quarters >= 0, Int)

# We need at least 99 cents
@constraint(m, 1 * pennies + 5 * nickels + 10 * dimes + 25 * quarters >= 99)

# Minimize mass (Grams)
# (source: US Mint)
@objective(m, Min, 2.5 * pennies + 5 * nickels + 2.268 * dimes + 5.670 * quarters)

# Solve
status = optimize!(m)

println("Minimum weight: ", objective_value(m), " grams")
println("using:")
println(round(value(pennies)), " pennies") # "round" to cast as integer
println(round(value(nickels)), " nickels")
println(round(value(dimes)), " dimes")
println(round(value(quarters)), " quarters")
