include("generador.jl")
include("distribucion.jl")

function actualizarCaja(i)
    if i == 1
        if tac₁ > 0
            toc₁ = toc₁ - tac₁
            tac₁ = 0
            if Cc₁ > 0
                Cc₁ = Cc₁ - 1
                tac₁ = poisson(λ)
            end
        elseif tac₁ == 0
            Nac₁ = Nac₁ + 1
        else
        end
    elseif i == 2
        if tac₂ > 0
            toc₂ = toc₂ - tac₂
            tac₂ = 0
            if Cc₂ > 0
                Cc₂ = Cc₂ - 1
                tac₂ = poisson(λ)
            end
        elseif tac₂ == 0
            Nac₂ = Nac₂ + 1
        else
        end
    else
        if tac₃ > 0
            toc₃ = toc₃ - tac₃
            tac₃ = 0
            if Cc₃ > 0
                Cc₃ = Cc₃ - 1
                tac₃ = poisson(λ)
            end
        elseif tac₃ == 0
            Nac₃ = Nac₃ + 1
        else
        end
    end
end

function actualizarDrivethru()
    if tae₁ > 0
        toe₁ = toe₁ - tae₁
        tae₁ = 0
    elseif tae₁ == 0
        ce₁ = ce₁ - 1
        ce₂ = ce₂ + 1
        tae₁ = poisson(λ)
        if tae₂ > 0
            toe₂ = toe₂ - tae₂
            tae₂ = 0
        elseif tae₂ == 0
            ce₂ = ce₂ - 1
            ce₃ = ce₃ + 1
            tae₂ = poisson(λ)
            if tae₃ > 0
                toe₃ = toe₃ - tae₃
                tae₃ = 0
            elseif tae₃ == 0
                ce₃ = ce₃ - 1
                tae₃ = poisson(λ)
                if ce₃ > 0
                    Nd = Nd + 1
                end
            end
        end
    end
        
end

function main()    
    print("Ingrese tiempo limite de la simulacion: ")
    limite = readline()
    print("Ingrese λ: ")
    λ = readline()
    print("Ingrese n: ")
    n = readline()
    print("Ingrese p: ")
    p = readline()
    println("Iniciando simulación con tiempo limite $limite")
    tL = binomial(n, p) + 1
    r = 0
    Δ = 0
    Cc₁ = 0
    Cc₂ = 0
    Cc₃ = 0
    Cd = 0
    tet = 0
    tecp = 0
    tedp = 0
    toc₁ = 0
    toc₂ = 0
    toc₃ = 0
    tod₁ = 0
    tod₂ = 0
    tod₃ = 0
    Nt = 0
    Nc = 0
    Nd = 0
    Nac = 0
    Nac₁ = 0
    Nac₂ = 0
    Nac₃ = 0
    Nad = 0
    tac₁ = poisson(λ)
    tac₂ = poisson(λ)
    tac₃ = poisson(λ)
    tae₁ = poisson(λ)
    tae₂ = poisson(λ)
    tae₃ = poisson(λ)
    n = 100
    m = 7919
    a = 19
    c = 401
    x = 5
    aleatorios = linealCongruencial(n,m,a,c,x)
    while r <= limite
        tiempos = [tL, tac₁, tac₂, tac₃, tae₁, tae₂, tae₃]
        println(tiempos)
        tiempossin0 = [ tiempo for tiempo in tiempos if(tiempo > 0) ]
        println(tiempossin0)
        global Δ = minimum(tiempossin0)
        global r = r + Δ
        sleep(2)
        global tet = tet + Cc₁ * Δ + Cc₂ * Δ + Cc₃ * Δ + Cd * Δ
        global tL = tL - Δ
        if tL == 0
            global Nt = Nt + 1
            t = popfirst!(aleatorios)
            if t <= 0.7
                colas = [Cc₁, Cc₂, Cc₃]
                optimIndex = argmin(colas)
                if optimIndex == 1
                    global Cc₁ = Cc₁ + 1
                elseif optimIndex == 2
                    global Cc₂ = Cc₂ + 1
                else
                    global Cc₃ = Cc₃ + 1
                end
            else
                global Cd = Cd + 1
            end
            tL = binomial(n, p) + 1
        else
            global tac₁ = tac₁ - Δ
            global tac₂ = tac₂ - Δ
            global tac₃ = tac₃ - Δ
            global tae₁ = tae₁ - Δ
            global tae₂ = tae₂ - Δ
            global tae₃ = tae₃ - Δ
            for i in 1:3
                if i == 1
                    if tac₁ > 0
                        global toc₁ = toc₁ - tac₁
                        global tac₁ = 0
                        if Cc₁ > 0
                            Cc₁ = Cc₁ - 1
                            tac₁ = poisson(λ)
                        end
                    elseif tac₁ == 0
                        global Nac₁ = Nac₁ + 1
                    else
                    end
                elseif i == 2
                    if tac₂ > 0
                        global toc₂ = toc₂ - tac₂
                        global tac₂ = 0
                        if Cc₂ > 0
                            Cc₂ = Cc₂ - 1
                            tac₂ = poisson(λ)
                        end
                    elseif tac₂ == 0
                        global Nac₂ = Nac₂ + 1
                    else
                    end
                else
                    if tac₃ > 0
                        global toc₃ = toc₃ - tac₃
                        global tac₃ = 0
                        if Cc₃ > 0
                            Cc₃ = Cc₃ - 1
                            tac₃ = poisson(λ)
                        end
                    elseif tac₃ == 0
                        global Nac₃ = Nac₃ + 1
                    else
                    end
                end
            end
            actualizarDrivethru()
            println("Longitud de cola caja 1: $c1")
            println("Longitud de cola caja 2: $c2")
            println("Longitud de cola caja 3: $c3")
            println("Longitud de cola estación 1: $ce1")
            println("Longitud de cola estación 2: $ce2")
            println("Longitud de cola estación 3: $ce3")
            println("Δ: $delta")
            println("Numero de clientes totales: $Nt")
            println("Numero de clientes en caja: $Nc")
            println("Numero de clientes en drive-thru: $Nd")
            println("----------------------------------------")
        end
    end
    calcularDatos()
    println("**********************************************")
    println("FIN DE LA SIMULACIÓN: TIEMPO LIMITE ALCANZADO")
    println("Datos de la simulación: ")
    println("Tiempo de espera promedio caja 1: $tecp1" )
    println("Tiempo de espera promedio caja 2: $tecp2")
    println("Tiempo de espera promedio caja 3: $tecp3")
    println("Tiempo de espera promedio estación 1: $teep1")
    println("Tiempo de espera promedio estación 2: $teep2")
    println("Tiempo de espera promedio estación 3: $teep3")
    println("Tiempo de espera total caja 1: $tetc1")
    println("Tiempo de espera total caja 2: $tetc2")
    println("Tiempo de espera total caja 3: $tetc3")
    println("Tiempo de espera total estación 1: $tete1")
    println("Tiempo de espera total estación 2: $tete2")
    println("Tiempo de espera total estación 3: $tete3")
    println("Tiempo de ocio caja 1: $toc1")
    println("Tiempo de ocio caja 2: $toc2")
    println("Tiempo de ocio caja 3: $toc3")
    println("Tiempo de ocio estación 1: $toe1")
    println("Tiempo de ocio estación 2: $toe2")
    println("Tiempo de ocio estación 3: $toe3")
    println("Clientes atendidos en caja 1: $ntc1")
    println("Clientes atendidos en caja 2: $ntc2")
    println("Clientes atendidos en caja 3: $ntc3")
    println("Clientes atendidos en drive-thru: $ntd")
    println("Clientes perdidos: $np")
end

main(0)