./gradlew assembleDebug -PbuildNo=$BUILD_NUMBER
dir=$WORKSPACE
mappingDir=$JOB_NAME"-mapping"
echo "$mappingDir"
echo "pipeline name: "$JOB_NAME
cd ..
mkdir "$mappingDir"
cp "$dir"/app/build/outputs/mapping/debug/mapping.txt ./"$mappingDir"/"$BUILD_NUMBER"-mappging.txt