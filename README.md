# UK species designations (static) API

## Overview

Species receive designations based on all sorts of critera. For example, being an endangered species. This information is captured in a spreadsheet maintained by the [JNCC (Joint Nature Conservation Committee)](https://jncc.gov.uk/). This data is made available in an Excel spreadsheet: https://hub.jncc.gov.uk/assets/478f7160-967b-4366-acdf-8941fd33850b

This data being available in a spreadsheet is great but not as easy to access for web apps or R code. This repository provides alternative ways to access this valuable data in the following forms:
 * A 'static' API - which is essentially a conversion of the excel spread sheet into JSON formatted data which is hosted using github pages.
 * Static web pages - taking the JSON data making it into human readable

Contains JNCC/NE/NRW/SNH/NIEA data © copyright and database right 2022


## Static API

A static API is essentially just web hosted JSON files. You acccess the API 'endpoints' by entering the web address of the JSON file, including the file extension. If there file does not exist you will not get a JSON proper status code response, simply a HTML webpage that says '404'. The json files are hosted through GitHub pages.

### Species list

This file includes a full species list with summary information such as when the most recent designation was made on each species. The current web address of this file is:

https://simonrolph.github.io/UK_species_designations_api/api_v1/taxa.json

### Taxon 'endpoint'

Each taxon has a JSON file containing the target species' designations. For example for the taxon *Pipistrellus pipistrellus* the .json file is located at:

https://simonrolph.github.io/UK_species_designations_api/api_v1/taxon/pipistrellus_pipistrellus.json

## Webpages

The html files are hosted through GitHub pages. For example for the taxon *Pipistrellus pipistrellus* the .html file is located at:

https://simonrolph.github.io/UK_species_designations_api/view/pipistrellus_pipistrellus.html

## Contribution

Please raise an issue with any bugs / feature suggestions etc.
