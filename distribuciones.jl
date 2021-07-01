include("generador.jl")
using Statistics
function normal()
    generados = linealCongruencial(600, 7919, 19, 401, 5)
    normal = []
    μ = mean(generados)
    σ = std(generados)
    inicio = 1
    fin = 12
    for i in 1:50
        sample = generados[inicio:fin]
        suma = sum(sample)
        x = μ  + σ*(suma-6)
        norm = x
        println(norm)
        push!(normal, norm)
        inicio += 12
        fin +=12
    end
    return normal
end

function uniforme(a, b)
    println("----------UNIFORME----------")
    generados = linealCongruencial(100, 7919, 19, 401, 5)
    uniforme = []
    for R ∈ generados
        x = a + R * (b-a)
        unif = x
        println(unif)
        push!(uniforme, unif)
    end
    return uniforme
end

function exponencial(λ)
    println("----------EXPONENCIAL----------")
    generados = linealCongruencial(100, 7919, 19, 401, 5)
    exponencial = []
    for R ∈ generados
        expo = -log(R)/λ
        println(expo)
        push!(exponencial, expo)
    end
    return exponencial
end

normal()
uniforme(0, 10)
exponencial(1.5)