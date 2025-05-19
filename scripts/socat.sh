#!/bin/sh
# Expose both ports: 11434 (Ollama) and 3000 (Open WebUI)

socat TCP-LISTEN:11434,fork,reuseaddr TCP:ollama:11434 &
wait
