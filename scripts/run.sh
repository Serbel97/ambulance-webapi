#!/bin/bash
# Get the command parameter, default to "start"
command=${1:-start}

# Determine the project root directory (parent directory of the script)
PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Set environment variables
export AMBULANCE_API_ENVIRONMENT="Development"
export AMBULANCE_API_PORT="8080"

# Execute the corresponding command
case "$command" in
  start)
    go run "${PROJECT_ROOT}/cmd/ambulance-api-service"
    ;;
  openapi)
    docker run --rm -ti -v "${PROJECT_ROOT}":/local openapitools/openapi-generator-cli generate -c /local/scripts/generator-cfg.yaml
    ;;
  *)
    echo "Unknown command: $command" >&2
    exit 1
    ;;
esac
