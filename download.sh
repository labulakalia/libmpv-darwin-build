#!/bin/bash
set -e
name=""
version=""
url=""
sha256=""
ext=""

# down file is not exist
download_file() {
    url=$1
    filepath=$2
    sha256=$3
    if [ ! -f "$filepath" ]; then
        echo "Downloading $filepath..."
        curl -L -o $filepath $url
        if [ $? -ne 0 ]; then
            echo "Failed to download $filepath"
            exit 1
        fi
        if [ "$sha256" != $(sha256sum $filepath | awk '{print $1}') ];then
            echo "sha256 check failed,need: $sha256,got: $(sha256sum $filepath | awk '{print $1}')"
            exit 1
        fi
    fi
}

downloadDep() {
    while IFS= read -r line; do
        if [[ $name == "" ]];then
            name=$(echo $line | awk -F':' '{print $1}')
        else
            if echo $line | grep -q "version";then
                version=$(echo $line | awk -F':' '{print $2}'|sed 's/ //g' | sed 's/"//g')
            fi
            if echo $line | grep -q "url";then
                url=$(echo $line | awk -F':' '{print $2":"$3}'|sed 's/ //g')
                ext=$(echo $url | awk -F'.' '{print $(NF-1)"."$NF}')
            fi
            if echo $line | grep -q "sha256";then
                sha256=$(echo $line | awk -F':' '{print $2}')
                download_file $url $dest_dir/${name}-${version}.$ext $sha256
                name=""
                version=""
                url=""
                sha256=""
                ext=""
            fi
        fi
    done < $1
}

dest_dir=$2
downloadDep downloads.lock $dest_dir
