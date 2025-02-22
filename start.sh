#!/bin/bash

# Function to gracefully stop the server
graceful_shutdown() {
  echo "Shutting down the PaperMC server..."
  # Send the 'stop' command to the server to allow for a graceful shutdown
  screen -S papermc -p 0 -X stuff "stop$(echo -ne '\r')"
  # Wait for the server to fully stop
  sleep 10
  echo "Server stopped gracefully."
}

# Trap SIGTERM and SIGINT (Ctrl+C) signals and call graceful_shutdown
trap graceful_shutdown SIGTERM SIGINT

# Start the PaperMC server in the background using screen or nohup
# Using screen to keep the server running even if the container is stopped
screen -dmS papermc java -Xms6144M -Xmx6144M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper.jar nogui -W worlds

# Wait forever (keeps the script running so the trap can catch signals)
while true; do
  sleep 1
done