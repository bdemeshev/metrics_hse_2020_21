versioninfo()

y = [3 4 5]'
X = [1 1 1; 1 6 7]'

X
y
X'y
X'X

a = [4 5 5]
b = [4, 5, 5]

(X'X)^(-1) * X'y

(X'X)^(-1) * X'y

f(x) = 2x^3 + 3x^2 + 6


cos(X'X)
cos.(X'X)

cos((X'X)[1, 1])


[2x + 3y for x = 1:5, y in [10, 20, 30]]

μ = 7
χ = 8
(μ + 8) * (χ - 7)

χμθ = 9

using Pkg
Pkg.add("CSV") # установка пакета из интернета, делается 1 раз

using CSV, Econometrics, RDatasets # library (R) or import (python)

psid = dataset("Ecdat", "PSID") 
psid.Age
psid."Age"

describe(psid)
first(psid, 7)
last(psid, 6)

model_a = fit(EconometricModel, 
    @formula(log(1 + Earnings) ~ Age + Educatn), psid)

