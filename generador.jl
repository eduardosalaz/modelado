function linealCongruencial(n, m, a, c, x)
    resultados = Float64[]
    for i ∈ 1:n
        r = (a * x + c) % m
        x = r
        r = r / m #normalizar
        push!(resultados, r)
        #println("Numero $i: $r")
    end
    return resultados
end