#!/bin/sh
#
# Very simple script to execute the LIT Artifact Generator to generate
# artifacts locally from the vocabs we reference.
#
# These commands default to outputting the artifacts in the current directory,
# which can be overwritten with the '-o' (--outputDirectory) command-line
# switch.
#

#
# This section assumes you do NOT have the LIT Artifact Generator installed
# globally,and so uses NPX to run it locally without nay installation. We need
# to provide the Inrupt registry as an environment variable to locate the
# correct instance.
#
cd Common
npm_config_registry=https://verdaccio.inrupt.com/ npx @inrupt/solid-common-artifact-generator generate --vocabListFile Vocab-List-LIT-Common.yml --noprompt --publish localMaven, localNpmNode --force
cd ..

cd Core
npm_config_registry=https://verdaccio.inrupt.com/ npx @inrupt/solid-common-artifact-generator generate --vocabListFile Vocab-List-LIT-Core.yml --noprompt --publish localMaven, localNpmNode --force
cd ..

#
# This section assumes you DO have the LIT Artifact Generator installed
# globally (i.e. if you cloned the repo and ran 'npm install -g'), and so can
# use it directly to generate artifacts locally.
#
#cd Common
#lit-artifact-generator generate --vocabListFile Vocab-List-LIT-Common.yml --noprompt --publish localMaven, localNpmNode --force
#cd ..
#
#cd Core
#lit-artifact-generator generate --vocabListFile Vocab-List-LIT-Core.yml --noprompt --publish localMaven, localNpmNode --force
#cd ..
