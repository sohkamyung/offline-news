import re
import pprint
import codecs

from bs4 import BeautifulSoup
from bs4 import UnicodeDammit

debugDbg = 0
infoDbg = 1

sectionsToIgnore = ( "economic and financial indicators", )
sectionsToOutput = []
articlesToOutput = {}

inputFile = "printedition"
outputFile = "economist-weekly.html"

### read the input data
# inputStream = open(inputFile, mode = 'rb')
inputStream = codecs.open(inputFile, "r", "utf-8")
inputData = inputStream.read()
inputStream.close()
# if debugDbg: print(inputData)

### generate a soup from the data
#oldsoup = UnicodeDammit.detwingle(inputData)
#soup = BeautifulSoup(oldsoup.decode("utf8"))
soup = BeautifulSoup(inputData)
# if debugDbg: soup.prettify()
# if debugDbg: print(soup.original_encoding)
# if debugDbg: print(soup.contains_replacement_characters)

### find section headers
sectionList = soup.find_all("h4")
# if debugDbg: print(sectionList)

### find heading and articles in each section
for section in sectionList:
    div = section.find_next_siblings("div")

    ### check if the section should be ignored
    ignoreSection = 0
    for ignored in sectionsToIgnore:
        if ignored.find(section.string.lower()) != -1:
            if infoDbg: print("Section '" + section.string + "' is ignored")
            ignoreSection = 1
            break
    if ignoreSection:
        continue

    # if debugDbg: print("===")
    # if debugDbg: print(section.string)
    # if debugDbg: print("+++")

    ### find section in the sections to output
    ### if it does not exist, create it
    if section.string in articlesToOutput:
        ### already exsits: add to the current list of articles
        if infoDbg: print("List of articles for '" + section.string + "' already exists: appending to it")
        articleList = articlesToOutput[section.string]
    else:
        ### does not exist: create a new one
        articleList = []
        ### add to the list of sections to output
        sectionsToOutput.append(section.string)

    ### find articles in the section
    for divItem in div:
        itemHeading = divItem.find_previous_sibling("h5")
        article = divItem.a
        if itemHeading and itemHeading.string:
            ### prefix the article title text with the heading
            heading = itemHeading.string
            title = article.string
            article.string.replace_with(heading + ": " + title)

        # add the article to the list of articles
        articleList.append(article)

        # if debugDbg: print(article)

    ### save the list of articles
    articlesToOutput[section.string] = articleList

    # if debugDbg: print("---")

### convert urls to the ones we want
for key in articlesToOutput.keys():
    for article in articlesToOutput[key]:
        ### remove the class
        del article["class"]
        ### prepend "http://www.economist.com",
        ### append "/print"
        url = article["href"]
        article["href"] = "http://www.economist.com" + url + "/print"

if debugDbg: print(sectionsToOutput)
if debugDbg: pp = pprint.PrettyPrinter(); pp.pprint(articlesToOutput)

### now generate the new output file
outputTemplate = '''<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-type" />
<title>The Economist</title>
</head>
<body>
<h1>The Economist</h1>
</body>
</html>'''

output = BeautifulSoup(outputTemplate)

body = output.body

### for each section, output the header and the list of articles
for section in sectionsToOutput:
    ### add section to body as a <p> tag to the output
    para = output.new_tag("p")
    para.append(section)
    body.append(para)

    ### add a <ul> tag
    ul = output.new_tag("ul")
    body.append(ul)

    ### add the articles to the <ul>
    for article in articlesToOutput[section]:
        ### create a <li> tag
        li = output.new_tag("li")
        ### add the article to the <li> tag
        li.append(article)
        ### add the <li> to the <ul> tag
        ul.append(li)

if debugDbg: print(output.prettify())

outputStream = open(outputFile, mode = 'w')
outputStream.write(output.prettify())
outputStream.close()
