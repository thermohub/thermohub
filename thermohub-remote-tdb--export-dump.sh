#!/bin/bash

#____________________________________[+]_ARANGODB_EXPORT_DATA

# ArangoDB Shell Configuration
# https://www.arangodb.com/docs/3.6/programs.html

	# Access credentials
	serverEndpoint=ssl://db.thermohub.net:443
	userName=exportrem
	userPassword="Read-Only-Export-Remote-ThermoHub"
	# Seed data 'hub_main' database
    databaseName="hub_main"

    # Vertice collections output-directory to export (file names will be the same as collection names)
    mkdir -p "$(pwd)/arangodb/hub_main_remote_export/vertices"
    folderVertices="$(pwd)/arangodb/hub_main_remote_export/vertices"
    
    # Edge collections output-directory to export (file names will be the same as collection names)
    mkdir -p "$(pwd)/arangodb/hub_main_remote_export/edges"
    folderEdges="$(pwd)/arangodb/hub_main_remote_export/edges"

	# Vertice collections output-directory to dump
    mkdir -p "$(pwd)/arangodb/hub_main_remote_dump"
    folderDump="$(pwd)/arangodb/hub_main_remote_dump"

	# Export documents from collections to json files
	# https://www.arangodb.com/docs/3.6/programs-arangoexport.html

	# Vertex collections 

		arangoexport \
		--server.endpoint "${serverEndpoint}" \
		--server.username "${userName}" \
		--server.password "${userPassword}" \
		--server.database "${databaseName}" \
        --output-directory "${folderVertices}" \
		--type json \
		--collection "datasources" \
		--collection "elements" \
		--collection "reactions" \
		--collection "reactionsets" \
		--collection "substances" \
		--collection "thermodatasets" \
		--overwrite true	

	# Edge collections 
	
        arangoexport \
		--server.endpoint "${serverEndpoint}" \
		--server.username "${userName}" \
		--server.password "${userPassword}" \
		--server.database "${databaseName}" \
        --output-directory "${folderEdges}" \
		--type json \
        --collection "basis" \
		--collection "citing" \
		--collection "defines" \
		--collection "master" \
		--collection "prodreac" \
		--collection "product" \
		--collection "pulls" \
        --collection "takes" \
		--overwrite true

	# Dump documents from collections to json files
	# https://www.arangodb.com/docs/3.6/programs-arangodump.html

	# Vertex collections 

		arangodump \
		--server.endpoint "${serverEndpoint}" \
		--server.username "${userName}" \
		--server.password "${userPassword}" \
		--server.database "${databaseName}" \
        --output-directory "${folderDump}" \
		--overwrite true

    # Execute script to get the latest thermodatasets in thermofun format
    source ~/miniconda3/etc/profile.d/conda.sh
    
	conda activate thermohub

	cd thermofun
	
	python3 ../thermohub-remote-tdb--export-thermofun.py
		
#____________________________________[-]_ARANGODB_EXPORT_DATA
