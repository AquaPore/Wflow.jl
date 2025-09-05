using Pkg

# Path="sbm_config_simple_Timoleague.toml"
# Path="sbm_config_Ballycanew.toml"
# Path="sbm_config_Castledockrell.toml"
# Path="sbm_config_Corduff.toml"
# Path="sbm_config_Dunleer.toml"
Path="sbm_config_Cregduff.toml"

Path_Home = raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow"
cd(raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow")
Pkg.activate(".")
include(raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow\src\Wflow.jl")
Main.Wflow.run(Path)
