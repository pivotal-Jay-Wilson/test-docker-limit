set -e

TOKEN=$(curl --user "${USERNAME}:${PASSWORD}" "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
echo "token = ${TOKEN}"
ratelimit=$(curl --head -H "Authorization: Bearer ${TOKEN}" "https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest"  | grep RateLimit)
echo "${ratelimit}"
