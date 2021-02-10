FROM golang as builder
COPY . /src
RUN cd /src/cmd && go build -o turbostress

FROM debian:buster
RUN apt-get update && apt-get install -qqy stress-ng linux-cpupower
COPY --from=builder /src/cmd/turbostress /turbostress
ENTRYPOINT ["/turbostress"]