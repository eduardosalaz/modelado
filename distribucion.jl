include("generador.jl")

function poisson(λ)
    numero = linealCongruencial(5, 7919, 19, 401, 5)[1]
    R = numero
    L = ℯ^-λ
    k = 0
    p = 1
    while p > L
        k = k + 1
        p = p * R
    end
    println(k-1)
    return k
end

function binomial(n, p)
    numeros = linealCongruencial(n, 7919, 19, 401, 5)
    x = 0
    for num ∈ numeros
        if num < p
            x = x + 1
        end
    end
    return x
end