# дз (!)
# 1. графики
# 2. базовые операции с данными 
# 3. операции с несколькими табличками
# 4. группировка табличных данных
# 5. регрессия
# 6. PCA - SVD
# 7. гетероскедастичность
# предложить своё :)

versioninfo()

using RDatasets # импортировать обучающие данные из R
using Econometrics
using GLM
using CSV # чтение-запись .csv
using Gadfly # графики
using LinearAlgebra

# если чего-то из этого нет
# using Pkg; Pkg.add("GLM")
# using Pkg ~ import Pkg
# Pkg.add("GLM")

diamonds = dataset("ggplot2", "diamonds")

x = 5
x = 5;

pwd() # посмотреть
cd("/home/boris/Downloads/") # сменить 

CSV.write("diam.csv", diamonds)
d2 = CSV.read("diam.csv")

# кусочек
diamonds[2:5, ["Cut", "Table"]]
diamonds[2:5, [:Cut, :Table]]

diamonds[!, ["Cut"]]

# столбец
diamonds.Cut
diamonds["Cut"]
diamonds[:Cut]
diamonds["Cut_copy"] = diamonds["Cut"]
diamonds[:Cut_copy2] = diamonds["Cut"]

diamonds.Cut_copy3 = diamonds["Cut"]




# описательное :)
describe(diamonds)
head(diamonds)
tail(diamonds)


# разница 
[5, 6] == 5 # правда ли что вектор и число это одно и то же?
[5, 6] .== 5 # поточечно есть ли равенство?

# отбор строк

diamonds[diamonds.X > 6, ["Cut"]] # не сработает
diamonds[diamonds.X .> 6, ["Cut"]] # сработает (!)


# идея как сделать: robust_model = model(vce=HC1)
?model

model = fit(EconometricModel, @formula(Price ~ Carat + X + Y + Z), diamonds) # единичный столбец добавляется автоматически!
model_nointercept = fit(EconometricModel, @formula(Price ~ 0 + Carat + X + Y + Z), diamonds) # единичный столбец не добавляем

vcov(model) # ковариационная матрица обычная, неустойчивая к гетероскедастичности
# RSS/(n-k) * (X'X)^{-1}

vcov(model, HC1) # устойчивая к гетероскедастичности
vcov(model, HC0) # устойчивая к гетероскедастичности, оценки Уайта
vcov(model, HC3) # устойчивая к гетероскедастичности! выдаст ошибку

# \hat\beta = (X'X)^{-1}X'y
# \hat\Var\hat\beta = (X'X)^{-1}X' \hat \Sigma X(X'X)^{-1}
# [k x k] = [5 x 5]
# \hat \Sigma = [50000 x 50000] => out of memory

# извлечем что-то из модели :)
coef(model) # оценки коэффициентов
residuals(model) # остатки
fitted(model) # прогнозы 
coeftable(model) # табличка
sqrt.(diag(vcov(model))) # стандартные ошибки коэффициентов
sqrt.([5, 6]) # поэлементный корень
sqrt([5, 6]) # не сработает!
sqrt(vcov(model)) # матричный корень!

# доверительные интервалы для коэффициентов неустойчивые к гетероскедастичности
confint(model, level=0.9) 

# доверительные интервалы для коэффициентов устойчивые к гетероскедастичности
confint(model, level=0.9, se=sqrt.(diag(vcov(model, HC1))))

# графики
iris = dataset("datasets", "iris")
iris
plot(iris, x=:SepalLength, y=:PetalLength, 
    Guide.xlabel("Длина чашелистика в мм"))

plot(iris, x=:SepalLength, Geom.bar, 
    Guide.xlabel("Длина чашелистика в мм"))

# Gadfly

# создать новую переменную 
diamonds["price2"] = diamonds[:Price] .^ 2
diamonds[:price3] = diamonds[:Price] .^ 2


# тест Уайта
# (!) не подвешивайте выбор робастные-обычные стандартные ошибки на результат теста Уайта
# (!) сразу используйте робастные стандартные ошибки
# (!) тест Уайта только для проверки гипотезы, есть гетероскедастиность или нет (!)
diamonds["resid2"] = residuals(model) .^ 2
aux_model = fit(EconometricModel, @formula(resid2 ~ Carat + X + Carat^2 + X^2 + X*Carat), diamonds)
# PATSY model syntax


# LR-test likelihood ratio test = тест отношения правдоподобия
# (H0, restricted) model_simple ∈ model_complex (Ha, unrestricted)
# LR = 2 * (ln L_ur - ln L_r) → χ^2 (d), где d — разница в числе параметров между simple и complex model
# H0: @formula(resid2 ~ 1) - нет гетероскедастичности
# Ha: @formula(resid2 ~ Carat + X + Carat^2 + X^2 + X*Carat) - есть гетероскедастичность
# H0 отвергается

β = 5
χ = 6
β = 9
β

# штрафные критерии
aic(model)
bic(model)



# McReel Econometrics in julia
# https://github.com/mcreel/Econometrics/
# quantecon julia 
# https://julia.quantecon.org/
# MIT, Computational Thinking, 2020
# https://computationalthinking.mit.edu/Fall20/
# 3blue1brown