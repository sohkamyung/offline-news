#! /bin/bash

# curl_options=--proxy ''

url_base="http://spectrum.ieee.org"

### append '/0' to the provided url to get the full article
full_article_url="${1}/0"
#echo ${full_article_url}

article_dir=$(basename $(echo ${1}))
#echo ${article_dir}

article_name=${article_dir}.html
#echo ${article_name}

mkdir ${article_dir}
cd ${article_dir}

echo "Getting ${1} -> ${article_dir}/${article_name}"

command="curl ${curl_options} ${full_article_url} -o ${article_name}"
#echo ${command}
${command}

# get related images, if any
regex1='/image/[0-9]*'
regex2='/img/[a-zA-Z0-9_-]*\.jpg'

images1=$(grep --only-matching ${regex1} ${article_name})
images2=$(grep --only-matching ${regex2} ${article_name})
#echo ${images1}
#echo ${images2}

for image in ${images1} ${images2}
do
    img_file=$(basename ${image})
    url="${url_base}${image}"
    echo "Getting ${url} -> ${article_dir}/${img_file}"
    curl ${curl_options} ${url} -o ${img_file}
done

# modify url to point to the downloaded images
fileregex1='s|/image/||g'
fileregex2='s|/img/||g'

sed "${fileregex1}" "${article_name}" > "${article_name}-temp1"
sed "${fileregex2}" "${article_name}-temp1" > "${article_name}-temp2"

mv ${article_name}-temp2 ${article_name}
rm ${article_name}-temp*

cd ..
