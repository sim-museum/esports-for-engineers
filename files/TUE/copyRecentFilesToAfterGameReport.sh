# copies .rpy replay and .txt setup files files created in the last 2 hours to afterGameReport
# note: any setups exported from the setup manager, and any screenshots in ~/Pictures
# must be manually copied to the afterGameReport directory.
  find ./WP/drive_c/Sierra/GPL/replay -name "*.rpy" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \; 
  find "./WP/drive_c/GPLSecrets/GPL Setup Manager" -name "*.txt" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \; 
  exit 0

