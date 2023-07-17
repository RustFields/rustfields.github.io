#!/bin/bash

DIAGRAMS_DIR=./assets/puml
IMAGES_DIR=./assets/images

wget https://github.com/plantuml/plantuml/releases/download/v1.2023.10/plantuml-1.2023.10.jar

for DIAGRAM in ${DIAGRAMS_DIR}/* ; do
    java -jar ./plantuml-1.2023.10.jar ${DIAGRAM}
done
mv ${DIAGRAMS_DIR}/*.png ${IMAGES_DIR}
