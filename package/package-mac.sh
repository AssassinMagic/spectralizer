#!/bin/sh
# Automatic packaging for mac builds

echo "Preparing 64bit build"
bits="64"

version=$1
data_dir="../data"
project="spectralizer"
arch="mac"
build_location="../../../../build-obs-studio-Qt_5_14_1_5_14_1_temporary-RelWithDebInfo/rundir/RelWithDebInfo/obs-plugins"
build_dir=$project.v$version.$arch

if [ -z "$version" ]; then
	echo "Please provide a version string"
	exit
fi

echo "Creating build directory"
mkdir -p $build_dir/plugin
mkdir -p $build_dir/plugin/bin

echo "Fetching build from $build_location"
cp $build_location/$project.so $build_dir/plugin/bin

echo "Fetching locale from $data_dir"
cp -R $data_dir $build_dir/plugin

echo "Fetching misc files"
cp ../LICENSE $build_dir/LICENSE.txt
cp ./install-mac.sh $build_dir/
echo "Writing version number $version"
sed -i -e "s/@VERSION/$version/g" ./README.txt
mv ./README.txt-e $build_dir/README.txt

echo "Zipping to $project.v$version.$arch.zip"
cd $build_dir
zip -r "../$project.v$version.$arch.zip" ./ 
cd ..

echo "Cleaning up"
rm -rf $build_dir
