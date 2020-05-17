git clone git@github.com:inrupt/lit-artifact-generator-js.git

#git -C lit-artifact-generator-js/ checkout -- package-lock.json

git -C lit-artifact-generator-js/ pull origin master
#git -C lit-rdf-vocab/ pull origin master
#git -C solid-rdf-vocab/ pull origin master
#git -C inrupt-rdf-vocab/ pull origin master
#
#git -C lit-java/ pull origin master


cd lit-artifact-generator-js
#rm package-lock.json
npm install
cd ..

#cd lit-java
#./gradlew clean :lit-vocab-term:assemble :lit-vocab-term:publishToMavenLocal
#cd ..

node lit-artifact-generator-js/index.js generate --vocabListFile **/*.yml --force --noprompt

