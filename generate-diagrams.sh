#!/bin/bash

DIAGRAMS_DIR=./assets/puml
IMAGES_DIR=./assets/images

for DIAGRAM in ${DIAGRAMS_DIR}/* ; do
    plantuml ${DIAGRAM}
done
mv ${DIAGRAMS_DIR}/*.png ${IMAGES_DIR}
