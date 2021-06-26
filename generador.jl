n = 100
m = 7919
a = 19
c = 401
x = 5
for i in 1:n
    r = (a * x + c) % m
    global x = r
    #r = r / m #normalizar
    println("Numero $i: $r")
end