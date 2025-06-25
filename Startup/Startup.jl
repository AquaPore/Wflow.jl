Path="sbm_config.toml"

using Pkg
cd(raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow")
Pkg.activate(".")
include(raw"src\Wflow.jl")
Main.Wflow.run(Path)
