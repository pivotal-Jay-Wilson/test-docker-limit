# Test Docker Hubs New Rate limit with Concourse

This change should help to stop pipleines from hitting the [Docker Rate limit](https://www.docker.com/increase-rate-limits)

To run you need to put a credentials.yml in the root withg yopur docker name and password.
```
username: <docker user>
password: <docker password>
```


The pipelines both read from the Docker Hub api to find the rate limit of the logged in user:
```
RateLimit-Limit: 200;w=21600
RateLimit-Remaining: 198;w=21600
```
The registry-image pipeline has the following added to the top of the pipeline to re-define registry-image as a custom resource type. 
```
- name: registry-image
  type: registry-image
  source:
    repository: concourse/registry-image-resource
    tag: 0.14.0
```
When the registry-image pipeline is run consecutively it should not decrement the RateLimit-Remaining unless it needs to download a new docker image.

When the docker-image type is used the RateLimit-Remaining should decrement every time.
