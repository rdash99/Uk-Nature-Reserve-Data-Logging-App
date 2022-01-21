import json
# for each item in the geojson file, print the name of the item from the properties

with open("assets/uk3.json") as f:
    data = json.load(f)
    for feature in data["features"]:
        print("MapModel(" + '"' + feature["properties"]["LAD21NM"] + '"'+"),")
