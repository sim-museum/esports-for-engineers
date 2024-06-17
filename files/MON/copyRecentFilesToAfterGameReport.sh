# copy .pbn files created in the last 2 hours to afterGameReport
# note: you must manually copy screenshot pngs in ~/Pictures to ./afterGameReport manually.
find . -name "*.pbn" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
rm afterGameReport/precedent.pbn 2>/dev/null 1>/dev/null

