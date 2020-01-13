# onchain-shard

Crystal client for onchain generated from the swagger/open-api definition.

## Installation

Add onchain-shard to your shards.yml

## Usage

TODO: Write usage instructions here

## Development

Get latest onchain.yml swagger file.

`docker run -v %cd%:/src ianpurton/crystal-openapi-codegen:latest /src/onchain.yml /src/`

## Run the tests

export ONCHAIN_API_KEY=YOUR_KEY && crytal spec