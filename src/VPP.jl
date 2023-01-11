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

# Create a new system for the VPP to highlight Dynamic Generators
#Machine
machine_classic() = BaseMachine(
    0.0, #R
    0.2995, #Xd_p
    0.7087, #eq_p
)

#Shaft
shaft_damping() = SingleMass(
    3.148, #H
    2.0, #D
)

#AVR
avr_none() = AVRFixed(0.0)
#TG
tg_none() = TGFixed(1.0) #efficiency
#PSS
pss_none() = PSSFixed(0.0)

function dyn_gen_classic(generator)
    return DynamicGenerator(
        generator,
        1.0, #ω_ref
        machine_classic(), #machine
        shaft_damping(), #shaft
        avr_none(), #avr
        tg_none(), #tg
        pss_none(), #pss
    )
end

#Collect the static gen in the system
static_gen = get_component(Generator, omib_sys, "generator-102-1")
#Creates the dynamic generator
dyn_gen = dyn_gen_classic(static_gen)
#Add the dynamic generator the system
add_component!(omib_sys, dyn_gen)

to_json(omib_sys, "universal_based_electricity.json")