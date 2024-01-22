rule targets:
    input:
        "data/ghcnd_all.tar.gz",
        "data/ghcnd-inventory.txt",
        "data/ghcnd-stations.txt",
        "data/ghcnd_all_files.txt",
        "data/ghcnd_tidy.tsv.gz",
        "data/ghcnd_regions.tsv",
	    "index.html"

rule get_all_archive: 
    input:
        script="code/get_GHCNDdata_master.sh"
    output:
        "data/ghcnd_all.tar.gz"
    params:
        file="ghcnd_all.tar.gz"
    shell: 
        """
        {input.script} {params.file}
        """



rule get_all_filenames: 
    input:
        script="code/get_ghcnd_allfiles.sh",
        archive="data/ghcnd_all.tar.gz"
    output:
        "data/ghcnd_all_files.txt"
    shell:
         """
         {input.script}
         """


rule get_inventory: 
    input:
        script="code/get_GHCNDdata_master.sh"
    output:
        "data/ghcnd-inventory.txt"
    params:
        file="ghcnd-inventory.txt"
    shell:
         """
         {input.script} {params.file}
         """


rule get_station: 
    input:
        script="code/get_GHCNDdata_master.sh"
    output:
        "data/ghcnd-stations.txt"
    params:
        file="ghcnd-stations.txt"
    shell:
        """
        {input.script} {params.file}
        """
     
rule summarize_dly_files: 
    input:
        bash_script="code/concatenate.tar.sh",
        r_script="code/CC251.R",
        tarball="data/ghcnd_all.tar.gz"
    output:
        "data/ghcnd_tidy.tsv.gz"  
    shell:
         """
         {input.bash_script}
         """
rule aggregate_stations:
	input:
		r_script="code/CC253.R",
		data="data/ghcnd-stations.txt"
	output:
		"data/ghcnd_regions.tsv"
	shell:
		"""
		{input.r_script}
		"""


rule get_regions_years:
	input:
		r_script = "code/get_regions_years.R",
		data = "data/ghcnd-inventory.txt"
	output:
		"data/ghcnd_regions.tsv"
	shell:
		"""
		{input.r_script}
		"""



rule plot_drought_by_region:
	input:
		r_script = "code/RR258.R",
		prcp_data ="data/ghcnd_tidy.tsv.gz",
		station_data = "data/ghcnd_regions.tsv"
 
	output:
		"figures/world_drought.png"

	shell:
		"""
		{input.r_script}
		"""


rule render_index:
	input:
		rmd = "index.Rmd",
		png = "visuals/world_drought/png"
	output:
		"index.html"
	shell:
		"""
		R -e "library(rmarkdown); render('{input.rmd}')"
		"""