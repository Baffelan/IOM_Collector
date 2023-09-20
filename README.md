# IOM_Collector

[![Build Status](https://github.com/StirlingSmith/IOM_Collector.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/StirlingSmith/IOM_Collector.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Structure
This package is structured to streamline the process of querying the NewsAPI.org database, to a single function call, which automatically retrieves user keywords and constructs custom queries.

To facilitate this, IOM_Collector contains only 2 functions.

## Installation
IOM_Collector has a hard dependency on WritePostgres. To use this package, the package `WritePostgres.jl` must first be installed.
```julia
using Pkg

Pkg.add("https://github.com/Baffelan/WritePostgres")
```
After this, the package can be installed with.
```julia
Pkg.add("https://github.com/Baffelan/IOM_Collector")
```

## Exported Functions

```Julia

```

# Config
This package uses environment variables to access remote postgreSQL servers.

The required environment variables are:
```julia
IOMFRNTDB="Forward_Facing_DataBase_Name"
IOMFRNTUSER="User1"
IOMFRNTPASSWORD="User1_password"
IOMFRNTHOST="Forward_Facing_Host_Address"
IOMFRNTPORT="Forward_Facing_Port"
```
Note that the forward facing environment variables are used in the `user_from_userid` function, and so are required.

Helpful environment variables are:
```julia
IOMBCKDB="Back_Facing_DataBase_Name"
IOMBCKUSER="User2"
IOMBCKPASSWORD="User2_password"
IOMBCKHOST="Back_Facing_Host_Address"
IOMBCKPORT="Back_Facing_Port"

NEWSAPIKEY="API_KEY"
```