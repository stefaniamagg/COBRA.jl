## packages to be installed on the node
# Pkg.add("Coverage");
# Pkg.add("Clp");
# Pkg.add("CPLEX");
# Pkg.add("Gurobi");
# Pkg.add("Cbc");
# Pkg.add("MAT");
# Pkg.add("Mosek");
# Pkg.add("MATLAB");

# print out the version and the architecture
echo "ARCH = $ARCH"
echo "JULIA_VER = $JULIA_VER"

# launch the test script
if [ "$ARCH" == "Linux" ]; then
    if [ "$JULIA_VER" == "v0.6.3" ]; then

        # remove th julia directory to clean the installation directory
        rm -rf ~/.julia/v0.6/COBRA

        # add the COBRA module
        /mnt/prince-data/JULIA/$JULIA_VER/bin/julia --color=yes -e 'Pkg.clone(pwd()); Pkg.test(pwd(), coverage = true);'

        # adding coverage
        /mnt/prince-data/JULIA/$JULIA_VER/bin/julia --color=yes -e 'using Coverage; Codecov.submit_generic(process_folder(), codecov_url="https://codecov.io");'

    elif [ "$JULIA_VER" == "v0.7.0" ]; then
        # temporary addition for julia 0.6 until new version of MAT tagged
        #/mnt/prince-data/JULIA/$JULIA_VER/bin/julia --color=yes -e 'using Pkg; Pkg.add("MAT"); Pkg.checkout("MAT")'

        # add the COBRA module
        /mnt/prince-data/JULIA/$JULIA_VER/bin/julia --color=yes -e 'using Pkg; Pkg.clone(pwd())'
        #/mnt/prince-data/JULIA/$JULIA_VER/bin/julia --color=yes -e 'using Pkg; Pkg.build()'
        #/mnt/prince-data/JULIA/$JULIA_VER/bin/julia --color=yes -e 'using Pkg; Pkg.test("COBRA",coverage=true)'
    fi
fi

CODE=$?
exit $CODE

