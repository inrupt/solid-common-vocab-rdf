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
npm_config_registry=https://verdaccio.inrupt.com/ npx @solid/lit-artifact-generator generate --vocabListFile Vocab-List-Solid-Common.yml --noprompt --publish localMaven, localNpmNode --force
cd ..

cd Component
npm_config_registry=https://verdaccio.inrupt.com/ npx @solid/lit-artifact-generator generate --inputResources SolidComponent.ttl  --noprompt --runNpmInstall --force
cd ..

cd GeneratorUi
npm_config_registry=https://verdaccio.inrupt.com/ npx @solid/lit-artifact-generator generate --inputResources SolidGeneratorUi.ttl  --noprompt --runNpmInstall --force
cd ..

#
# This section assumes you DO have the LIT Artifact Generator installed
# globally, and so use it directly to generate artifacts locally.
#
#cd Common
#lit-artifact-generator generate --vocabListFile Vocab-List-Solid-Common.yml --noprompt --publish localMaven, localNpmNode --force
#cd ..
#
#cd Component
#lit-artifact-generator generate --inputResources SolidComponent.ttl  --noprompt --runNpmInstall --force
#cd ..
#
#cd GeneratorUi
#lit-artifact-generator generate --inputResources SolidGeneratorUi.ttl  --noprompt --runNpmInstall --force
#cd ..
