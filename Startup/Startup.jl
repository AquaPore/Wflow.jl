
using Pkg
Path="sbm_config_simple.toml"
cd(raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow")
Pkg.activate(".")
include(raw"src\Wflow.jl")
Main.Wflow.run(Path)
