# I don't like that we expand the enums, so let's replace them.
sed -e 's/$ref.*coin.*/type: string/g' onchain.yml > onchain.edited.yml

api-spec-converter onchain.edited.yml --from=openapi_3 --to=swagger_2 --syntax=yaml > onchain-swagger-v2.yaml
rm onchain.edited.yml