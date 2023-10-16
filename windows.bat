@echo off

rem Export all databases to individual JSON files
for /f %%d in ('mongosh --quiet --eval "db.adminCommand('listDatabases').databases.forEach(function(d) { print(d.name) })"') do (
    for /f %%c in ('mongosh %%d --quiet --eval "db.getCollectionNames()[0]"') do (
        mongoexport --db %%d --collection %%c --out "C:\%%d.json" --jsonArray
        echo Exported %%d to "C:\%%d.json"
    )
)

echo All databases exported successfully.
PAUSE
