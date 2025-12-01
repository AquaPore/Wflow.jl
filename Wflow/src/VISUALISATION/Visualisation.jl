module visualisation
	using CSV, Dates, Tables
	using CairoMakie, GLMakie
"""
    VISUALISATION()
	 To Visualise the output streamflow

	Joseph A.P. POLLACCO
"""

	function VISUALISATION(🎏_CatchmentName = "Timoleague")

		# Path of observed forcing data
			Path_Root_Data  = raw"D:\JOE\MAIN\MODELS\WFLOW\Data"
			Path_Forcing    = raw"InputTimeSeries\TimeSeries_Process"

			Path_TimeSeries = joinpath(Path_Root_Data, "$(🎏_CatchmentName)", Path_Forcing, "forcing." * "$(🎏_CatchmentName)" * ".csv" )
			println(Path_TimeSeries)
			@assert isfile(Path_TimeSeries)

		# Path of Qwflow data
         Path_Root_Wflow = raw"D:\JOE\MAIN\MODELS\WFLOW\Wflow.jl\Wflow\Data\output"
         Path_Qwflow     = joinpath(Path_Root_Wflow,  "$(🎏_CatchmentName)", "output_" * "$(🎏_CatchmentName)" * "_hourly.csv" )
			println(Path_Qwflow)
			@assert isfile(Path_Qwflow)

		# Reading Wflow data
         DataWflow  = CSV.File(Path_Qwflow; header=true)
         Time_Wflow = convert(Vector, Tables.getcolumn(DataWflow, :time))
         Qwflow     = convert(Vector{Float64}, Tables.getcolumn(DataWflow, :QriverGauge_1))

			Start_DateTime = Time_Wflow[1]
			End_DateTime =  Time_Wflow[end]

			printstyled("Starting Dates = $(Start_DateTime) \n"; color=:green)
			printstyled("Ending Dates = $(End_DateTime) \n"; color =:green)


		# Reading climate data
         Data₀  = CSV.File(Path_TimeSeries; header=true)
         Year   = convert(Vector{Int64}, Tables.getcolumn(Data₀, :Year))
         Month  = convert(Vector{Int64}, Tables.getcolumn(Data₀, :Month))
         Day    = convert(Vector{Int64}, Tables.getcolumn(Data₀, :Day))
         Hour   = convert(Vector{Int64}, Tables.getcolumn(Data₀, :Hour))

         Precip = convert(Vector{Float64}, Tables.getcolumn(Data₀, :precip))
         Pet    = convert(Vector{Float64}, Tables.getcolumn(Data₀, :pet))
         Temp   = convert(Vector{Float64}, Tables.getcolumn(Data₀, :temp))
         Qobs₀  = convert(Vector, Tables.getcolumn(Data₀, :RiverDischarge_cumec))

			Time_Forcing = Dates.DateTime.(Year, Month, Day, Hour) #  <"standard"> "proleptic_gregorian" calendar

		# Selecting time which is between Start_DateTime and End_DateTime
         Nit₀ = length(Year)
         True = fill(false::Bool, Nit₀)
			for iT=1:Nit₀
				if (Start_DateTime ≤ Time_Forcing[iT] ≤ End_DateTime)
					True[iT] = true
				end
				if Time_Forcing[iT] > End_DateTime
					break
				end
			end # for iT=1:Nit

		# Reducing size of the time series
         Precip       = Precip[True[:]]
         Pet          = Pet[True[:]]
         Temp         = Temp[True[:]]
         Time_Forcing = Time_Forcing[True[:]]
         Qobs₀        = Qobs₀[True[:]]

		# Solve problem of format
			N  = count(True)
			Qobs = zeros(Float64, N)
			for (i, iiRiverDischarge) in enumerate(Qobs₀)
				Qobs[i] = parse(Float64, iiRiverDischarge)
			end

			println(length(Qobs))
			println(length(Qwflow))



			# @assert length(Precip) == length(Qwflow)

		# =======================
			# # Dimensions of figure
			# 	Height= 600
			# 	Width = 1000

			GLMakie.activate!()
			Fig = CairoMakie.Figure(font="Sans", titlesize=10,  xlabelsize=10, ylabelsize=10, labelsize=10, fontsize=10)

			Axis_1 = Axis(Fig[1, 1], yticklabelcolor=:black, yaxisposition=:right, rightspinecolor=:black, ytickcolor=:black, ylabel= L"$\Delta ET$ $[mm]$", xgridvisible=false, ygridvisible=false)

				hidexdecorations!(Axis_1, grid=false, ticks=true, ticklabels=true)

				Plot_Et = GLMakie.lines!(Axis_1, Time_Forcing, Pet, linewidth=2, color=:darkgreen)

				Axis_1b = GLMakie.Axis(Fig[1,1], ylabel= L"$\Delta Precipitation$ $[mm]$", xgridvisible=false, ygridvisible=false)

					GLMakie.barplot!(Axis_1b, Time_Forcing, Precip, strokecolor=:blue, strokewidth=1.5, color=:cyan)

				hidexdecorations!(Axis_1b, grid=false, ticks=true, ticklabels=true)

			Axis_2 = Axis(Fig[2,1], ylabel= L"$\Delta Qriver$ $[m^{3}]$", xgridvisible=false, ygridvisible=false)

				GLMakie.lines!(Axis_2, Time_Forcing, Qobs, linewidth=2.5, color=:red, label= "obs" )
				GLMakie.lines!(Axis_2, Time_Wflow, Qwflow, linewidth=2.5, color=:blue, label= "wflow")

				GLMakie.colgap!(Fig.layout, 15)
				GLMakie.rowgap!(Fig.layout, 15)
				GLMakie.resize_to_layout!(Fig)
				GLMakie.trim!(Fig.layout)
				GLMakie.display(Fig)

			Path_SaveFig = joinpath(Path_Root_Wflow, "$(🎏_CatchmentName)", "Plot_" * "$(🎏_CatchmentName)" * ".svg" )
			GLMakie.save(Path_SaveFig, Fig, pt_per_unit=0.5) # size = 600 x 450 pt


	printstyled(" ==== End ====\n"; color =:red)
	end

		# GLMakie.activate!()
		# Makie.inline!(false)  # Make sure to inline plots into Documenter output!



		# Ax_1 = Makie.Axis(Fig[1, 1])

		# Plot = lines!(Ax_1, Time_Array, RiverDischarge, linestyle=:dash)

end


