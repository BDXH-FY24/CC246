rule targets:
    input:
        "data/ghcnd_all.tar.gz",
        "data/ghcnd-inventory.txt",
        "data/ghcnd-stations.txt",
        "data/ghcnd_all_files.txt",
        "data/ghcnd_tidy.tsv.gz"


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
     
rule conatenate_dly_files: 
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