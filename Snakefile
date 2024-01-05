rule targets:
    input:
        "data/ghcnd_all.tar.gz",
        "data/ghcnd-inventory.txt",
        "data/ghcnd-stations.txt",
        "data/ghcnd_all_files.txt",
        "data/ghcnd.cat.gz"


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
rule conatenate_dly_files: 
    input:
        script="code/concatenate.tar.sh",
        tarball="data/ghcnd_all.tar.gz"
    output:
        "data/ghcnd.cat.gz"  
    shell:
         """
         {input.script}
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
     