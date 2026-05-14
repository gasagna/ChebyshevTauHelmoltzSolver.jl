using BenchmarkTools
using Printf
using ChebyshevTauHelmoltzSolver

# odd sizes
Ps = 9:2:19

fun(f, g, h) = (f .= g)

for P in Ps

    f = ChebCoeffs(rand(P+1))
    g = ChebCoeffs(rand(P+1))
    h = ChebCoeffs(rand(P+1))

    # solve in place on a copy
    # t = @belapsed fun($f, $g, $h)
    loc = Val(:Left)
    t1 = @belapsed ChebyshevTauHelmoltzSolver._ddy($f, $loc)
    t2 = @belapsed ChebyshevTauHelmoltzSolver._ddy2($f, $loc)

    # print time per grid point
    @printf "%04d %.3f %.3f\n" P 10^9*t1/P 10^9*t2/P
end
