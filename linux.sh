#!/bin/bash

# Export all databases to individual JSON files
for db in $(mongosh --quiet --eval "db.adminCommand('listDatabases').databases.forEach(function(d) { print(d.name) })"); do
    mongoexport --db $db --collection $(mongosh $db --quiet --eval "db.getCollectionNames()[0]") --out /root/backupDB/${db}.json --jsonArray
    echo "Exported $db to /root/backupDB/${db}.json"
done
