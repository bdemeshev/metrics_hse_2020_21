using RDatasets, Econometrics # аналог import numpy... 
using Gadfly
using CSV
using GLM
using LinearAlgebra


psid = dataset("Ecdat", "PSID") # Panel Study of Income Dynamics
psid

psid.Age
psid."Age"
psid[!, "Age"]
psid[2:5, ["Age", "Educatn"]]

model_0 = fit(EconometricModel,
    @formula(log(1 + Earnings) ~ Age + Educatn), psid)

model_1 = fit(EconometricModel,
    @formula(log(1 + Earnings) ~ Age), psid)

# ftest(model_0)


vcov(model_0)
vcov(model_0, HC0)
vcov(model_0, HC2)



confint(model_0, level=0.9, se=sqrt.(diag(vcov(model_0, HC2))))

diag(vcov(model_0, HC2))

residuals(model_0)
fitted(model_0)
coef(model_0)



?vcov

diamonds = dataset("ggplot2", "diamonds") # diamonds

demo = DataFrame(x=[4, 5, 6], y=[6, missing, 9], z=5:7, w=9:2:13)

demo[2:3, ["x", "y"]]


missing

x = [4, 5, missing]

describe(demo)

demo[!, "x"] *= 10;

demo[!, "x"]


cos(sin(0))
0 |> sin |> cos


iris = dataset("datasets", "iris")

plot(iris, x=:SepalLength, y=:SepalWidth)
plot(iris, x=:SepalLength, Geom.bar)
plot(iris, x=:SepalLength, Geom.bar, Guide.xlabel("Длина чашелистика в мм"))

# import Pkg; Pkg.add("Gadfly")

CSV.write("demo.csv", demo)

aaa = CSV.read("demo.csv")

pwd()
cd("/home/boris/Documents/metrics_hse_2020_21/")

# using DataFramesMeta

# import Pkg; Pkg.add("DataFramesMeta")

