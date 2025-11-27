# using Revise
using Pkg
using Base

@assert Base.VERSION == v"1.11.3"

Path="sbm_config_Timoleague.toml"
# Path="sbm_config_Moselle.toml"

cd(raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow")
# Pkg.activate(".")
include(raw"src\Wflow.jl")
Main.Wflow.run(Path)