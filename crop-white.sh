#!/bin/bash
for pdf in *.pdf; do
    output="cropped_${pdf}"
    pdfcrop "$pdf" "$output"
    echo "Cropped $pdf to $output"
done
