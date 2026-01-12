# using Revise
# Pkg.instantiate()
using Pkg
using Base

🎏_Wflow = true
🎏_Plot = false


@assert Threads.nthreads() == 32

if 🎏_Wflow
	@assert Base.VERSION == v"1.11.8"
	Path="sbm_config_Timoleague.toml"
	# Path="sbm_config_Moselle.toml"

	cd(raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow")
	Pkg.activate(".")
	include(raw"src\Wflow.jl")
	Main.Wflow.run(Path)
end

if 🎏_Plot
	cd("D:\\JOE\\MAIN\\MODELS\\WFLOW\\Wflow.jl\\Wflow")
	# Pkg.activate(".")
	include(raw"src\VISUALISATION\Visualisation.jl")
	visualisation.VISUALISATION()
end