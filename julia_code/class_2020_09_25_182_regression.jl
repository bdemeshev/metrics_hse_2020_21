# установка пакетов, выполняется один раз!
using Pkg
Pkg.add("CSV")
Pkg.add("RDatasets")
Pkg.add("Econometrics")
Pkg.add("DataFrames")
# то, что выше, делаем один раз :)

# матрички :)
a = [5 7 8 -1] # строка
b = [5 7 8 -1]' # столбец
b = [5, 7, 8, -1] # столбец
b = [5; 7; 8; -1] # столбец

y = [3 4 5 -2]' # столбец зависимой переменной
X = [1 3; 1 7; 1 5; 1 5] # матрица регрессоров (предикторов)
X'y
X'X
beta_hat = (X'X)^(-1) * X'y

y .* y # поточечное (поэлеметное умножение)

f(x) = 2x^3 + 3x - 7
f(4)

[2x + 5y for x = 2:8, y in [5, -3, 9]]

using RDatasets, Econometrics # аналог import numpy... 

psid = dataset("Ecdat", "PSID") # Panel Study of Income Dynamics
psid

psid.Age
psid."Age"
psid[!, "Age"]
psid[2:5, ["Age", "Educatn"]]

model_0 = fit(EconometricModel,
    @formula(log(1 + Earnings) ~ Age + Educatn), psid)


