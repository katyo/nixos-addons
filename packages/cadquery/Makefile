pkgs := cadquery_ocp cadquery_vtk casadi

#cadquery_ocp.ver := >=7.6
casadi.ver := >=3.6.5

default: $(patsubst %,%-whl.toml,$(pkgs))

%-whl.toml:
	deno run --allow-net --allow-run --allow-write pip-whl.ts $* "$($*.ver)"
