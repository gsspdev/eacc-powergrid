# Virtual Power Plant using NREL/SIIP data
module VPP
using SIIPExamples
using PowerSystems

const UBE = PowerSystems

# Load data
file_dir = joinpath(
    dirname(dirname(pathof(SIIPExamples))),
    "script",
    "4_PowerSimulationsDynamics_examples",
    "Data",
)
omib_sys = System(joinpath(file_dir, "OMIB.raw"))

