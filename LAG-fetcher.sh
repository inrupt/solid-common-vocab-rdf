git clone git@github.com:inrupt/lit-artifact-generator-js.git

# Not sure why this might be needed - need to ask Jarlath...?!
#git -C lit-artifact-generator-js/ checkout -- package-lock.json

# Why would I need this if I just cloned...?!
git -C lit-artifact-generator-js/ pull origin master

cd lit-artifact-generator-js
#rm package-lock.json
npm install
cd ..
